import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'persistent_cache.dart';
import 'prefs_provider.dart';
import 'ui_state_storage.dart';

/// Per-room message cap. Keeping more than this rarely helps the user
/// (the UI loads 200 at a time anyway) and the long tail bloats disk.
/// Not user-facing — tune in code.
const int kMaxMessagesPerRoom = 1000;

/// Posts whose detail body hasn't been viewed in this window are
/// candidates to have their detailJson (comments etc.) dropped. The
/// summary fragment stays so the feed still renders.
const Duration kInactivePostDetailTtl = Duration(days: 30);

/// Rooms whose detail hasn't been opened in this window have their
/// message log dropped; the room stub stays so the room list still
/// shows it.
const Duration kInactiveRoomMessagesTtl = Duration(days: 30);

/// Eviction policy. Runs:
///   * once on app start (after the auth gate clears),
///   * after every cache write (cheap path: only inspects bytes),
///   * when the user changes the budget in settings.
class CacheEvictor {
  CacheEvictor(this._db, this._storage);

  final CacheDatabase _db;
  final UiStateStorage _storage;

  /// Run all eviction passes in order. Cheap to call repeatedly — most
  /// passes are no-ops when there's nothing to evict.
  Future<void> evict() async {
    final budget = _storage.readCacheMaxBytes();
    await _trimMessagesPerRoom();
    await _expireInactiveMessages();
    await _expireInactivePostDetails();
    await _enforceBudget(budget);
  }

  /// Lightweight check called from hot write paths. Skips the per-room
  /// and TTL passes; only runs the byte-budget pass when over budget.
  Future<void> evictIfOverBudget() async {
    final budget = _storage.readCacheMaxBytes();
    final total = await _db.totalByteSize();
    if (total <= budget) return;
    await _enforceBudget(budget);
  }

  Future<void> _trimMessagesPerRoom() async {
    // For each room with more than the cap, delete the oldest excess.
    final rooms = await _db.customSelect(
      'SELECT room_id, COUNT(*) AS cnt FROM cached_messages '
      'GROUP BY room_id HAVING cnt > ?',
      variables: [Variable.withInt(kMaxMessagesPerRoom)],
      readsFrom: {_db.cachedMessages},
    ).get();
    for (final row in rooms) {
      final roomId = row.data['room_id'] as String;
      final cnt = row.data['cnt'] as int;
      final excess = cnt - kMaxMessagesPerRoom;
      // Delete the [excess] oldest rows in this room.
      await _db.customStatement(
        'DELETE FROM cached_messages WHERE rowid IN ('
        '  SELECT rowid FROM cached_messages '
        '  WHERE room_id = ? '
        '  ORDER BY created_at_ms ASC '
        '  LIMIT ?'
        ')',
        [roomId, excess],
      );
    }
  }

  Future<void> _expireInactiveMessages() async {
    final cutoff = DateTime.now()
        .subtract(kInactiveRoomMessagesTtl)
        .millisecondsSinceEpoch;
    // Drop messages for rooms whose room row hasn't been touched in TTL.
    await _db.customStatement(
      'DELETE FROM cached_messages WHERE room_id IN ('
      '  SELECT id FROM cached_rooms WHERE last_viewed_at_ms < ?'
      ')',
      [cutoff],
    );
  }

  Future<void> _expireInactivePostDetails() async {
    final cutoff =
        DateTime.now().subtract(kInactivePostDetailTtl).millisecondsSinceEpoch;
    // Drop detailJson (and shrink byteSize back to summary length) for
    // posts whose detail hasn't been viewed in TTL. Summary stays so
    // the feed still renders.
    final stale = await (_db.select(_db.cachedPosts)
          ..where((p) =>
              p.lastViewedAtMs.isSmallerThanValue(cutoff) &
              p.detailJson.isNotNull()))
        .get();
    for (final row in stale) {
      await (_db.update(_db.cachedPosts)..where((p) => p.id.equals(row.id)))
          .write(CachedPostsCompanion(
        detailJson: const Value(null),
        byteSize: Value(row.summaryJson.length),
      ));
    }
  }

  Future<void> _enforceBudget(int budget) async {
    var total = await _db.totalByteSize();
    if (total <= budget) return;

    // Step 1: drop oldest inactive post detail blobs first (preserve
    // summaries so the feed still renders).
    final postsWithDetail = await (_db.select(_db.cachedPosts)
          ..where((p) => p.detailJson.isNotNull())
          ..orderBy([(p) => OrderingTerm.asc(p.lastViewedAtMs)]))
        .get();
    for (final p in postsWithDetail) {
      if (total <= budget) return;
      final detailLen = p.detailJson?.length ?? 0;
      if (detailLen == 0) continue;
      await (_db.update(_db.cachedPosts)..where((q) => q.id.equals(p.id)))
          .write(CachedPostsCompanion(
        detailJson: const Value(null),
        byteSize: Value(p.summaryJson.length),
      ));
      total -= detailLen;
    }

    // Step 2: drop messages from oldest-viewed rooms.
    final rooms = await (_db.select(_db.cachedRooms)
          ..orderBy([(r) => OrderingTerm.asc(r.lastViewedAtMs)]))
        .get();
    for (final r in rooms) {
      if (total <= budget) return;
      final bytes = await _db.customSelect(
        'SELECT COALESCE(SUM(byte_size), 0) AS s FROM cached_messages '
        'WHERE room_id = ?',
        variables: [Variable.withString(r.id)],
        readsFrom: {_db.cachedMessages},
      ).getSingle();
      final roomMsgBytes = bytes.data['s'] as int;
      if (roomMsgBytes == 0) continue;
      await (_db.delete(_db.cachedMessages)
            ..where((m) => m.roomId.equals(r.id)))
          .go();
      total -= roomMsgBytes;
    }

    // Step 3: as a last resort, drop entire posts (and their tag-feed
    // entries) in lastViewedAt order, preserving any tag header rows
    // so the feed pane still has a title.
    final colds = await (_db.select(_db.cachedPosts)
          ..orderBy([(p) => OrderingTerm.asc(p.lastViewedAtMs)]))
        .get();
    for (final p in colds) {
      if (total <= budget) return;
      await (_db.delete(_db.cachedTagFeed)..where((f) => f.postId.equals(p.id)))
          .go();
      await (_db.delete(_db.cachedPosts)..where((q) => q.id.equals(p.id))).go();
      total -= p.byteSize;
    }
  }
}

final cacheEvictorProvider = Provider<CacheEvictor>((ref) {
  return CacheEvictor(
    ref.watch(cacheDatabaseProvider),
    ref.watch(uiStateStorageProvider),
  );
});

/// Fires the cheap budget pass after each cache write. Riverpod-side
/// callers can `ref.read(cacheEvictorProvider).evictIfOverBudget()`
/// directly; this provider exists so a future write-batching layer can
/// debounce calls.
final cacheBudgetCheckerProvider = Provider<Future<void> Function()>((ref) {
  final evictor = ref.watch(cacheEvictorProvider);
  return evictor.evictIfOverBudget;
});

/// Reactive view of the user's cache budget setting. Settings UI binds
/// to this; the evictor reads the raw value from storage on each pass.
class CacheMaxBytesNotifier extends Notifier<int> {
  @override
  int build() {
    return ref.watch(uiStateStorageProvider).readCacheMaxBytes();
  }

  Future<void> set(int bytes) async {
    final storage = ref.read(uiStateStorageProvider);
    await storage.writeCacheMaxBytes(bytes);
    state = storage.readCacheMaxBytes();
    // Run a full eviction pass so a tightening change takes effect now
    // rather than on the next write.
    unawaited(ref.read(cacheEvictorProvider).evict());
  }
}

final cacheMaxBytesProvider =
    NotifierProvider<CacheMaxBytesNotifier, int>(CacheMaxBytesNotifier.new);

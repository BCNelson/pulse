import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../graphql/operations/__generated__/chat.data.gql.dart';
import 'persistent_cache.dart';

/// Domain accessor on top of [CacheDatabase] for chat rooms and their
/// time-ordered message logs. Stores [GChatRoomSummaryData] and
/// [GMessageSummaryData] as JSON; reads reconstruct typed objects.
class ChatCacheStore {
  ChatCacheStore(this._db);

  final CacheDatabase _db;

  /// Stream the (room, messages) view for a single room. Messages are
  /// ordered by createdAt ascending (oldest → newest), matching how the
  /// UI renders them.
  Stream<CachedChatRoom> watchRoom(String roomId) {
    final roomQuery = _db.select(_db.cachedRooms)
      ..where((r) => r.id.equals(roomId));
    final messagesQuery = _db.customSelect(
      'SELECT payload_json AS pj '
      'FROM cached_messages '
      'WHERE room_id = ? '
      'ORDER BY created_at_ms ASC, id ASC',
      variables: [Variable.withString(roomId)],
      readsFrom: {_db.cachedMessages},
    );

    final roomStream = roomQuery.watchSingleOrNull();
    final messagesStream = messagesQuery.watch();

    return _combineLatest2(roomStream, messagesStream, (room, rows) {
      final messages = <GMessageSummaryData>[];
      for (final r in rows) {
        final pj = r.data['pj'] as String?;
        if (pj == null) continue;
        final decoded = GMessageSummaryData.fromJson(
            jsonDecode(pj) as Map<String, dynamic>);
        if (decoded != null) messages.add(decoded);
      }
      GChatRoomSummaryData? summary;
      if (room != null) {
        summary = GChatRoomSummaryData.fromJson(
          jsonDecode(room.summaryJson) as Map<String, dynamic>,
        );
      }
      return CachedChatRoom(summary: summary, messages: messages);
    });
  }

  /// Upsert room metadata. Called whenever ChatRoomDetail or
  /// CreateChatRoom returns.
  Future<void> upsertRoomSummary(GChatRoomSummaryData summary) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final json = jsonEncode(summary.toJson());
    final existing = await (_db.select(_db.cachedRooms)
          ..where((r) => r.id.equals(summary.id)))
        .getSingleOrNull();
    await _db.into(_db.cachedRooms).insertOnConflictUpdate(
          CachedRoomsCompanion(
            id: Value(summary.id),
            summaryJson: Value(json),
            byteSize: Value(json.length),
            lastViewedAtMs: Value(existing?.lastViewedAtMs ?? now),
            updatedAtMs: Value(now),
          ),
        );
  }

  /// Bulk replace the message set for a room. Used after a full
  /// ChatRoomDetail refetch — the server's `first: 200` window
  /// overwrites the cached tail.
  Future<void> replaceMessages({
    required String roomId,
    required List<({String? cursor, GMessageSummaryData node})> entries,
  }) async {
    await _db.transaction(() async {
      await (_db.delete(_db.cachedMessages)
            ..where((m) => m.roomId.equals(roomId)))
          .go();
      for (final entry in entries) {
        await _insertMessage(roomId, entry.node, cursor: entry.cursor);
      }
    });
  }

  /// Append a single message — used by MessageAdded subscription and
  /// by the SendMessage mutation's response handler. Idempotent: same
  /// id replays as an upsert.
  Future<void> appendMessage({
    required String roomId,
    required GMessageSummaryData node,
  }) {
    return _insertMessage(roomId, node, cursor: null);
  }

  Future<void> _insertMessage(
    String roomId,
    GMessageSummaryData node, {
    required String? cursor,
  }) async {
    final json = jsonEncode(node.toJson());
    final createdAtMs =
        DateTime.tryParse(node.createdAt.value)?.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch;
    await _db.into(_db.cachedMessages).insertOnConflictUpdate(
          CachedMessagesCompanion(
            roomId: Value(roomId),
            id: Value(node.id),
            payloadJson: Value(json),
            byteSize: Value(json.length),
            createdAtMs: Value(createdAtMs),
            cursor: Value(cursor),
          ),
        );
  }

  /// Bump lastViewedAt for the room so eviction TTL treats it as warm.
  Future<void> touchRoom(String roomId) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.cachedRooms)..where((r) => r.id.equals(roomId)))
        .write(CachedRoomsCompanion(lastViewedAtMs: Value(now)));
  }
}

/// Tuple returned by [ChatCacheStore.watchRoom].
class CachedChatRoom {
  CachedChatRoom({required this.summary, required this.messages});
  final GChatRoomSummaryData? summary;
  final List<GMessageSummaryData> messages;
}

Stream<R> _combineLatest2<A, B, R>(
  Stream<A> a,
  Stream<B> b,
  R Function(A, B) combine,
) {
  final controller = StreamController<R>.broadcast();
  late StreamSubscription<A> subA;
  late StreamSubscription<B> subB;
  A? lastA;
  B? lastB;
  var hasA = false;
  var hasB = false;
  void emit() {
    if (hasA && hasB) controller.add(combine(lastA as A, lastB as B));
  }

  controller.onListen = () {
    subA = a.listen((v) {
      lastA = v;
      hasA = true;
      emit();
    }, onError: controller.addError);
    subB = b.listen((v) {
      lastB = v;
      hasB = true;
      emit();
    }, onError: controller.addError);
  };
  controller.onCancel = () async {
    await subA.cancel();
    await subB.cancel();
  };
  return controller.stream;
}

final chatCacheStoreProvider = Provider<ChatCacheStore>((ref) {
  return ChatCacheStore(ref.watch(cacheDatabaseProvider));
});

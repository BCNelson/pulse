import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'instance_id.dart';

part 'persistent_cache.g.dart';

/// CachedTags holds the header fields for a tag (slug/displayName/path)
/// so the feed pane can render its title from cache while the network
/// fetch is in flight. Posts attach to tags via [CachedTagFeed].
@DataClassName('CachedTagRow')
class CachedTags extends Table {
  TextColumn get id => text()();
  TextColumn get slug => text()();
  TextColumn get displayName => text()();
  TextColumn get path => text()();
  IntColumn get lastRefreshedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// CachedTagFeed is the ordered membership list: which post sits at
/// which position in a given tag's feed. Replaced wholesale on every
/// PostsForTag refetch so the order tracks the server.
@DataClassName('CachedTagFeedRow')
class CachedTagFeed extends Table {
  TextColumn get tagId => text()();
  TextColumn get postId => text()();
  IntColumn get position => integer()();
  TextColumn get cursor => text()();

  @override
  Set<Column> get primaryKey => {tagId, postId};
}

/// CachedPosts holds two JSON blobs per post:
///   * [summaryJson] — PostSummary fragment shape, populated from the
///     feed query and from PostChanged subscription events.
///   * [detailJson] — the full PostDetail.post shape (adds tags,
///     comments, myPermissions), populated only after PostDetail has
///     been opened.
///
/// [byteSize] is `length(summary) + length(detail ?? '')` and drives
/// byte-budget eviction. [lastViewedAt] is bumped whenever a UI pane
/// reads the post.
@DataClassName('CachedPostRow')
class CachedPosts extends Table {
  TextColumn get id => text()();
  TextColumn get summaryJson => text()();
  TextColumn get detailJson => text().nullable()();
  IntColumn get byteSize => integer()();
  IntColumn get lastViewedAtMs => integer()();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// CachedRooms holds the per-room metadata (participants, tags, isDM,
/// archivedAt) as a single ChatRoomSummary JSON blob. Messages live in
/// [CachedMessages].
@DataClassName('CachedRoomRow')
class CachedRooms extends Table {
  TextColumn get id => text()();
  TextColumn get summaryJson => text()();
  IntColumn get byteSize => integer()();
  IntColumn get lastViewedAtMs => integer()();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// CachedMessages is an append-only log per room. Each row holds one
/// MessageSummary JSON. [cursor] is set only for server-confirmed
/// messages that came from a paginated fetch; subscription-delivered
/// rows leave it null. Eviction trims oldest rows first.
@DataClassName('CachedMessageRow')
class CachedMessages extends Table {
  TextColumn get roomId => text()();
  TextColumn get id => text()();
  TextColumn get payloadJson => text()();
  IntColumn get byteSize => integer()();
  IntColumn get createdAtMs => integer()();
  TextColumn get cursor => text().nullable()();

  @override
  Set<Column> get primaryKey => {roomId, id};
}

@DriftDatabase(tables: [
  CachedTags,
  CachedTagFeed,
  CachedPosts,
  CachedRooms,
  CachedMessages,
])
class CacheDatabase extends _$CacheDatabase {
  CacheDatabase() : super(_openConnection());

  /// Test-only constructor that accepts a pre-built executor (in-memory
  /// for unit tests).
  CacheDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_tag_feed_pos '
            'ON cached_tag_feed (tag_id, position)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_messages_room_created '
            'ON cached_messages (room_id, created_at_ms DESC)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_posts_last_viewed '
            'ON cached_posts (last_viewed_at_ms)',
          );
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_rooms_last_viewed '
            'ON cached_rooms (last_viewed_at_ms)',
          );
        },
      );

  /// Sum of byteSize across posts + rooms + messages. Used by the
  /// evictor to decide whether the byte budget is exceeded.
  Future<int> totalByteSize() async {
    final post = await customSelect(
      'SELECT COALESCE(SUM(byte_size), 0) AS s FROM cached_posts',
    ).getSingle();
    final room = await customSelect(
      'SELECT COALESCE(SUM(byte_size), 0) AS s FROM cached_rooms',
    ).getSingle();
    final msg = await customSelect(
      'SELECT COALESCE(SUM(byte_size), 0) AS s FROM cached_messages',
    ).getSingle();
    return (post.data['s'] as int) +
        (room.data['s'] as int) +
        (msg.data['s'] as int);
  }

  /// Drops every cached row. Used by the "Clear cache" settings button.
  Future<void> clearAll() async {
    await batch((b) {
      b.deleteWhere(cachedTagFeed, (_) => const Constant(true));
      b.deleteWhere(cachedTags, (_) => const Constant(true));
      b.deleteWhere(cachedMessages, (_) => const Constant(true));
      b.deleteWhere(cachedRooms, (_) => const Constant(true));
      b.deleteWhere(cachedPosts, (_) => const Constant(true));
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${namespacedFile('pulse_cache', 'sqlite')}');
    return NativeDatabase.createInBackground(file);
  });
}

final cacheDatabaseProvider = Provider<CacheDatabase>((ref) {
  final db = CacheDatabase();
  ref.onDispose(db.close);
  return db;
});

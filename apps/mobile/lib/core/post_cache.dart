import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../graphql/operations/__generated__/posts.data.gql.dart';
import 'persistent_cache.dart';

/// Domain accessor on top of [CacheDatabase] for posts and the per-tag
/// feed membership. Stores fragment JSON: [GPostSummaryData] for the
/// feed view, [GPostDetailData_post] for the detail view. Reads
/// reconstruct typed objects via the generated `fromJson` factories.
class PostCacheStore {
  PostCacheStore(this._db);

  final CacheDatabase _db;

  /// Stream the cached post set for a tag as a (tag, posts) tuple.
  /// Order is deterministic (post id) but not meaningful — consumers
  /// apply the active sort/filter mode in Dart.
  Stream<CachedFeed> watchFeed(String tagId) {
    final tagQuery = _db.select(_db.cachedTags)
      ..where((t) => t.id.equals(tagId));
    final feedQuery = _db.customSelect(
      'SELECT p.summary_json AS sj '
      'FROM cached_tag_feed f '
      'JOIN cached_posts p ON p.id = f.post_id '
      'WHERE f.tag_id = ? '
      'ORDER BY p.id',
      variables: [Variable.withString(tagId)],
      readsFrom: {_db.cachedTagFeed, _db.cachedPosts},
    );

    final tagStream = tagQuery.watchSingleOrNull();
    final feedStream = feedQuery.watch();

    return _combineLatest2(tagStream, feedStream, (tag, rows) {
      final posts = <GPostSummaryData>[];
      for (final r in rows) {
        final json = r.data['sj'] as String?;
        if (json == null) continue;
        final decoded =
            GPostSummaryData.fromJson(jsonDecode(json) as Map<String, dynamic>);
        if (decoded != null) posts.add(decoded);
      }
      return CachedFeed(tag: tag, posts: posts);
    });
  }

  /// Emit a stream of the post-detail JSON parsed back into
  /// [GPostDetailData_post]. Returns null until the post is in cache or
  /// only a summary exists.
  Stream<GPostDetailData_post?> watchPostDetail(String postId) {
    final query = _db.select(_db.cachedPosts)
      ..where((p) => p.id.equals(postId));
    return query.watchSingleOrNull().map((row) {
      if (row == null) return null;
      final detail = row.detailJson;
      if (detail != null && detail.isNotEmpty) {
        return GPostDetailData_post.fromJson(
            jsonDecode(detail) as Map<String, dynamic>);
      }
      return null;
    });
  }

  /// Merge a batch of posts into a tag's cached feed. Upserts each
  /// post summary and adds it to the tag's membership without removing
  /// rows for posts the server didn't return — those linger until the
  /// budget evictor reaps them. The displayed order is decided in Dart
  /// by the active sort mode, so `position` is recorded for reference
  /// only.
  Future<void> mergeFeed({
    required String tagId,
    required String slug,
    required String displayName,
    required String path,
    required List<({String cursor, GPostSummaryData node})> entries,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.transaction(() async {
      await _db.into(_db.cachedTags).insertOnConflictUpdate(
            CachedTagsCompanion(
              id: Value(tagId),
              slug: Value(slug),
              displayName: Value(displayName),
              path: Value(path),
              lastRefreshedAtMs: Value(now),
            ),
          );
      var pos = 0;
      for (final entry in entries) {
        final node = entry.node;
        final summaryJson = jsonEncode(node.toJson());
        // Preserve existing detailJson and lastViewedAt by reading first.
        final existing = await (_db.select(_db.cachedPosts)
              ..where((p) => p.id.equals(node.id)))
            .getSingleOrNull();
        final detailJson = existing?.detailJson;
        final byteSize = summaryJson.length + (detailJson?.length ?? 0);
        await _db.into(_db.cachedPosts).insertOnConflictUpdate(
              CachedPostsCompanion(
                id: Value(node.id),
                summaryJson: Value(summaryJson),
                detailJson: Value(detailJson),
                byteSize: Value(byteSize),
                lastViewedAtMs: Value(existing?.lastViewedAtMs ?? now),
                updatedAtMs: Value(now),
              ),
            );
        await _db.into(_db.cachedTagFeed).insertOnConflictUpdate(
              CachedTagFeedCompanion(
                tagId: Value(tagId),
                postId: Value(node.id),
                position: Value(pos),
                cursor: Value(entry.cursor),
              ),
            );
        pos++;
      }
    });
  }

  /// Upsert the full post detail (post + comments + tags + permissions).
  /// Refreshes summary fields from the detail node too — they're a
  /// superset of summary.
  Future<void> upsertPostDetail(GPostDetailData_post post) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final detailJson = jsonEncode(post.toJson());
    final summaryJson = jsonEncode(_extractSummary(post).toJson());
    final byteSize = summaryJson.length + detailJson.length;
    await _db.into(_db.cachedPosts).insertOnConflictUpdate(
          CachedPostsCompanion(
            id: Value(post.id),
            summaryJson: Value(summaryJson),
            detailJson: Value(detailJson),
            byteSize: Value(byteSize),
            lastViewedAtMs: Value(now),
            updatedAtMs: Value(now),
          ),
        );
  }

  /// Upsert just the summary (used by PostChanged subscription events).
  /// Preserves any existing detailJson so the detail view doesn't get
  /// wiped by a feed-level update.
  Future<void> upsertSummary(GPostSummaryData summary) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final summaryJson = jsonEncode(summary.toJson());
    final existing = await (_db.select(_db.cachedPosts)
          ..where((p) => p.id.equals(summary.id)))
        .getSingleOrNull();
    final detailJson = existing?.detailJson;
    final byteSize = summaryJson.length + (detailJson?.length ?? 0);
    await _db.into(_db.cachedPosts).insertOnConflictUpdate(
          CachedPostsCompanion(
            id: Value(summary.id),
            summaryJson: Value(summaryJson),
            detailJson: Value(detailJson),
            byteSize: Value(byteSize),
            lastViewedAtMs: Value(existing?.lastViewedAtMs ?? now),
            updatedAtMs: Value(now),
          ),
        );
  }

  /// Upsert a summary and ensure the post is a member of the given
  /// tag's feed. Used by the `postChanged` subscription so a brand-new
  /// post on a tag pops into the feed view without waiting for the
  /// next refetch. Position is a sentinel — the displayed order is
  /// recomputed in Dart from the sort mode.
  Future<void> upsertSummaryInFeed(String tagId, GPostSummaryData summary) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final summaryJson = jsonEncode(summary.toJson());
    await _db.transaction(() async {
      final existing = await (_db.select(_db.cachedPosts)
            ..where((p) => p.id.equals(summary.id)))
          .getSingleOrNull();
      final detailJson = existing?.detailJson;
      final byteSize = summaryJson.length + (detailJson?.length ?? 0);
      await _db.into(_db.cachedPosts).insertOnConflictUpdate(
            CachedPostsCompanion(
              id: Value(summary.id),
              summaryJson: Value(summaryJson),
              detailJson: Value(detailJson),
              byteSize: Value(byteSize),
              lastViewedAtMs: Value(existing?.lastViewedAtMs ?? now),
              updatedAtMs: Value(now),
            ),
          );
      final existingMembership = await (_db.select(_db.cachedTagFeed)
            ..where((f) => f.tagId.equals(tagId) & f.postId.equals(summary.id)))
          .getSingleOrNull();
      if (existingMembership == null) {
        await _db.into(_db.cachedTagFeed).insert(
              CachedTagFeedCompanion(
                tagId: Value(tagId),
                postId: Value(summary.id),
                position: const Value(-1),
                cursor: const Value(''),
              ),
            );
      }
    });
  }

  /// Bump lastViewedAt so the evictor treats this post as warm. Cheap
  /// no-op if the post isn't in cache yet.
  Future<void> touchPost(String postId) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.update(_db.cachedPosts)..where((p) => p.id.equals(postId)))
        .write(CachedPostsCompanion(lastViewedAtMs: Value(now)));
  }

  /// Insert a new post at the head of every given tag's feed. Used by
  /// the optimistic createPost cache handler; real responses run the
  /// same path with the server-assigned id.
  Future<void> prependPostToTags({
    required GPostSummaryData summary,
    required List<String> tagIds,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final summaryJson = jsonEncode(summary.toJson());
    await _db.transaction(() async {
      await _db.into(_db.cachedPosts).insertOnConflictUpdate(
            CachedPostsCompanion(
              id: Value(summary.id),
              summaryJson: Value(summaryJson),
              detailJson: const Value.absent(),
              byteSize: Value(summaryJson.length),
              lastViewedAtMs: Value(now),
              updatedAtMs: Value(now),
            ),
          );
      for (final tagId in tagIds) {
        // Shift existing entries down by 1, then insert at position 0.
        await _db.customStatement(
          'UPDATE cached_tag_feed SET position = position + 1 '
          'WHERE tag_id = ?',
          [tagId],
        );
        await _db.into(_db.cachedTagFeed).insertOnConflictUpdate(
              CachedTagFeedCompanion(
                tagId: Value(tagId),
                postId: Value(summary.id),
                position: const Value(0),
                cursor: const Value(''),
              ),
            );
      }
    });
  }
}

/// Tuple returned by [PostCacheStore.watchFeed].
class CachedFeed {
  CachedFeed({required this.tag, required this.posts});
  final CachedTagRow? tag;
  final List<GPostSummaryData> posts;
}

/// Construct a [GPostSummaryData] from a [GPostDetailData_post]. The
/// fragment is a subset of the detail node, so this is just a field
/// copy through the generated builder.
GPostSummaryData _extractSummary(GPostDetailData_post post) {
  return GPostSummaryData(
    (b) => b
      ..id = post.id
      ..title = post.title
      ..body = post.body
      ..createdAt.replace(post.createdAt)
      ..editedAt = post.editedAt?.toBuilder()
      ..decisionStatus = post.decisionStatus
      ..denyFlag = post.denyFlag
      ..author.id = post.author.id
      ..author.displayName = post.author.displayName
      ..reactions.replace(
          post.reactions.map((r) => GPostSummaryData_reactions((rb) => rb
            ..emoji = r.emoji
            ..count = r.count
            ..byViewer = r.byViewer)))
      ..comments.edges.replace(
            post.comments.edges.map(
              (e) => GPostSummaryData_comments_edges(
                (eb) => eb
                  ..node.id = e.node.id
                  ..node.createdAt.replace(e.node.createdAt),
              ),
            ),
          ),
  );
}

/// Combine the latest values of two streams. Emits when either source
/// changes, after both have produced at least one value.
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

final postCacheStoreProvider = Provider<PostCacheStore>((ref) {
  return PostCacheStore(ref.watch(cacheDatabaseProvider));
});

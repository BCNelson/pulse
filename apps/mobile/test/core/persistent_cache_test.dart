import 'package:built_collection/built_collection.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/cache_evictor.dart';
import 'package:pulse/core/chat_cache.dart';
import 'package:pulse/core/persistent_cache.dart';
import 'package:pulse/core/post_cache.dart';
import 'package:pulse/core/ui_state_storage.dart';
import 'package:pulse/graphql/__generated__/schema.schema.gql.dart';
import 'package:pulse/graphql/operations/__generated__/chat.data.gql.dart';
import 'package:pulse/graphql/operations/__generated__/posts.data.gql.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PostCacheStore', () {
    late CacheDatabase db;
    late PostCacheStore store;

    setUp(() {
      db = CacheDatabase.forTesting(NativeDatabase.memory());
      store = PostCacheStore(db);
    });

    tearDown(() => db.close());

    test('replaceFeed + watchFeed round-trips post summaries', () async {
      final p1 = _summary(id: 'p1', title: 'first', body: 'one');
      final p2 = _summary(id: 'p2', title: 'second', body: 'two');
      await store.replaceFeed(
        tagId: 'tag1',
        slug: 'tag1',
        displayName: 'Tag 1',
        path: 'tag1',
        entries: [
          (cursor: 'c1', node: p1),
          (cursor: 'c2', node: p2),
        ],
      );

      final feed = await store.watchFeed('tag1').first;
      expect(feed.tag?.displayName, 'Tag 1');
      expect(feed.posts.map((p) => p.id).toList(), ['p1', 'p2']);
      expect(feed.posts.first.title, 'first');
    });

    test('upsertPostDetail stores comments and reads back through watch',
        () async {
      final detail = _postDetail(id: 'p1', commentBodies: ['hello', 'world']);
      await store.upsertPostDetail(detail);

      final fetched = await store.watchPostDetail('p1').first;
      expect(fetched?.id, 'p1');
      expect(fetched?.comments.edges.length, 2);
      expect(fetched?.comments.edges.first.node.body, 'hello');
    });

    test('feed refetch preserves a previously-stored detailJson', () async {
      final detail = _postDetail(id: 'p1', commentBodies: ['keep me']);
      await store.upsertPostDetail(detail);

      // A second feed refetch only carries summaries — detail should
      // not be wiped.
      await store.replaceFeed(
        tagId: 'tag1',
        slug: 'tag1',
        displayName: 'Tag 1',
        path: 'tag1',
        entries: [
          (cursor: 'c1', node: _summary(id: 'p1', title: 'updated', body: 'b'))
        ],
      );

      final fetched = await store.watchPostDetail('p1').first;
      expect(fetched, isNotNull);
      expect(fetched!.comments.edges.first.node.body, 'keep me');
    });

    test('prependPostToTags places a new post at position 0', () async {
      await store.replaceFeed(
        tagId: 'tag1',
        slug: 'tag1',
        displayName: 'Tag 1',
        path: 'tag1',
        entries: [
          (cursor: 'c1', node: _summary(id: 'old1', title: 'a', body: 'a')),
          (cursor: 'c2', node: _summary(id: 'old2', title: 'b', body: 'b')),
        ],
      );
      await store.prependPostToTags(
        summary: _summary(id: 'new1', title: 'fresh', body: 'just in'),
        tagIds: ['tag1'],
      );
      final feed = await store.watchFeed('tag1').first;
      expect(feed.posts.first.id, 'new1');
      expect(feed.posts.length, 3);
    });
  });

  group('ChatCacheStore', () {
    late CacheDatabase db;
    late ChatCacheStore store;

    setUp(() {
      db = CacheDatabase.forTesting(NativeDatabase.memory());
      store = ChatCacheStore(db);
    });

    tearDown(() => db.close());

    test('replaceMessages + watchRoom orders messages chronologically',
        () async {
      await store.upsertRoomSummary(_room(id: 'r1'));
      await store.replaceMessages(roomId: 'r1', entries: [
        (cursor: null, node: _message(id: 'm2', body: 'second', secondsAgo: 5)),
        (cursor: null, node: _message(id: 'm1', body: 'first', secondsAgo: 10)),
      ]);
      final view = await store.watchRoom('r1').first;
      expect(view.messages.map((m) => m.id).toList(), ['m1', 'm2']);
    });

    test('appendMessage is idempotent on duplicate id', () async {
      await store.upsertRoomSummary(_room(id: 'r1'));
      final m = _message(id: 'mx', body: 'hi', secondsAgo: 0);
      await store.appendMessage(roomId: 'r1', node: m);
      await store.appendMessage(roomId: 'r1', node: m);
      final view = await store.watchRoom('r1').first;
      expect(view.messages.length, 1);
    });
  });

  group('CacheEvictor', () {
    late CacheDatabase db;
    late PostCacheStore posts;
    late ChatCacheStore chats;
    late CacheEvictor evictor;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      db = CacheDatabase.forTesting(NativeDatabase.memory());
      posts = PostCacheStore(db);
      chats = ChatCacheStore(db);
      // Set a tiny budget so the test triggers eviction quickly.
      final storage = UiStateStorage(prefs);
      await storage.writeCacheMaxBytes(20 * 1024 * 1024); // floor
      evictor = CacheEvictor(db, storage);
    });

    tearDown(() => db.close());

    test('byte budget drops messages from oldest-viewed rooms', () async {
      // Insert two rooms; one is older (lastViewedAt in the past).
      await chats.upsertRoomSummary(_room(id: 'cold'));
      await chats.upsertRoomSummary(_room(id: 'warm'));
      // Push lastViewedAt for cold room backward.
      await db.customStatement(
        "UPDATE cached_rooms SET last_viewed_at_ms = 1 WHERE id = 'cold'",
      );
      // Stuff each room with bulky messages.
      final pad = 'x' * 4000;
      for (var i = 0; i < 30; i++) {
        await chats.appendMessage(
          roomId: 'cold',
          node: _message(id: 'c$i', body: pad, secondsAgo: 300 - i),
        );
        await chats.appendMessage(
          roomId: 'warm',
          node: _message(id: 'w$i', body: pad, secondsAgo: 300 - i),
        );
      }
      // Force budget to a value below current usage.
      final usage = await db.totalByteSize();
      expect(usage, greaterThan(0));
      // Manually call _enforceBudget via a tiny budget eval: write a
      // smaller budget and run evict.
      SharedPreferences.setMockInitialValues({
        UiStateStorage.cacheMaxBytesKey: usage ~/ 2,
      });
      final prefs = await SharedPreferences.getInstance();
      final tight = CacheEvictor(db, UiStateStorage(prefs));
      await tight.evict();
      // Cold room should have lost its messages first.
      final coldView = await chats.watchRoom('cold').first;
      expect(coldView.messages, isEmpty);
    });

    test('inactive-post TTL drops detailJson but keeps summary', () async {
      final detail = _postDetail(id: 'p1', commentBodies: ['old comment']);
      await posts.upsertPostDetail(detail);
      // Push lastViewedAt back beyond the TTL.
      final cutoff = DateTime.now()
          .subtract(kInactivePostDetailTtl + const Duration(days: 1))
          .millisecondsSinceEpoch;
      await db.customStatement(
        'UPDATE cached_posts SET last_viewed_at_ms = ? WHERE id = ?',
        [cutoff, 'p1'],
      );
      await evictor.evict();
      // Detail should be gone; summary should remain.
      final detailAfter = await posts.watchPostDetail('p1').first;
      expect(detailAfter, isNull);
      final feedSummary = await (db.select(db.cachedPosts)
            ..where((p) => p.id.equals('p1')))
          .getSingle();
      expect(feedSummary.summaryJson, isNotEmpty);
      expect(feedSummary.detailJson, isNull);
    });
  });
}

// ----- helpers -----

GPostSummaryData _summary({
  required String id,
  required String title,
  required String body,
}) {
  return GPostSummaryData(
    (b) => b
      ..id = id
      ..title = title
      ..body = body
      ..createdAt.replace(GTime('2025-01-01T00:00:00Z'))
      ..denyFlag = false
      ..author.id = 'author1'
      ..author.displayName = 'Author One'
      ..reactions.replace(BuiltList<GPostSummaryData_reactions>()),
  );
}

GPostDetailData_post _postDetail({
  required String id,
  required List<String> commentBodies,
}) {
  return GPostDetailData_post(
    (b) => b
      ..id = id
      ..title = 'detail $id'
      ..body = 'detail body $id'
      ..createdAt.replace(GTime('2025-01-01T00:00:00Z'))
      ..denyFlag = false
      ..author.id = 'author1'
      ..author.displayName = 'Author One'
      ..reactions.replace(BuiltList<GPostDetailData_post_reactions>())
      ..tags.replace(BuiltList<GPostDetailData_post_tags>())
      ..comments.edges.replace(
        commentBodies.asMap().entries.map((entry) {
          return GPostDetailData_post_comments_edges(
            (e) => e
              ..node.id = 'c${entry.key}_$id'
              ..node.postId = id
              ..node.depth = 0
              ..node.body = entry.value
              ..node.createdAt.replace(GTime('2025-01-01T00:00:00Z'))
              ..node.author.id = 'author1'
              ..node.author.displayName = 'Author One'
              ..node.reactions
                  .replace(BuiltList<GPostDetailData_post_comments_edges_node_reactions>()),
          );
        }),
      )
      ..myPermissions.canView = true
      ..myPermissions.canContribute = true
      ..myPermissions.canModerate = false,
  );
}

GChatRoomSummaryData _room({required String id}) {
  return GChatRoomSummaryData(
    (b) => b
      ..id = id
      ..isDM = false
      ..createdAt.replace(GTime('2025-01-01T00:00:00Z'))
      ..tags.replace(BuiltList<GChatRoomSummaryData_tags>())
      ..participants.replace(BuiltList<GChatRoomSummaryData_participants>()),
  );
}

GMessageSummaryData _message({
  required String id,
  required String body,
  required int secondsAgo,
}) {
  final created = DateTime.now()
      .toUtc()
      .subtract(Duration(seconds: secondsAgo))
      .toIso8601String();
  return GMessageSummaryData(
    (b) => b
      ..id = id
      ..body = body
      ..createdAt.replace(GTime(created))
      ..author.id = 'author1'
      ..author.displayName = 'Author One',
  );
}

import 'dart:async';
import 'dart:convert';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/cache_evictor.dart';
import '../../core/ferry_client.dart';
import '../../core/post_cache.dart';
import '../../graphql/operations/__generated__/posts.data.gql.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';
import 'feed_settings_controller.dart';

/// Stale-while-revalidate provider for `PostsForTag`. Emits the
/// drift-cached feed immediately, then kicks off a one-shot network
/// fetch that writes its result back to drift (which re-emits via the
/// stream).
final cachedTagFeedProvider =
    StreamProvider.autoDispose.family<CachedFeed, String>(
  (ref, tagId) {
    final store = ref.watch(postCacheStoreProvider);
    final client = ref.watch(ferryClientProvider);
    unawaited(_refetch(ref, client, store, tagId));
    return store.watchFeed(tagId);
  },
);

Future<void> _refetch(
  Ref ref,
  Client client,
  PostCacheStore store,
  String tagId,
) async {
  final req = GPostsForTagReq(
    (b) => b
      ..vars.tagId = tagId
      ..vars.first = 50
      ..fetchPolicy = FetchPolicy.NoCache,
  );
  try {
    final resp = await client.request(req).first;
    if (resp.hasErrors) return;
    final tag = resp.data?.tag;
    if (tag == null) return;
    ref.read(feedSettingsProvider(tagId).notifier).hydrate(
          includeSubTags: tag.myFeedSettings.includeDescendants,
          hasChildren: tag.hasChildren,
        );
    final entries = <({String cursor, GPostSummaryData node})>[];
    for (final e in tag.posts.edges) {
      // Force a true JSON bytes round-trip rather than a same-Dart-VM
      // Map handoff. The response's edge.node type and GPostSummaryData
      // share a fragment shape but use distinct built_value serializers,
      // and on Flutter web the in-memory map values can leak through as
      // LegacyJavaScriptObject — which trips the iterator inside the
      // other type's deserializer. Encode → decode normalizes every
      // value to plain Dart maps/lists.
      final summary = GPostSummaryData.fromJson(
        jsonDecode(jsonEncode(e.node.toJson())) as Map<String, dynamic>,
      );
      if (summary != null) {
        entries.add((cursor: e.cursor, node: summary));
      }
    }
    // Cache-key by the input ref so watchFeed sees the write under the
    // same key it's watching. The caller may pass either the 12-char
    // typed id or a slug path; the backend resolves both, but the cache
    // doesn't need to know — it just needs read and write to agree.
    await store.replaceFeed(
      tagId: tagId,
      slug: tag.slug,
      displayName: tag.displayName,
      path: tag.path,
      entries: entries,
    );
    await ref.read(cacheEvictorProvider).evictIfOverBudget();
  } catch (_) {
    // Network error — keep emitting whatever's in cache. The UI can
    // surface staleness separately if needed.
  }
}

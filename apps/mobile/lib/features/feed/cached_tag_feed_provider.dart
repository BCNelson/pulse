import 'dart:async';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/cache_evictor.dart';
import '../../core/ferry_client.dart';
import '../../core/post_cache.dart';
import '../../graphql/operations/__generated__/posts.data.gql.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';

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
    final entries = <({String cursor, GPostSummaryData node})>[];
    for (final e in tag.posts.edges) {
      final summary = GPostSummaryData.fromJson(e.node.toJson());
      if (summary != null) {
        entries.add((cursor: e.cursor, node: summary));
      }
    }
    await store.replaceFeed(
      tagId: tag.id,
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

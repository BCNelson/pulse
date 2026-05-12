import 'dart:async';

import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/cache_evictor.dart';
import '../../core/ferry_client.dart';
import '../../core/post_cache.dart';
import '../../graphql/operations/__generated__/posts.data.gql.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';

/// SWR provider for `PostDetail($id)`. Emits the cached post (with
/// comments) instantly, then refetches in the background and writes the
/// fresh response back to drift.
final cachedPostDetailProvider =
    StreamProvider.autoDispose.family<GPostDetailData_post?, String>(
  (ref, postId) {
    final store = ref.watch(postCacheStoreProvider);
    final client = ref.watch(ferryClientProvider);
    unawaited(store.touchPost(postId));
    unawaited(_refetch(ref, client, store, postId));
    return store.watchPostDetail(postId);
  },
);

Future<void> _refetch(
  Ref ref,
  Client client,
  PostCacheStore store,
  String postId,
) async {
  final req = GPostDetailReq(
    (b) => b
      ..vars.id = postId
      ..fetchPolicy = FetchPolicy.NoCache,
  );
  try {
    final resp = await client.request(req).first;
    if (resp.hasErrors) return;
    final post = resp.data?.post;
    if (post == null) return;
    await store.upsertPostDetail(post);
    await ref.read(cacheEvictorProvider).evictIfOverBudget();
  } catch (_) {}
}

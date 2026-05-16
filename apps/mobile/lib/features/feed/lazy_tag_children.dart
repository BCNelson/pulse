import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../graphql/operations/__generated__/tag_tree.req.gql.dart';

/// Fetches the next subtree of children for [tagId] (typed Crockford id) via
/// the `TagChildren` GraphQL query. Returns the parent tag's `children`
/// list — see `tag_tree.graphql`. The shape mirrors `TagTree`'s 3 nested
/// `children { ... }` selections, so each fetched subtree carries 3 levels
/// of inline grandchildren before the sidebar widget needs to fetch again.
///
/// Cached per id while at least one widget watches; auto-disposed when the
/// parent collapses. Re-expanding refetches.
final lazyTagChildrenProvider =
    FutureProvider.family<List<dynamic>, String>((ref, tagId) async {
  final client = ref.watch(ferryClientProvider);
  final req = GTagChildrenReq((b) => b..vars.id = tagId);
  final resp = await client.request(req).first;
  if (resp.hasErrors) {
    throw Exception(
      resp.graphqlErrors?.map((e) => e.message).join('\n') ??
          resp.linkException?.toString() ??
          'fetch failed',
    );
  }
  final tag = resp.data?.tag;
  if (tag == null) return const <dynamic>[];
  return tag.children.toList();
});

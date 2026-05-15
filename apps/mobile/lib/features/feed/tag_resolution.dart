import 'package:built_collection/built_collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/router.dart';
import '../../graphql/operations/__generated__/tag_tree.data.gql.dart';
import '../../graphql/operations/__generated__/tag_tree.req.gql.dart';

/// resolvedTagProvider resolves the URL-derived slug path into the
/// backend tag entity. Returns null when no tag exists at the path —
/// the UI shows a "tag not found" state in that case.
///
/// Why a Provider that watches currentTagPathProvider: the router is the
/// single source of truth for selection, and the resolved entity needs to
/// rebuild whenever the URL changes (forward/back navigation, deep links,
/// hand-typed paths).
final resolvedTagProvider =
    StreamProvider.autoDispose<GTagBySlugPathData_tagBySlugPath?>((ref) async* {
  final path = ref.watch(currentTagPathProvider);
  if (path == null) {
    yield null;
    return;
  }
  final client = ref.watch(ferryClientProvider);
  final req = GTagBySlugPathReq(
    (b) => b..vars.path = ListBuilder<String>(path),
  );
  await for (final res in client.request(req)) {
    if (res.hasErrors) {
      // Mirror Ferry's surface: errors propagate; the UI watches the
      // AsyncValue and renders an error pane.
      throw StateError(res.linkException?.toString() ??
          res.graphqlErrors?.map((e) => e.message).join('; ') ??
          'tag resolution failed');
    }
    yield res.data?.tagBySlugPath;
  }
});

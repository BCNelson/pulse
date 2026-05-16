import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/post_cache.dart';
import '../../graphql/operations/__generated__/posts.data.gql.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';

/// Subscribes to `postChanged(tagId)` and writes each event's updated
/// PostSummary into the persistent cache. The drift-backed feed stream
/// re-emits and the UI rebuilds without a full feed re-fetch.
final postChangedListenerProvider =
    StreamProvider.autoDispose.family<GPostChangedData, String>(
  (ref, tagId) {
    final client = ref.watch(ferryClientProvider);
    final store = ref.watch(postCacheStoreProvider);
    final req = GPostChangedReq((b) => b..vars.tagId = tagId);
    final controller = StreamController<GPostChangedData>.broadcast();
    final sub = client.request(req).listen((resp) {
      final data = resp.data;
      if (data == null || resp.hasErrors) return;
      controller.add(data);
      // jsonEncode/Decode trip normalizes any web-runtime JS objects
      // back into Dart maps — see cached_tag_feed_provider for why.
      final summary = GPostSummaryData.fromJson(
        jsonDecode(jsonEncode(data.postChanged.toJson()))
            as Map<String, dynamic>,
      );
      if (summary != null) {
        // Fire-and-forget — the drift watch stream is the source of
        // truth for UI updates. Insert into this tag's feed membership
        // so a brand-new post drops into whichever sort/filter view
        // the user is currently looking at.
        store.upsertSummaryInFeed(tagId, summary);
      }
    });
    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);

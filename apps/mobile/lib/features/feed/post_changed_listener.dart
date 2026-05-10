import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../graphql/operations/__generated__/posts.data.gql.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';

/// Listens to postChanged(tagId) and re-emits the request through ferry
/// so the post list re-fetches on each event. Returns a stream so
/// callers can use ref.listen(...) to fire side effects.
final postChangedListenerProvider =
    StreamProvider.autoDispose.family<GPostChangedData, String>(
  (ref, tagId) {
    final client = ref.watch(ferryClientProvider);
    final req = GPostChangedReq((b) => b..vars.tagId = tagId);
    final controller = StreamController<GPostChangedData>.broadcast();
    final sub = client.request(req).listen((resp) {
      final data = resp.data;
      if (data != null && resp.hasErrors == false) {
        controller.add(data);
        // Re-fire the matching list request so the cache updates.
        // ignore: invalid_use_of_protected_member
        client.requestController.add(
          GPostsForTagReq(
            (b) => b
              ..vars.tagId = tagId
              ..vars.first = 50,
          ),
        );
      }
    });
    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });
    return controller.stream;
  },
);

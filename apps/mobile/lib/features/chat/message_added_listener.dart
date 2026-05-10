import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../graphql/operations/__generated__/chat.req.gql.dart';

/// Subscribes to messageAdded(roomId) and re-fires the room detail
/// query so the message list refreshes from cache.
final messageAddedListenerProvider =
    StreamProvider.autoDispose.family<bool, String>((ref, roomId) {
  final client = ref.watch(ferryClientProvider);
  final controller = StreamController<bool>.broadcast();
  final sub = client
      .request(GMessageAddedReq((b) => b..vars.roomId = roomId))
      .listen((resp) {
    if (resp.data != null && !resp.hasErrors) {
      controller.add(true);
      // ignore: invalid_use_of_protected_member
      client.requestController.add(
        GChatRoomDetailReq((b) => b..vars.id = roomId),
      );
    }
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});

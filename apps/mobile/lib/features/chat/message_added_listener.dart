import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/chat_cache.dart';
import '../../core/ferry_client.dart';
import '../../graphql/operations/__generated__/chat.data.gql.dart';
import '../../graphql/operations/__generated__/chat.req.gql.dart';

/// Subscribes to `messageAdded(roomId)` and appends each new message
/// into the persistent cache. The room's drift watch stream emits and
/// the UI tail-follows without any query re-fire.
final messageAddedListenerProvider =
    StreamProvider.autoDispose.family<bool, String>((ref, roomId) {
  final client = ref.watch(ferryClientProvider);
  final store = ref.watch(chatCacheStoreProvider);
  final controller = StreamController<bool>.broadcast();
  final sub = client
      .request(GMessageAddedReq((b) => b..vars.roomId = roomId))
      .listen((resp) {
    final data = resp.data;
    if (data == null || resp.hasErrors) return;
    final node = GMessageSummaryData.fromJson(data.messageAdded.toJson());
    if (node != null) {
      store.appendMessage(roomId: roomId, node: node);
    }
    controller.add(true);
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});

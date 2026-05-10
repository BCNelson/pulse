import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../graphql/operations/__generated__/notifications.req.gql.dart';

/// Subscribes to notificationReceived for the lifetime of the provider.
/// On every event we re-fire the inbox query so badge + drawer update.
final notificationsListenerProvider = StreamProvider.autoDispose<bool>((ref) {
  final client = ref.watch(ferryClientProvider);
  final controller = StreamController<bool>.broadcast();
  final sub = client.request(GNotificationReceivedReq()).listen((resp) {
    if (resp.data != null && !resp.hasErrors) {
      controller.add(true);
      // ignore: invalid_use_of_protected_member
      client.requestController.add(
        GNotificationsInboxReq(
          (b) => b
            ..vars.first = 50
            ..vars.unreadOnly = false,
        ),
      );
    }
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../graphql/operations/__generated__/notifications.req.gql.dart';
import 'notifications_drawer.dart';
import 'notifications_listener.dart';

class NotificationsButton extends ConsumerWidget {
  const NotificationsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Keep the live listener alive while the button is mounted.
    ref.watch(notificationsListenerProvider);

    final client = ref.watch(ferryClientProvider);
    final req = GNotificationsInboxReq(
      (b) => b
        ..vars.first = 50
        ..vars.unreadOnly = false,
    );
    return StreamBuilder(
      stream: client.request(req),
      builder: (context, snap) {
        final unread = snap.data?.data?.notifications.unreadCount ?? 0;
        return IconButton(
          tooltip: 'Notifications',
          onPressed: () => _open(context),
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_outlined),
              if (unread > 0)
                Positioned(
                  right: -4, top: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      unread > 99 ? '99+' : '$unread',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _open(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const NotificationsDrawer(),
    );
  }
}

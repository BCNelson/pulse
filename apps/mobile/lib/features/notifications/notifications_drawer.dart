import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/selection.dart';
import '../../graphql/operations/__generated__/notifications.data.gql.dart';
import '../../graphql/operations/__generated__/notifications.req.gql.dart';

class NotificationsDrawer extends ConsumerWidget {
  const NotificationsDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    final req = GNotificationsInboxReq(
      (b) => b
        ..vars.first = 50
        ..vars.unreadOnly = false,
    );
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      builder: (_, scroll) => StreamBuilder(
        stream: client.request(req),
        builder: (context, snap) {
          final data = snap.data?.data;
          final edges = data?.notifications.edges.toList() ?? const [];
          return Column(
            children: [
              ListTile(
                title: Text(
                  'Notifications',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                trailing: TextButton(
                  onPressed: () {
                    // ignore: invalid_use_of_protected_member
                    client.requestController.add(GMarkAllNotificationsReadReq());
                  },
                  child: const Text('Mark all read'),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: edges.isEmpty
                    ? const Center(child: Text('Inbox zero. Nice.'))
                    : ListView.separated(
                        controller: scroll,
                        itemCount: edges.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, i) =>
                            _NotificationTile(node: edges[i].node),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NotificationTile extends ConsumerWidget {
  const _NotificationTile({required this.node});

  final GNotificationsInboxData_notifications_edges_node node;

  String get _summary {
    final src = node.source;
    if (src == null) return '${node.sourceType} (no longer visible)';
    return switch (src.G__typename) {
      'Post' => (src as dynamic).title ?? 'Post',
      'Comment' => 'Reply: ${(src as dynamic).body}',
      'Task' => (src as dynamic).title ?? 'Task',
      'Message' => 'Message: ${(src as dynamic).body}',
      _ => node.sourceType,
    };
  }

  IconData get _icon {
    return switch (node.reason.name) {
      'ASSIGNMENT' => Icons.assignment_ind_outlined,
      'MENTION' => Icons.alternate_email_outlined,
      'WATCHER' => Icons.visibility_outlined,
      'TAG_SUBSCRIPTION' => Icons.label_outline,
      'DM' => Icons.forum_outlined,
      _ => Icons.notifications_outlined,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    final isUnread = node.readAt == null;
    return ListTile(
      leading: Icon(_icon),
      title: Text(
        _summary,
        style: TextStyle(
          fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      subtitle: Text(node.reason.name.toLowerCase()),
      trailing: isUnread
          ? Container(
              width: 8, height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            )
          : null,
      onTap: () {
        // Navigate to source.
        if (node.sourceType == 'post') {
          ref.read(selectedPostIdProvider.notifier).state = node.sourceId;
        }
        // Mark read.
        // ignore: invalid_use_of_protected_member
        client.requestController.add(
          GMarkNotificationReadReq((b) => b..vars.ids.add(node.id)),
        );
        Navigator.of(context).pop();
      },
    );
  }
}

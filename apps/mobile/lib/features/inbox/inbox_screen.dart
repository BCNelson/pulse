import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/ferry_client.dart';
import '../../design/atoms/pulse_button.dart';
import '../../design/atoms/pulse_inbox_row.dart';
import '../../design/atoms/pulse_page_head.dart';
import '../../design/atoms/pulse_section_head.dart';
import '../../design/atoms/pulse_segmented.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/__generated__/schema.schema.gql.dart';
import '../../graphql/operations/__generated__/notifications.data.gql.dart';
import '../../graphql/operations/__generated__/notifications.req.gql.dart';
import '../notifications/notifications_listener.dart';
import 'ambient_panel.dart';

const _ambientBreakpoint = 720.0;

enum InboxFilter { all, assigned, mentions, watching, dms }

class _FilterNotifier extends Notifier<InboxFilter> {
  @override
  InboxFilter build() => InboxFilter.all;
  void set(InboxFilter f) => state = f;
}

final inboxFilterProvider =
    NotifierProvider<_FilterNotifier, InboxFilter>(_FilterNotifier.new);

/// The Home / Inbox screen. Personalized landing view answering:
///   1. What needs my attention?
///   2. What's happening in places I care about?
class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Subscribe to inbound notifications so the screen refetches live.
    ref.watch(notificationsListenerProvider);
    return LayoutBuilder(
      builder: (context, c) {
        final wide = c.maxWidth >= _ambientBreakpoint;
        if (!wide) return const _InboxBody();
        return Row(
          children: [
            const Expanded(child: _InboxBody()),
            VerticalDivider(width: 1, color: context.tokens.hair, thickness: 1),
            const SizedBox(width: 320, child: AmbientPanel()),
          ],
        );
      },
    );
  }
}

class _InboxBody extends ConsumerWidget {
  const _InboxBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final client = ref.watch(ferryClientProvider);
    final filter = ref.watch(inboxFilterProvider);
    final req = GNotificationsInboxReq(
      (b) => b
        ..vars.first = 100
        ..vars.unreadOnly = false,
    );
    return Container(
      color: t.paper,
      child: StreamBuilder(
        stream: client.request(req),
        builder: (context, snap) {
          final data = snap.data?.data;
          final all = data?.notifications.edges
                  .map((e) => e.node)
                  .toList(growable: false) ??
              const <GNotificationsInboxData_notifications_edges_node>[];
          final filtered = all.where((n) => _matches(n, filter)).toList();
          final isLoading =
              snap.connectionState == ConnectionState.waiting && data == null;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: PulsePageHead(
                  title: 'Inbox',
                  subtitle: 'what needs you',
                  metaParts: [
                    '${all.where((n) => n.readAt == null).length} unread',
                    '${all.length} total',
                  ],
                  trailing: PulseButton(
                    label: 'Mark all read',
                    icon: Icons.done_all,
                    onPressed: all.any((n) => n.readAt == null)
                        ? () {
                            // ignore: invalid_use_of_protected_member
                            client.requestController
                                .add(GMarkAllNotificationsReadReq());
                          }
                        : null,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: PulseSegmented<InboxFilter>(
                    options: InboxFilter.values,
                    selected: filter,
                    onChanged: (f) =>
                        ref.read(inboxFilterProvider.notifier).set(f),
                    labelOf: (f) => switch (f) {
                      InboxFilter.all => 'All',
                      InboxFilter.assigned => 'Assigned',
                      InboxFilter.mentions => 'Mentions',
                      InboxFilter.watching => 'Watching',
                      InboxFilter.dms => 'DMs',
                    },
                  ),
                ),
              ),
              if (isLoading)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: t.ink2),
                    ),
                  ),
                )
              else if (filtered.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: _AllCaughtUp(),
                )
              else
                ..._sections(context, ref, client, filtered),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          );
        },
      ),
    );
  }

  bool _matches(
      GNotificationsInboxData_notifications_edges_node n, InboxFilter f) {
    return switch (f) {
      InboxFilter.all => true,
      InboxFilter.assigned => n.reason == GNotificationReason.ASSIGNMENT,
      InboxFilter.mentions => n.reason == GNotificationReason.MENTION,
      InboxFilter.watching => n.reason == GNotificationReason.WATCHER,
      InboxFilter.dms => n.reason == GNotificationReason.DM,
    };
  }

  /// Group by reason, in order: Urgent > Assigned > Mentions > Watching > DMs > Subscribed.
  List<Widget> _sections(
    BuildContext context,
    WidgetRef ref,
    dynamic client,
    List<GNotificationsInboxData_notifications_edges_node> ns,
  ) {
    final urgent =
        ns.where((n) => n.urgency == GNotificationUrgency.HIGH).toList();
    final assigned = ns
        .where((n) =>
            n.reason == GNotificationReason.ASSIGNMENT &&
            n.urgency != GNotificationUrgency.HIGH)
        .toList();
    final mentions =
        ns.where((n) => n.reason == GNotificationReason.MENTION).toList();
    final watching =
        ns.where((n) => n.reason == GNotificationReason.WATCHER).toList();
    final dms = ns.where((n) => n.reason == GNotificationReason.DM).toList();
    final subscribed = ns
        .where((n) => n.reason == GNotificationReason.TAG_SUBSCRIPTION)
        .toList();

    final out = <Widget>[];
    void addSection(String title,
        List<GNotificationsInboxData_notifications_edges_node> items) {
      if (items.isEmpty) return;
      out.add(SliverToBoxAdapter(
        child: PulseSectionHead.inbox(title: title, count: items.length),
      ));
      out.add(SliverList.builder(
        itemCount: items.length,
        itemBuilder: (context, i) => _Row(node: items[i]),
      ));
    }

    addSection('URGENT', urgent);
    addSection('ASSIGNED', assigned);
    addSection('MENTIONS', mentions);
    addSection('WATCHING', watching);
    addSection('DMS', dms);
    addSection('SUBSCRIBED', subscribed);
    return out;
  }
}

class _Row extends ConsumerWidget {
  const _Row({required this.node});

  final GNotificationsInboxData_notifications_edges_node node;

  PulseInboxReason _reason() {
    return switch (node.reason.name) {
      'ASSIGNMENT' => PulseInboxReason.urgent,
      'MENTION' => PulseInboxReason.mention,
      'WATCHER' => PulseInboxReason.watch,
      'DM' => PulseInboxReason.dm,
      _ => PulseInboxReason.subscribed,
    };
  }

  String _title() {
    final src = node.source;
    if (src == null) return '${node.sourceType} (no longer visible)';
    return switch (src.G__typename) {
      'Post' => (src as dynamic).title as String? ?? 'Post',
      'Task' => (src as dynamic).title as String? ?? 'Task',
      'Comment' => 'Reply: ${(src as dynamic).body}',
      'Message' => 'Message: ${(src as dynamic).body}',
      _ => node.sourceType,
    };
  }

  String _line1() {
    final tag = node.sourceTag;
    final tagPath = tag != null ? '#${tag.displayName}' : '';
    return '${node.reason.name.toLowerCase()} · $tagPath';
  }

  String _shortWhen(String iso) {
    final parsed = DateTime.tryParse(iso);
    if (parsed == null) return '';
    final diff = DateTime.now().toUtc().difference(parsed.toUtc());
    if (diff.inMinutes < 1) return 'now';
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${(diff.inDays / 7).floor()}w';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    final isUnread = node.readAt == null;
    final isUrgent = node.urgency == GNotificationUrgency.HIGH;
    return PulseInboxRow(
      reason: _reason(),
      title: _title(),
      line1: _line1(),
      when: _shortWhen(node.createdAt.value),
      unread: isUnread,
      urgent: isUrgent,
      onTap: () {
        if (node.sourceType == 'post') {
          context.go('/feed/p/${node.sourceId}');
        }
        // ignore: invalid_use_of_protected_member
        client.requestController.add(
          GMarkNotificationReadReq((b) => b..vars.ids.add(node.id)),
        );
      },
    );
  }
}

class _AllCaughtUp extends StatelessWidget {
  const _AllCaughtUp();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: t.paper2,
                border: Border.all(color: t.hair, width: 2),
                shape: BoxShape.circle,
              ),
              child: Text(
                '0',
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 36,
                  color: t.ink2,
                  height: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text('all caught up',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              'nothing waiting on you · review subscribed tags?',
              style: TextStyle(
                fontFamily: pulseMonoFamily,
                fontSize: 11,
                color: t.ink3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

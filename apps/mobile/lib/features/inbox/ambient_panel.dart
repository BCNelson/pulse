import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/__generated__/schema.schema.gql.dart';
import '../../graphql/operations/__generated__/notifications.data.gql.dart';
import '../../graphql/operations/__generated__/notifications.req.gql.dart';

/// Right-rail "ambient activity" panel, shown on wide layouts only.
/// Groups subscribed-tag notifications by tag and renders a few lines of
/// mono activity per tag, matching the `.hf-ambient` block in hifi.css.
class AmbientPanel extends ConsumerWidget {
  const AmbientPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final client = ref.watch(ferryClientProvider);
    final req = GNotificationsInboxReq(
      (b) => b
        ..vars.first = 100
        ..vars.unreadOnly = false,
    );
    return Container(
      color: t.paper2,
      child: StreamBuilder(
        stream: client.request(req),
        builder: (context, snap) {
          final data = snap.data?.data;
          final all = data?.notifications.edges
                  .map((e) => e.node)
                  .toList(growable: false) ??
              const <GNotificationsInboxData_notifications_edges_node>[];
          final ambient = all
              .where((n) => n.reason == GNotificationReason.TAG_SUBSCRIPTION)
              .toList();
          final groups = _groupByTag(ambient);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Head(count: ambient.length),
              Expanded(
                child: groups.isEmpty
                    ? _Quiet(
                        loading:
                            snap.connectionState == ConnectionState.waiting &&
                                data == null)
                    : ListView(
                        padding: const EdgeInsets.only(bottom: 12),
                        children: [
                          for (final entry in groups.entries)
                            _Group(tagName: entry.key, items: entry.value),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Group by source tag display name. Preserves insertion order
  /// (notifications query is already ordered most-recent-first).
  Map<String, List<GNotificationsInboxData_notifications_edges_node>>
      _groupByTag(
    List<GNotificationsInboxData_notifications_edges_node> items,
  ) {
    final out =
        <String, List<GNotificationsInboxData_notifications_edges_node>>{};
    for (final n in items) {
      final key = n.sourceTag?.displayName ?? '·';
      out.putIfAbsent(key, () => []).add(n);
    }
    return out;
  }
}

class _Head extends StatelessWidget {
  const _Head({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: t.hair2)),
      ),
      child: Row(
        children: [
          Text(
            'AMBIENT',
            style: TextStyle(
              fontFamily: pulseMonoFamily,
              fontSize: 11,
              letterSpacing: 0.08 * 11,
              color: t.ink2,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'subscribed tags',
            style: TextStyle(
              fontFamily: pulseMonoFamily,
              fontSize: 10.5,
              color: t.ink3,
              height: 1.2,
            ),
          ),
          const Spacer(),
          Text(
            '$count',
            style: TextStyle(
              fontFamily: pulseMonoFamily,
              fontSize: 10.5,
              color: t.ink3,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.tagName, required this.items});

  final String tagName;
  final List<GNotificationsInboxData_notifications_edges_node> items;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final shown = items.take(3).toList();
    final extra = items.length - shown.length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: t.hair2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: t.ink2,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '#$tagName',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: pulseMonoFamily,
                    fontSize: 11,
                    color: t.ink,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ),
              Text(
                '${items.length}',
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 10,
                  color: t.ink3,
                  height: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          for (final n in shown) _Line(node: n),
          if (extra > 0)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                '+ $extra more',
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 10.5,
                  color: t.ink3,
                  height: 1.3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.node});

  final GNotificationsInboxData_notifications_edges_node node;

  String _summary() {
    final src = node.source;
    if (src == null) return '${node.sourceType} (gone)';
    return switch (src.G__typename) {
      'Post' => 'posted: ${(src as dynamic).title}',
      'Comment' => 'replied: ${(src as dynamic).body}',
      'Task' => 'task: ${(src as dynamic).title}',
      'Message' => 'said: ${(src as dynamic).body}',
      _ => node.sourceType,
    };
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        _summary(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontFamily: pulseMonoFamily,
          fontSize: 11.5,
          color: t.ink2,
          height: 1.3,
        ),
      ),
    );
  }
}

class _Quiet extends StatelessWidget {
  const _Quiet({required this.loading});

  final bool loading;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: loading
            ? SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2, color: t.ink3),
              )
            : Text(
                'quiet · no recent activity',
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 11,
                  color: t.ink3,
                ),
              ),
      ),
    );
  }
}

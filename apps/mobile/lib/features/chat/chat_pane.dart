import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/chat_cache.dart';
import '../../core/ferry_client.dart';
import '../../core/selection.dart';
import '../../design/atoms/pulse_chat_msg.dart';
import '../../design/atoms/pulse_day_divider.dart';
import '../../design/atoms/pulse_page_head.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/operations/__generated__/chat.data.gql.dart';
import '../../graphql/operations/__generated__/chat.req.gql.dart';
import 'cached_chat_room_provider.dart';
import 'message_added_listener.dart';

class ChatPane extends ConsumerWidget {
  const ChatPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final roomId = ref.watch(selectedRoomIdProvider);
    return Container(
      color: t.paper,
      child: LayoutBuilder(
        builder: (context, c) {
          if (c.maxWidth >= 720) {
            return Row(
              children: [
                const SizedBox(width: 280, child: _RoomList()),
                VerticalDivider(width: 1, color: t.hair, thickness: 1),
                Expanded(
                  child: roomId == null
                      ? const _RoomPlaceholder()
                      : _RoomDetail(roomId: roomId),
                ),
              ],
            );
          }
          return roomId == null
              ? const _RoomList()
              : _RoomDetail(roomId: roomId);
        },
      ),
    );
  }
}

class _RoomList extends ConsumerWidget {
  const _RoomList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    return Container(
      color: t.paper2,
      child: Column(
        children: [
          const PulsePageHead(title: 'Chat', subtitle: 'rooms · DMs'),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Room list lands in M5.B+\nopen a room from a notification.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: pulseMonoFamily,
                    fontSize: 11,
                    color: t.ink3,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomPlaceholder extends StatelessWidget {
  const _RoomPlaceholder();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Center(
      child: Text(
        'pick a room',
        style: TextStyle(
          fontFamily: pulseMonoFamily,
          fontSize: 12,
          color: t.ink3,
        ),
      ),
    );
  }
}

class _RoomDetail extends ConsumerStatefulWidget {
  const _RoomDetail({required this.roomId});

  final String roomId;

  @override
  ConsumerState<_RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends ConsumerState<_RoomDetail> {
  final _controller = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final body = _controller.text.trim();
    if (body.isEmpty) return;
    setState(() => _busy = true);
    final client = ref.read(ferryClientProvider);
    final req = GSendMessageReq(
      (b) => b
        ..vars.input.roomId = widget.roomId
        ..vars.input.body = body,
    );
    final resp = await client.request(req).first;
    if (!mounted) return;
    setState(() => _busy = false);
    if (!resp.hasErrors) {
      final sent = resp.data?.sendMessage;
      if (sent != null) {
        final node = GMessageSummaryData.fromJson(sent.toJson());
        if (node != null) {
          await ref
              .read(chatCacheStoreProvider)
              .appendMessage(roomId: widget.roomId, node: node);
        }
      }
      _controller.clear();
    }
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '··';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  String _shortTime(String iso) {
    final parsed = DateTime.tryParse(iso);
    if (parsed == null) return '';
    final local = parsed.toLocal();
    return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }

  String _dayLabel(DateTime d) {
    final today = DateTime.now();
    if (d.year == today.year && d.month == today.month && d.day == today.day) {
      return 'TODAY';
    }
    final yesterday = today.subtract(const Duration(days: 1));
    if (d.year == yesterday.year &&
        d.month == yesterday.month &&
        d.day == yesterday.day) {
      return 'YESTERDAY';
    }
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(messageAddedListenerProvider(widget.roomId), (_, __) {});

    final t = context.tokens;
    final roomAsync = ref.watch(cachedChatRoomProvider(widget.roomId));
    final cached = roomAsync.asData?.value;
    final messages = cached?.messages ?? const [];
    if (cached == null && roomAsync.isLoading) {
      return Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(strokeWidth: 2, color: t.ink2),
        ),
      );
    }
    // Build day-grouped widget list.
    final children = <Widget>[];
    DateTime? lastDay;
    for (final node in messages) {
      final created = DateTime.tryParse(node.createdAt.value);
      if (created != null) {
        final day = DateTime(created.year, created.month, created.day);
        if (lastDay == null || day != lastDay) {
          children.add(PulseDayDivider(label: _dayLabel(day)));
          lastDay = day;
        }
      }
      children.add(PulseChatMsg(
        who: node.author.displayName,
        initials: _initials(node.author.displayName),
        text: node.body,
        when: _shortTime(node.createdAt.value),
      ));
    }
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
          decoration: BoxDecoration(
            color: t.paper,
            border: Border(bottom: BorderSide(color: t.hair2)),
          ),
          child: Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: t.green,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: t.greenSoft,
                      blurRadius: 0,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'live',
                style: pulseMono(context, size: 11, color: t.ink2),
              ),
              const SizedBox(width: 12),
              Text(
                '${messages.length} messages',
                style: pulseMono(context, size: 11, color: t.ink3),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: children,
          ),
        ),
        // Composer
        Container(
          decoration: BoxDecoration(
            color: t.paper,
            border: Border(top: BorderSide(color: t.hair2)),
          ),
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: t.paper,
                  border: Border.all(color: t.hair),
                  borderRadius: BorderRadius.circular(t.radius),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: TextField(
                  controller: _controller,
                  style: TextStyle(fontSize: 12, color: t.ink),
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'message…',
                    hintStyle: TextStyle(color: t.ink3, fontSize: 12),
                    isCollapsed: true,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onSubmitted: (_) => _send(),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    '@ # / promote',
                    style: pulseMono(context, size: 10, color: t.ink3),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 32, minHeight: 32),
                    onPressed: _busy ? null : _send,
                    icon: _busy
                        ? SizedBox(
                            height: 14,
                            width: 14,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: t.ink2),
                          )
                        : Icon(Icons.send, size: 16, color: t.ink),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

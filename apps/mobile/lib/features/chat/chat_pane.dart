import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/selection.dart';
import '../../graphql/operations/__generated__/chat.req.gql.dart';
import 'message_added_listener.dart';

class ChatPane extends ConsumerWidget {
  const ChatPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomId = ref.watch(selectedRoomIdProvider);
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth >= 720) {
          return Row(
            children: [
              const SizedBox(width: 280, child: _RoomList()),
              const VerticalDivider(width: 1),
              Expanded(
                child: roomId == null
                    ? const _RoomPlaceholder()
                    : _RoomDetail(roomId: roomId),
              ),
            ],
          );
        }
        return roomId == null ? const _RoomList() : _RoomDetail(roomId: roomId);
      },
    );
  }
}

class _RoomList extends ConsumerWidget {
  const _RoomList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // M5.A doesn't ship a "list rooms" query — we'd need a new resolver
    // for that. For now show a placeholder and let users navigate via
    // notifications or DMs created elsewhere; M5.B/M5.C extend this.
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Room list lands in M5.B+ — open a room from a notification.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _RoomPlaceholder extends StatelessWidget {
  const _RoomPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pick a room.'),
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
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Live-tail messages.
    ref.listen(messageAddedListenerProvider(widget.roomId), (_, __) {});

    final client = ref.watch(ferryClientProvider);
    final req = GChatRoomDetailReq((b) => b..vars.id = widget.roomId);
    return StreamBuilder(
      stream: client.request(req),
      builder: (context, snap) {
        final data = snap.data?.data;
        final room = data?.chatRoom;
        if (room == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  for (final edge in room.messages.edges)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              edge.node.author.displayName,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Text(edge.node.body),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _busy ? null : _send,
                    icon: _busy
                        ? const SizedBox(
                            height: 16, width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

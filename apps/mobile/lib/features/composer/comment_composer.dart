import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../design/tokens.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';

class CommentComposer extends ConsumerStatefulWidget {
  const CommentComposer({super.key, required this.postId});

  final String postId;

  @override
  ConsumerState<CommentComposer> createState() => _CommentComposerState();
}

class _CommentComposerState extends ConsumerState<CommentComposer> {
  final _controller = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final body = _controller.text.trim();
    if (body.isEmpty) return;
    setState(() => _busy = true);
    final client = ref.read(ferryClientProvider);
    final req = GCreateCommentReq(
      (b) => b
        ..vars.input.postId = widget.postId
        ..vars.input.body = body,
    );
    final resp = await client.request(req).first;
    if (!mounted) return;
    setState(() => _busy = false);
    if (!resp.hasErrors) {
      _controller.clear();
      // ignore: invalid_use_of_protected_member
      client.requestController.add(
        GPostDetailReq((b) => b..vars.id = widget.postId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return SafeArea(
      child: Container(
        color: t.paper,
        padding: const EdgeInsets.fromLTRB(14, 8, 10, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
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
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'add a comment…',
                    hintStyle: TextStyle(color: t.ink3, fontSize: 12),
                    isCollapsed: true,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onSubmitted: (_) => _submit(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              onPressed: _busy ? null : _submit,
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
      ),
    );
  }
}

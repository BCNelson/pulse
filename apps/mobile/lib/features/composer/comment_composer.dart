import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/selection.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/cache_handlers.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';

class CommentComposer extends ConsumerStatefulWidget {
  const CommentComposer({super.key, required this.postId});

  final String postId;

  @override
  ConsumerState<CommentComposer> createState() => _CommentComposerState();
}

class _CommentComposerState extends ConsumerState<CommentComposer> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    // Focus the input whenever a reply target is set from elsewhere.
    ref.listenManual<ReplyTarget?>(replyingToCommentProvider, (prev, next) {
      if (next != null && next != prev) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    // Clear any active reply target on unmount so it doesn't bleed into
    // the next post the user opens.
    ref.read(replyingToCommentProvider.notifier).state = null;
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final body = _controller.text.trim();
    if (body.isEmpty) return;
    setState(() => _busy = true);
    final client = ref.read(ferryClientProvider);
    final target = ref.read(replyingToCommentProvider);

    // Resolve the optimistic depth: parent's depth + 1 if replying, else
    // 0. Reads from the cached PostDetail so deeply nested replies stay
    // visually correct on first paint.
    int optimisticDepth = 0;
    if (target != null) {
      final cached = client.cache.readQuery(
        GPostDetailReq((b) => b..vars.id = widget.postId),
      );
      final edges = cached?.post?.comments.edges;
      if (edges != null) {
        for (final e in edges) {
          if (e.node.id == target.commentId) {
            optimisticDepth = e.node.depth + 1;
            break;
          }
        }
      }
    }

    final req = GCreateCommentReq((b) {
      b.vars.input.postId = widget.postId;
      b.vars.input.body = body;
      if (target != null) {
        b.vars.input.parentId = target.commentId;
      }
      b.updateCacheHandlerKey = kAppendCommentHandlerKey;
      b.optimisticResponse.replace(
        buildOptimisticCreateComment(
          postId: widget.postId,
          parentId: target?.commentId,
          body: body,
          depth: optimisticDepth,
        ),
      );
    });
    String? errorMessage;
    try {
      final resp = await client.request(req).first;
      if (resp.hasErrors) {
        errorMessage = resp.graphqlErrors?.map((e) => e.message).join('\n') ??
            resp.linkException?.toString() ??
            'comment failed';
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    if (!mounted) return;
    setState(() => _busy = false);
    if (errorMessage != null) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return;
    }
    _controller.clear();
    ref.read(replyingToCommentProvider.notifier).state = null;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final target = ref.watch(replyingToCommentProvider);
    return SafeArea(
      child: Container(
        color: t.paper,
        padding: const EdgeInsets.fromLTRB(14, 8, 10, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (target != null)
              Container(
                margin: const EdgeInsets.fromLTRB(2, 0, 2, 6),
                padding:
                    const EdgeInsets.fromLTRB(8, 6, 4, 6),
                decoration: BoxDecoration(
                  color: t.ink.withValues(alpha: 0.04),
                  border: Border(
                    left: BorderSide(color: t.ink, width: 2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.subdirectory_arrow_right,
                        size: 12, color: t.ink3),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'replying to ${target.authorDisplayName}',
                            style: pulseMono(context,
                                size: 11,
                                color: t.ink,
                                weight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (target.body != null &&
                              target.body!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            ConstrainedBox(
                              constraints:
                                  const BoxConstraints(maxHeight: 96),
                              child: SingleChildScrollView(
                                child: Text(
                                  target.body!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: t.ink2),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => ref
                          .read(replyingToCommentProvider.notifier)
                          .state = null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: Icon(Icons.close, size: 14, color: t.ink3),
                      ),
                    ),
                  ],
                ),
              ),
            Row(
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
                      focusNode: _focusNode,
                      style: TextStyle(fontSize: 12, color: t.ink),
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: target == null ? 'add a comment…' : 'reply…',
                        hintStyle: TextStyle(color: t.ink3, fontSize: 12),
                        isCollapsed: true,
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 8),
                      ),
                      onSubmitted: (_) => _submit(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 36, minHeight: 36),
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
          ],
        ),
      ),
    );
  }
}

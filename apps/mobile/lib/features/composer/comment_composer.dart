import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/draft_storage.dart';
import '../../core/ferry_client.dart';
import '../../core/post_cache.dart';
import '../../core/selection.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/cache_handlers.dart';
import '../../graphql/operations/__generated__/posts.req.gql.dart';
import '../post_detail/post_read_marker.dart';
import 'markdown_composer.dart';

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
  Timer? _saveDebounce;

  /// Captured at initState. Used from dispose() too, where ref.read is
  /// no longer legal under Riverpod 3.x.
  late final DraftStorage _drafts;

  /// Tracks which (postId, replyTargetCommentId) key the current text in
  /// [_controller] belongs to so we save and load the right draft when
  /// the reply target changes.
  String? _activeReplyTargetId;

  /// Suppresses debounced saves while [_controller.text] is being
  /// programmatically populated from a loaded draft.
  bool _loadingDraft = false;

  @override
  void initState() {
    super.initState();
    _drafts = ref.read(draftStorageProvider);
    final initialTarget = ref.read(replyingToCommentProvider);
    _activeReplyTargetId = initialTarget?.commentId;
    _loadDraftFor(_activeReplyTargetId);
    _controller.addListener(_onTextChanged);

    ref.listenManual<ReplyTarget?>(replyingToCommentProvider, (prev, next) {
      if (next != null && next != prev) {
        _focusNode.requestFocus();
      }
      if (prev?.commentId == next?.commentId) return;
      // Reply target changed: flush any pending save against the old key,
      // then swap in the draft for the new key.
      _saveDebounce?.cancel();
      _flushSave(_activeReplyTargetId);
      _activeReplyTargetId = next?.commentId;
      _loadDraftFor(_activeReplyTargetId);
    });
  }

  void _onTextChanged() {
    if (_loadingDraft) return;
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 400),
        () => _flushSave(_activeReplyTargetId));
  }

  void _flushSave(String? replyTargetId) {
    _drafts.write(widget.postId, replyTargetId, _controller.text);
  }

  void _loadDraftFor(String? replyTargetId) {
    final saved = _drafts.read(widget.postId, replyTargetId) ?? '';
    _loadingDraft = true;
    _controller.text = saved;
    _loadingDraft = false;
  }

  @override
  void dispose() {
    _saveDebounce?.cancel();
    // Flush the latest text so a hot restart picks it up.
    _flushSave(_activeReplyTargetId);
    _controller.removeListener(_onTextChanged);
    // Note: deliberately do NOT clear replyingToCommentProvider here.
    // Its build() is keyed off selectedPostIdProvider so it resets
    // automatically when the user backs out of the post, and that
    // ensures per-post reply state stays persisted across navigation.
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
      } else {
        // Mirror Ferry's now-updated PostDetail cache into the persistent
        // store so the comment survives restarts.
        final freshDetail = client.cache.readQuery(
          GPostDetailReq((b) => b..vars.id = widget.postId),
        );
        final freshPost = freshDetail?.post;
        if (freshPost != null) {
          await ref.read(postCacheStoreProvider).upsertPostDetail(freshPost);
        }
        ref
            .read(postReadMarkerProvider(widget.postId).notifier)
            .markIfAdvanced();
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
    // Clear the draft for whatever key we just submitted against, then
    // drop reply mode. Order matters: clear before flipping target so we
    // delete the right key.
    _saveDebounce?.cancel();
    await ref
        .read(draftStorageProvider)
        .clear(widget.postId, _activeReplyTargetId);
    _loadingDraft = true;
    _controller.clear();
    _loadingDraft = false;
    ref.read(replyingToCommentProvider.notifier).set(null);
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
                padding: const EdgeInsets.fromLTRB(8, 6, 4, 6),
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
                              constraints: const BoxConstraints(maxHeight: 96),
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
                      onTap: () {
                        // Discard this reply's draft when the user
                        // explicitly cancels — they don't want it back.
                        final dismissed = target.commentId;
                        _saveDebounce?.cancel();
                        ref
                            .read(draftStorageProvider)
                            .clear(widget.postId, dismissed);
                        ref.read(replyingToCommentProvider.notifier).set(null);
                      },
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
                  child: MarkdownComposer(
                    controller: _controller,
                    focusNode: _focusNode,
                    minLines: 1,
                    maxLines: 4,
                    hintText: target == null ? 'add a comment…' : 'reply…',
                    textStyle: TextStyle(fontSize: 12, color: t.ink),
                    onSubmitted: (_) => _submit(),
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

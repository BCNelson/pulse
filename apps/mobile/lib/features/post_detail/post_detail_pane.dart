import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/selection.dart';
import '../../design/atoms/pulse_avatar.dart';
import '../../design/atoms/pulse_section_head.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../composer/comment_composer.dart';
import 'cached_post_detail_provider.dart';
import 'reaction_bar.dart';

/// Shows a "sending…" pill if the optimistic comment hasn't been
/// confirmed by the server within [delay]. Mounts when the optimistic
/// node first renders and disposes when the real comment replaces it,
/// so the timer is cleaned up automatically.
class _SendingBadge extends StatefulWidget {
  const _SendingBadge();

  @override
  State<_SendingBadge> createState() => _SendingBadgeState();
}

class _SendingBadgeState extends State<_SendingBadge> {
  static const _delay = Duration(seconds: 3);
  bool _show = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(_delay, () {
      if (mounted) setState(() => _show = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_show) return const SizedBox.shrink();
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 8,
            height: 8,
            child: CircularProgressIndicator(strokeWidth: 1.4, color: t.ink3),
          ),
          const SizedBox(width: 4),
          Text('sending…', style: pulseMono(context, size: 10, color: t.ink3)),
        ],
      ),
    );
  }
}

class PostDetailPane extends ConsumerWidget {
  const PostDetailPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final postId = ref.watch(selectedPostIdProvider);
    if (postId == null) {
      return Container(
        color: t.paper,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'pick a post to read it',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: pulseMonoFamily,
                fontSize: 12,
                color: t.ink3,
              ),
            ),
          ),
        ),
      );
    }
    return Container(color: t.paper, child: _PostDetail(postId: postId));
  }
}

class _PostDetail extends ConsumerWidget {
  const _PostDetail({required this.postId});

  final String postId;

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '··';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  String _shortWhen(String iso) {
    final parsed = DateTime.tryParse(iso);
    if (parsed == null) return '';
    final diff = DateTime.now().toUtc().difference(parsed.toUtc());
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${(diff.inDays / 7).floor()}w ago';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final replyTarget = ref.watch(replyingToCommentProvider);
    final detailAsync = ref.watch(cachedPostDetailProvider(postId));
    final post = detailAsync.asData?.value;
    if (post == null) {
      if (detailAsync.isLoading) {
        return Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: t.ink2),
          ),
        );
      }
      if (detailAsync.hasError) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              detailAsync.error.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: pulseMonoFamily,
                fontSize: 11,
                color: t.ink2,
              ),
            ),
          ),
        );
      }
      return Center(
        child: Text(
          'post not found or hidden',
          style: TextStyle(
            fontFamily: pulseMonoFamily,
            fontSize: 12,
            color: t.ink3,
          ),
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Hero post block
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 16, 22, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: t.ink,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        'POST',
                        style: TextStyle(
                          fontFamily: pulseMonoFamily,
                          fontSize: 9.5,
                          color: t.paper,
                          letterSpacing: 0.10 * 9.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(post.title,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        PulseAvatar(
                            initials: _initials(post.author.displayName)),
                        const SizedBox(width: 8),
                        Text(
                          post.author.displayName,
                          style: pulseMono(context, size: 11, color: t.ink),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '· ${_shortWhen(post.createdAt.value)}',
                          style: pulseMono(context, size: 11, color: t.ink3),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      post.body,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    ReactionBar(
                      postId: post.id,
                      reactions: post.reactions
                          .map((r) => (
                                emoji: r.emoji,
                                count: r.count,
                                byViewer: r.byViewer,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: t.hair2),
              PulseSectionHead.inbox(
                title: 'COMMENTS',
                count: post.comments.edges.length,
              ),
              for (final edge in post.comments.edges)
                Builder(builder: (context) {
                  final isTarget = replyTarget?.commentId == edge.node.id;
                  final leftIndent = 22 + 16.0 * edge.node.depth.clamp(0, 6);
                  return Container(
                    decoration: BoxDecoration(
                      color: isTarget ? t.ink.withValues(alpha: 0.04) : null,
                      border: Border(
                        bottom: BorderSide(color: t.hair2),
                        left: BorderSide(
                          color: isTarget ? t.ink : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(
                      leftIndent - (isTarget ? 2 : 0),
                      10,
                      22,
                      10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PulseAvatar(
                          initials: _initials(edge.node.author.displayName),
                          size: PulseAvatarSize.sm,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    edge.node.author.displayName,
                                    style: pulseMono(context,
                                        size: 11,
                                        color: t.ink,
                                        weight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '· ${_shortWhen(edge.node.createdAt.value)}',
                                    style: pulseMono(context,
                                        size: 11, color: t.ink3),
                                  ),
                                  if (edge.node.id.startsWith('opt-'))
                                    const _SendingBadge(),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                edge.node.body,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              InkWell(
                                onTap: () {
                                  final notifier = ref
                                      .read(replyingToCommentProvider.notifier);
                                  if (isTarget) {
                                    notifier.set(null);
                                  } else {
                                    notifier.set(ReplyTarget(
                                      commentId: edge.node.id,
                                      authorDisplayName:
                                          edge.node.author.displayName,
                                      body: edge.node.body,
                                    ));
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    isTarget ? 'cancel reply' : 'reply',
                                    style: pulseMono(context,
                                        size: 11,
                                        color: isTarget ? t.ink : t.ink3,
                                        weight:
                                            isTarget ? FontWeight.w600 : null),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
        Divider(height: 1, color: t.hair2),
        CommentComposer(postId: post.id),
      ],
    );
  }
}

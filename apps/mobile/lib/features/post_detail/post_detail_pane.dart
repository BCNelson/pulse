import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/selection.dart';
import '../../design/atoms/pulse_avatar.dart';
import '../../design/atoms/pulse_markdown_body.dart';
import '../../design/atoms/pulse_section_head.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/operations/__generated__/posts.data.gql.dart';
import '../composer/comment_composer.dart';
import 'cached_post_detail_provider.dart';
import 'comment_tree.dart';
import 'post_read_marker.dart';
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
    return Container(
      color: t.paper,
      child: _PostDetail(key: ValueKey(postId), postId: postId),
    );
  }
}

class _PostDetail extends ConsumerStatefulWidget {
  const _PostDetail({super.key, required this.postId});

  final String postId;

  @override
  ConsumerState<_PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends ConsumerState<_PostDetail> {
  // Lazy-init via a getter so DDC hot-reload state desync (where the field
  // can read as `null`) doesn't crash with "Null is not Set<String>".
  Set<String>? _collapsedSubtreesField;
  Set<String> get _collapsedSubtrees => _collapsedSubtreesField ??= <String>{};

  /// Frozen at view entry: the viewer's `Post.lastReadAt` at the moment
  /// they opened the post. Used as the comparison anchor for "is this
  /// comment new?". Stays frozen for the whole visit so highlights don't
  /// vanish when we mark-as-read mid-visit. Null when the user has never
  /// marked this post read — in that case, nothing is highlighted.
  DateTime? _entryLastReadAt;
  bool _entrySnapshotTaken = false;

  final ScrollController _scrollController = ScrollController();
  double? _initialScrollOffset;
  Timer? _scrollSettleTimer;

  @override
  void initState() {
    super.initState();
    // Each visit starts with a fresh marker — even if the user re-opens
    // the same post within Riverpod's auto-keep-alive window.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(postReadMarkerProvider(widget.postId).notifier).reset();
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollSettleTimer?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final px = _scrollController.position.pixels;
    _initialScrollOffset ??= px;
    if ((px - _initialScrollOffset!).abs() <= 4) return;
    // Coalesce scroll ticks: only attempt to advance the read mark once
    // the user has stopped scrolling for a moment. Repeated scrolling
    // after the mark is cheap (the provider no-ops when seenAt hasn't
    // advanced), but this keeps a fast flick from issuing a burst.
    _scrollSettleTimer?.cancel();
    _scrollSettleTimer = Timer(const Duration(milliseconds: 250), _markRead);
  }

  void _markRead() {
    ref.read(postReadMarkerProvider(widget.postId).notifier).markIfAdvanced();
  }

  void _toggleCollapsed(String commentId) {
    setState(() {
      final s = _collapsedSubtrees;
      if (!s.remove(commentId)) {
        s.add(commentId);
      }
    });
    _markRead();
  }

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
  Widget build(BuildContext context) {
    final t = context.tokens;
    final replyTarget = ref.watch(replyingToCommentProvider);
    final detailAsync = ref.watch(cachedPostDetailProvider(widget.postId));
    final post = detailAsync.asData?.value;
    if (post != null && !_entrySnapshotTaken) {
      final iso = post.lastReadAt?.value;
      _entryLastReadAt = iso == null ? null : DateTime.tryParse(iso)?.toUtc();
      _entrySnapshotTaken = true;
    }
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
            controller: _scrollController,
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
                        Flexible(
                          child: Text(
                            post.author.displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: pulseMono(context, size: 11, color: t.ink),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '· ${_shortWhen(post.createdAt.value)}',
                          style: pulseMono(context, size: 11, color: t.ink3),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    PulseMarkdownBody(data: post.body),
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
              for (final row in buildCommentRows(
                flat: _toSummaries(post.comments.edges),
                collapsedSubtrees: _collapsedSubtrees,
              ))
                _buildRow(row, t, replyTarget),
            ],
          ),
        ),
        Divider(height: 1, color: t.hair2),
        CommentComposer(postId: post.id),
      ],
    );
  }

  List<CommentSummary> _toSummaries(
    Iterable<GPostDetailData_post_comments_edges> edges,
  ) {
    return [
      for (final e in edges)
        CommentSummary(
          id: e.node.id,
          parentId: e.node.parentId,
          depth: e.node.depth,
          isOptimistic: e.node.id.startsWith('opt-'),
          body: e.node.body,
          authorDisplayName: e.node.author.displayName,
          createdAtIso: e.node.createdAt.value,
        ),
    ];
  }

  // Geometry constants.
  static const double _indentStep = 16; // px per depth.
  static const double _avatarRadius = 7; // PulseAvatarSize.sm diameter / 2.
  // Horizontal position of column k's stroke (1px line). Centered on the
  // avatar's column. Clamped at the max visible depth.
  static const int _maxIndentDepth = 6;
  int _visibleColumn(int depth) => depth.clamp(0, _maxIndentDepth);

  double _columnLineLeft(int k) {
    final visibleK = _visibleColumn(k);
    return _indentStep * visibleK + _avatarRadius - 0.5 + 8;
  }

  // Row content starts at the avatar's left edge.
  double _rowContentLeft(int depth) {
    final visibleD = _visibleColumn(depth);
    return _indentStep * visibleD + 8;
  }

  double _elbowWidth(int depth) {
    if (depth <= 0) return 0;
    return _columnLineLeft(depth) - _columnLineLeft(depth - 1);
  }

  double _stubIconLeft(int depth) {
    final lineCenter = _columnLineLeft(depth) + 0.5;
    return lineCenter - (_stubIconSize / 2);
  }

  double _collapseHitLeft(int depth) {
    return _stubIconLeft(depth) - 10;
  }

  double get _collapseHitTop => _ownTrunkTopY - 2;

  // Y of the elbow's bend / avatar vertical center within the row.
  static const double _elbowBendY = 17;
  // Y where the OwnTrunk begins (just below the avatar's bottom).
  static const double _ownTrunkTopY = 26;
  static const double _stubIconSize = 16;
  static const double _collapseHitSize = 32;
  static const double _collapseIconSize = 14;

  Widget _collapseIcon(PulseTokens t, IconData icon) {
    return Container(
      color: t.paper,
      padding: const EdgeInsets.all(1),
      child: Icon(icon, size: _collapseIconSize, color: t.ink3),
    );
  }

  Widget _buildRow(RowState row, PulseTokens t, ReplyTarget? replyTarget) {
    return switch (row) {
      CommentRowState() => _buildCommentRow(row, t, replyTarget, _isNew(row)),
      StubRowState() => _buildStubRow(row, t),
    };
  }

  /// True iff this row's comment is newer than the entry snapshot. Always
  /// false when `_entryLastReadAt` is null (the user has never marked
  /// this post read), so a fully-unread post starts with no highlights.
  /// Optimistic rows are never highlighted — their `createdAt` is local
  /// and not meaningful for the comparison.
  bool _isNew(CommentRowState row) {
    final anchor = _entryLastReadAt;
    if (anchor == null) return false;
    if (row.comment.isOptimistic) return false;
    final created = DateTime.tryParse(row.comment.createdAtIso)?.toUtc();
    if (created == null) return false;
    return created.isAfter(anchor);
  }

  /// Common trunk-line pieces, derived from a RowState. Returns the list
  /// of [Positioned] widgets that go *behind* the row content.
  List<Widget> _trunkPieces(RowState row, PulseTokens t,
      {required bool drawOwnTrunk}) {
    final d = row.depth;
    final pieces = <Widget>[];

    // 1. Deeper-ancestor verticals (k in [0, d-2]).
    for (var k = 0; k < d - 1; k++) {
      if (!row.isLastSibling[k]) {
        pieces.add(Positioned(
          left: _columnLineLeft(k),
          top: 0,
          bottom: 0,
          child: Container(width: 1, color: t.hair2),
        ));
      }
    }

    // 2. Elbow at column d-1 (always if d > 0).
    if (d > 0) {
      final elbowWidth = _elbowWidth(d);
      if (elbowWidth > 0) {
        pieces.add(Positioned(
          left: _columnLineLeft(d - 1),
          top: 0,
          width: elbowWidth,
          height: _elbowBendY,
          child: CustomPaint(painter: _ThreadElbowPainter(color: t.hair2)),
        ));
      } else {
        pieces.add(Positioned(
          left: _columnLineLeft(d),
          top: 0,
          height: _elbowBendY,
          child: Container(width: 1, color: t.hair2),
        ));
      }
      // 3. Parent continuation below the bend.
      if (!row.isLastSibling[d - 1]) {
        pieces.add(Positioned(
          left: elbowWidth > 0 ? _columnLineLeft(d - 1) : _columnLineLeft(d),
          top: _elbowBendY,
          bottom: 0,
          child: Container(width: 1, color: t.hair2),
        ));
      }
    }

    // 4. OwnTrunk at column d.
    if (drawOwnTrunk) {
      pieces.add(Positioned(
        left: _columnLineLeft(d),
        top: _ownTrunkTopY,
        bottom: 0,
        child: Container(width: 1, color: t.hair2),
      ));
    }

    return pieces;
  }

  Widget _buildCommentRow(
    CommentRowState row,
    PulseTokens t,
    ReplyTarget? replyTarget,
    bool isNew,
  ) {
    final comment = row.comment;
    final isTarget = replyTarget?.commentId == comment.id;
    final contentLeft = _rowContentLeft(row.depth);
    final hasChildren = row.hasOwnTrunk; // any children, expanded or collapsed
    // Reply-target tint takes precedence over unread tint — the two would
    // otherwise stack and produce a muddy color, and reply-target is more
    // actionable.
    final Color? rowBg = isTarget
        ? t.ink.withValues(alpha: 0.04)
        : (isNew ? t.blueSoft : null);
    return Container(
      decoration: BoxDecoration(color: rowBg),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (isTarget)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(width: 2, color: t.ink),
            ),
          ..._trunkPieces(row, t, drawOwnTrunk: row.hasOwnTrunk),
          Padding(
            padding: EdgeInsets.fromLTRB(contentLeft, 10, 22, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PulseAvatar(
                  initials: _initials(comment.authorDisplayName),
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
                            comment.authorDisplayName,
                            style: pulseMono(context,
                                size: 11,
                                color: t.ink,
                                weight: FontWeight.w600),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '· ${_shortWhen(comment.createdAtIso)}',
                            style: pulseMono(context, size: 11, color: t.ink3),
                          ),
                          if (comment.isOptimistic) const _SendingBadge(),
                        ],
                      ),
                      const SizedBox(height: 2),
                      PulseMarkdownBody(data: comment.body),
                      const SizedBox(height: 4),
                      InkWell(
                        onTap: () {
                          final notifier =
                              ref.read(replyingToCommentProvider.notifier);
                          if (isTarget) {
                            notifier.set(null);
                          } else {
                            notifier.set(ReplyTarget(
                              commentId: comment.id,
                              authorDisplayName: comment.authorDisplayName,
                              body: comment.body,
                            ));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            isTarget ? 'cancel reply' : 'reply',
                            style: pulseMono(context,
                                size: 11,
                                color: isTarget ? t.ink : t.ink3,
                                weight: isTarget ? FontWeight.w600 : null),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // CollapseToggle overlay on the OwnTrunk, just below the avatar.
          if (hasChildren)
            Positioned(
              left: _collapseHitLeft(row.depth),
              top: _collapseHitTop,
              child: SizedBox.square(
                dimension: _collapseHitSize,
                child: InkWell(
                  onTap: () => _toggleCollapsed(comment.id),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0, right: 6),
                      child: _collapseIcon(
                        t,
                        row.isCollapsed
                            ? Icons.add_circle_outline
                            : Icons.remove_circle_outline,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStubRow(StubRowState row, PulseTokens t) {
    final iconLeft = _stubIconLeft(row.depth);
    final label =
        '${row.hiddenCount} hidden ${row.hiddenCount == 1 ? 'comment' : 'comments'}';
    return InkWell(
      onTap: () => _toggleCollapsed(row.collapsedCommentId),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ..._trunkPieces(row, t, drawOwnTrunk: false),
          Padding(
            padding: EdgeInsets.fromLTRB(iconLeft, 9, 22, 8),
            child: Row(
              children: [
                _collapseIcon(t, Icons.add_circle_outline),
                const SizedBox(width: 6),
                Text(label, style: pulseMono(context, size: 11, color: t.ink3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Draws an L-shaped connector with a rounded inner corner: a vertical
/// segment along the left edge, curving 90° at the bottom and continuing
/// horizontally to the right edge. Used to "point" each parent's thread
/// line at its child's avatar.
class _ThreadElbowPainter extends CustomPainter {
  _ThreadElbowPainter({required this.color});

  final Color color;
  static const double _radius = 5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(0.5, 0)
      ..lineTo(0.5, size.height - _radius)
      ..quadraticBezierTo(0.5, size.height, _radius + 0.5, size.height)
      ..lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ThreadElbowPainter old) => old.color != color;
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/ferry_client.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/operations/__generated__/mention_preview.req.gql.dart';
import 'mention_preview_provider.dart';

/// Wraps the app shell so that taps on `@user` / `#tag` mentions can pop
/// a slide-in side panel anchored to the right edge. State lives in
/// [mentionPreviewProvider]; when the target becomes non-null, the panel
/// animates in. Tapping the backdrop, the close button, or pressing Esc
/// dismisses it.
///
/// On screens narrower than [_panelWidth] the docked panel would clip
/// past the left edge, so it switches to full-screen instead. The
/// width transition is intentionally a hard snap — animating it as the
/// viewport resizes feels laggy.
class MentionPreviewOverlay extends ConsumerWidget {
  const MentionPreviewOverlay({super.key, required this.child});

  final Widget child;

  static const double _panelWidth = 360;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final target = ref.watch(mentionPreviewProvider);
    return _MentionPreviewShell(
      target: target,
      onClose: () => ref.read(mentionPreviewProvider.notifier).close(),
      panelWidth: _panelWidth,
      child: child,
    );
  }
}

/// Inner StatefulWidget that owns the slide-out grace period. Keeping
/// this separate from the ConsumerWidget wrapper sidesteps a runtime
/// type-cast issue in flutter_riverpod's State debug introspection that
/// triggers when nesting a Notifier-watching ConsumerStatefulWidget here.
class _MentionPreviewShell extends StatefulWidget {
  const _MentionPreviewShell({
    required this.target,
    required this.onClose,
    required this.panelWidth,
    required this.child,
  });

  final MentionPreviewTarget? target;
  final VoidCallback onClose;
  final double panelWidth;
  final Widget child;

  @override
  State<_MentionPreviewShell> createState() => _MentionPreviewShellState();
}

class _MentionPreviewShellState extends State<_MentionPreviewShell> {
  /// Cached so the panel keeps its contents while sliding out — when
  /// the provider transitions to null the slide animation still has
  /// something to render. Cleared once the slide completes.
  MentionPreviewTarget? _lastTarget;
  Timer? _purgeTimer;

  static const Duration _slideDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _lastTarget = widget.target;
  }

  @override
  void didUpdateWidget(covariant _MentionPreviewShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    final target = widget.target;
    if (target != null) {
      _purgeTimer?.cancel();
      _purgeTimer = null;
      if (_lastTarget != target) {
        _lastTarget = target;
      }
    } else if (_lastTarget != null && _purgeTimer == null) {
      _purgeTimer = Timer(_slideDuration + const Duration(milliseconds: 20),
          () {
        if (!mounted) return;
        setState(() => _lastTarget = null);
        _purgeTimer = null;
      });
    }
  }

  @override
  void dispose() {
    _purgeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final open = widget.target != null;
    final visibleTarget = widget.target ?? _lastTarget;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): widget.onClose,
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final fits = constraints.maxWidth >= widget.panelWidth;
          final width = fits ? widget.panelWidth : constraints.maxWidth;
          return Stack(
            children: [
              widget.child,
              // Backdrop. Only meaningful when there's something visible
              // behind the panel — skip it in the full-screen case.
              if (fits)
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: !open,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 160),
                      opacity: open ? 1.0 : 0.0,
                      child: GestureDetector(
                        onTap: widget.onClose,
                        child: Container(
                          color: t.isDark
                              ? Colors.black.withValues(alpha: 0.55)
                              : Colors.black.withValues(alpha: 0.25),
                        ),
                      ),
                    ),
                  ),
                ),
              // Panel: width snaps with the layout; the open/close
              // motion is a separate AnimatedSlide on the contents so
              // viewport resizes never animate the width itself.
              Positioned.directional(
                textDirection: Directionality.of(context),
                top: 0,
                bottom: 0,
                end: 0,
                width: width,
                child: IgnorePointer(
                  ignoring: !open,
                  child: ClipRect(
                    child: AnimatedSlide(
                      duration: _slideDuration,
                      curve: Curves.easeOutCubic,
                      offset:
                          open ? Offset.zero : const Offset(1.0, 0.0),
                      child: visibleTarget == null
                          ? const SizedBox.shrink()
                          : _PanelFrame(target: visibleTarget),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PanelFrame extends ConsumerWidget {
  const _PanelFrame({required this.target});
  final MentionPreviewTarget target;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    return Material(
      color: t.paper,
      elevation: 8,
      child: SafeArea(
        left: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PanelHeader(target: target),
            Divider(height: 1, color: t.hair),
            Expanded(
              child: switch (target) {
                final MentionPreviewUserTarget u =>
                  _UserPreviewBody(slug: u.slug),
                final MentionPreviewTagTarget t => _TagPreviewBody(target: t),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PanelHeader extends ConsumerWidget {
  const _PanelHeader({required this.target});
  final MentionPreviewTarget target;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final label = switch (target) {
      MentionPreviewUserTarget(:final slug) => '@$slug',
      MentionPreviewTagTarget(:final path) => '#$path',
    };
    return Container(
      height: 44,
      color: t.paper2,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: pulseMonoFamily,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: t.ink,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            tooltip: 'Close',
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 32, height: 32),
            onPressed: () =>
                ref.read(mentionPreviewProvider.notifier).close(),
            icon: Icon(Icons.close, size: 16, color: t.ink2),
          ),
        ],
      ),
    );
  }
}

class _UserPreviewBody extends ConsumerWidget {
  const _UserPreviewBody({required this.slug});
  final String slug;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    final t = context.tokens;
    return StreamBuilder(
      stream: client.request(
        GMentionPreviewUserReq(
          (b) => b
            ..vars.slug = slug
            ..vars.first = 5,
        ),
      ),
      builder: (context, snap) {
        if (snap.data == null) {
          return const _LoadingCenter();
        }
        final user = snap.data?.data?.userByHandle;
        if (user == null) {
          return _NotFound(
              label: 'No user found for @$slug.',
              hint: 'They may have been removed or renamed.');
        }
        return ListView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 28),
          children: [
            Text(
              user.displayName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: t.ink,
              ),
            ),
            const SizedBox(height: 4),
            if (user.homeTag != null)
              GestureDetector(
                onTap: () {
                  ref.read(mentionPreviewProvider.notifier).close();
                  context.go('/feed/t/${user.homeTag!.path}');
                },
                child: Text(
                  '@${user.homeTag!.slug}',
                  style: TextStyle(
                    fontFamily: pulseMonoFamily,
                    fontSize: 12,
                    color: t.blueInk,
                  ),
                ),
              ),
            const SizedBox(height: 18),
            _SectionLabel(text: 'recent posts'),
            const SizedBox(height: 6),
            if (user.recentPosts.isEmpty)
              Text(
                'No visible posts yet.',
                style: TextStyle(color: t.ink3, fontSize: 12),
              )
            else
              for (final p in user.recentPosts)
                _PostListTile(
                  id: p.id,
                  title: p.title,
                  authorName: p.author.displayName,
                  onClose: () =>
                      ref.read(mentionPreviewProvider.notifier).close(),
                ),
          ],
        );
      },
    );
  }
}

class _TagPreviewBody extends ConsumerWidget {
  const _TagPreviewBody({required this.target});
  final MentionPreviewTagTarget target;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    final t = context.tokens;
    return StreamBuilder(
      stream: client.request(
        GMentionPreviewTagReq(
          (b) => b
            ..vars.path.replace(target.segments)
            ..vars.first = 5,
        ),
      ),
      builder: (context, snap) {
        if (snap.data == null) {
          return const _LoadingCenter();
        }
        final tag = snap.data?.data?.tagBySlugPath;
        if (tag == null) {
          return _NotFound(
            label: 'No tag found at #${target.path}.',
            hint: 'It may have been archived or renamed.',
          );
        }
        final posts =
            tag.posts.edges.map((e) => e.node).toList(growable: false);
        return ListView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 28),
          children: [
            Text(
              tag.displayName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: t.ink,
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                ref.read(mentionPreviewProvider.notifier).close();
                context.go('/feed/t/${tag.path}');
              },
              child: Text(
                '#${tag.path}',
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 12,
                  color: t.blueInk,
                ),
              ),
            ),
            if (tag.parent != null) ...[
              const SizedBox(height: 10),
              Text(
                'under ${tag.parent!.displayName}',
                style: TextStyle(color: t.ink2, fontSize: 12),
              ),
            ],
            const SizedBox(height: 18),
            _SectionLabel(text: 'recent posts'),
            const SizedBox(height: 6),
            if (posts.isEmpty)
              Text(
                'No visible posts in this tag yet.',
                style: TextStyle(color: t.ink3, fontSize: 12),
              )
            else
              for (final p in posts)
                _PostListTile(
                  id: p.id,
                  title: p.title,
                  authorName: p.author.displayName,
                  onClose: () =>
                      ref.read(mentionPreviewProvider.notifier).close(),
                ),
          ],
        );
      },
    );
  }
}

class _LoadingCenter extends StatelessWidget {
  const _LoadingCenter();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(strokeWidth: 1.6),
      ),
    );
  }
}

class _NotFound extends StatelessWidget {
  const _NotFound({required this.label, required this.hint});
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: t.ink, fontSize: 13)),
          const SizedBox(height: 4),
          Text(hint, style: TextStyle(color: t.ink3, fontSize: 12)),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Text(
      text,
      style: TextStyle(
        fontFamily: pulseMonoFamily,
        fontSize: 10,
        letterSpacing: 0.06 * 10,
        color: t.ink3,
      ),
    );
  }
}

class _PostListTile extends StatelessWidget {
  const _PostListTile({
    required this.id,
    required this.title,
    required this.authorName,
    required this.onClose,
  });
  final String id;
  final String title;
  final String authorName;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return InkWell(
      onTap: () {
        onClose();
        context.go('/feed/p/$id');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: t.ink,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              'by $authorName',
              style: TextStyle(color: t.ink3, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}


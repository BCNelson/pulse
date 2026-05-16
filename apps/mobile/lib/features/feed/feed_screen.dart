import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import 'feed_split_handle.dart';
import 'feed_split_width.dart';
import 'post_list_pane.dart';
import 'tag_panel_visibility.dart';
import 'tag_tree_pane.dart';
import '../post_detail/post_detail_pane.dart';

const _wideBreakpoint = 720.0;
const _splitAnimationDuration = Duration(milliseconds: 220);

/// Body of the `/feed` branch in the [StatefulShellRoute]. Renders the
/// existing three-pane layout on wide screens, and the single-pane stack
/// on narrow. Selection is URL-derived via `currentTagIdProvider` /
/// `currentPostIdProvider`; back navigation routes through `context.pop`,
/// which unwinds the branch's `Navigator` (and the URL with it).
class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= _wideBreakpoint) {
          return const _FeedWideLayout();
        }
        return const _FeedNarrowStack();
      },
    );
  }
}

class _FeedWideLayout extends ConsumerWidget {
  const _FeedWideLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final tagPanelVisible = ref.watch(tagPanelVisibleProvider);
    return Row(
      children: [
        if (tagPanelVisible) ...[
          const SizedBox(width: 224, child: TagTreePane()),
          VerticalDivider(width: 1, color: t.hair, thickness: 1),
        ],
        const Expanded(child: _AnimatedFeedSplit()),
      ],
    );
  }
}

/// List ↔ list+detail layout, animated. The detail pane slides in
/// from the right when a post is selected and slides back out when
/// selection clears.
///
/// To keep text reflow to a minimum, the post-list pane is laid out
/// at its destination width (full or split) the moment the transition
/// begins, then held there for the duration. Cards reflow exactly
/// once per transition rather than every animation frame. Drag-resize
/// is unaffected — it bypasses the controller and updates the list
/// width directly.
class _AnimatedFeedSplit extends ConsumerStatefulWidget {
  const _AnimatedFeedSplit();

  @override
  ConsumerState<_AnimatedFeedSplit> createState() =>
      _AnimatedFeedSplitState();
}

class _AnimatedFeedSplitState extends ConsumerState<_AnimatedFeedSplit>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _t;
  late final Animation<Offset> _detailSlide;

  @override
  void initState() {
    super.initState();
    final initiallySelected = ref.read(currentPostIdProvider) != null;
    _controller = AnimationController(
      vsync: this,
      duration: _splitAnimationDuration,
      value: initiallySelected ? 1.0 : 0.0,
    );
    _t = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _detailSlide = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(_t);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storedWidth = ref.watch(feedListWidthProvider);
    final postSelected = ref.watch(currentPostIdProvider) != null;

    // Toggle the animation only when the selection flips null ↔
    // non-null. Navigating between two posts is not a layout change.
    ref.listen<String?>(currentPostIdProvider, (prev, next) {
      final was = prev != null;
      final now = next != null;
      if (was == now) return;
      if (now) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth;
        final maxList = available - feedDetailMinWidth;
        final upper = maxList < feedListMinWidth ? feedListMinWidth : maxList;
        final selectedListWidth = storedWidth.clamp(feedListMinWidth, upper);
        return AnimatedBuilder(
          animation: _t,
          builder: (context, _) {
            // Hold the list at its split width for the entire
            // transition; only release it to full width once the
            // animation has fully dismissed.
            final renderSplit = postSelected || _controller.value > 0;
            final listWidth = renderSplit ? selectedListWidth : available;
            return Row(
              children: [
                SizedBox(width: listWidth, child: const PostListPane()),
                if (renderSplit) ...[
                  Opacity(
                    opacity: _t.value.clamp(0.0, 1.0),
                    child: FeedSplitHandle(availableWidth: available),
                  ),
                  Expanded(
                    child: ClipRect(
                      child: SlideTransition(
                        position: _detailSlide,
                        child: const PostDetailPane(),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }
}

class _FeedNarrowStack extends ConsumerWidget {
  const _FeedNarrowStack();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTag = ref.watch(currentTagIdProvider);
    final selectedPost = ref.watch(currentPostIdProvider);
    if (selectedPost != null) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          leading: BackButton(onPressed: () => context.pop()),
          title: Text('Post', style: pulseMono(context, size: 12)),
        ),
        body: const PostDetailPane(),
      );
    }
    if (selectedTag != null) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          leading: BackButton(onPressed: () => context.pop()),
          title: Text('Posts', style: pulseMono(context, size: 12)),
        ),
        body: const PostListPane(),
      );
    }
    return const TagTreePane();
  }
}

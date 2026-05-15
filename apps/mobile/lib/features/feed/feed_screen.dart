import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import 'post_list_pane.dart';
import 'tag_tree_pane.dart';
import '../post_detail/post_detail_pane.dart';

const _wideBreakpoint = 720.0;

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

class _FeedWideLayout extends StatelessWidget {
  const _FeedWideLayout();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Row(
      children: [
        const SizedBox(width: 224, child: TagTreePane()),
        VerticalDivider(width: 1, color: t.hair, thickness: 1),
        const SizedBox(width: 320, child: PostListPane()),
        VerticalDivider(width: 1, color: t.hair, thickness: 1),
        const Expanded(child: PostDetailPane()),
      ],
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

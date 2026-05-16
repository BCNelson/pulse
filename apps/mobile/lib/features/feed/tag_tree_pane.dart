import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/ferry_client.dart';
import '../../core/router.dart';
import '../../design/atoms/pulse_button.dart';
import '../../design/atoms/pulse_section_head.dart';
import '../../design/atoms/pulse_tag_row.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
import '../../graphql/__generated__/schema.schema.gql.dart';
import '../../graphql/operations/__generated__/tag_tree.data.gql.dart';
import '../../graphql/operations/__generated__/tag_tree.req.gql.dart';
import 'lazy_tag_children.dart';
import 'tag_tree_expansion.dart';

/// Number of inline child levels carried by the `TagTree` and `TagChildren`
/// queries below their root selection. Both fetch the root + 3 nested
/// `children` fragments, so a freshly-rendered subtree root has 3 levels
/// of inline descendants. `_RecursiveChild` decrements this counter as it
/// recurses; on hitting 0 with `hasChildren` true, it triggers a lazy fetch.
const int _inlineChildLevels = 3;

// Navigates to the feed for the tag whose hierarchical slug path is
// [tagPath] (already in the wire form "root/child/leaf"). The current
// route exposes the path as the selection token via
// currentTagIdProvider; this helper just joins it into the URL.
//
// Empty paths fall back to /feed (the no-selection view) — otherwise we
// would generate /feed/t/ which normalizes to /feed/t and matches no
// route.
void _selectTag(BuildContext context, String tagPath) {
  if (tagPath.isEmpty) {
    context.go('/feed');
  } else {
    context.go('/feed/t/$tagPath');
  }
}

class TagTreePane extends ConsumerWidget {
  const TagTreePane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final client = ref.watch(ferryClientProvider);
    // Auto-expand ancestors of the currently selected tag so deep-links
    // (and cold boots that restore via lastRouteKey) land with the right
    // Space already open. The listen handles subsequent navigations; the
    // initial path is applied via a post-frame callback so we don't mutate
    // a provider during build.
    final initialPath = ref.read(currentTagPathProvider);
    if (initialPath != null && initialPath.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(expandedTagPathsProvider.notifier)
            .expandAncestors(initialPath);
      });
    }
    ref.listen<List<String>?>(currentTagPathProvider, (_, next) {
      if (next != null && next.isNotEmpty) {
        ref.read(expandedTagPathsProvider.notifier).expandAncestors(next);
      }
    });
    return Container(
      color: t.paper2,
      child: StreamBuilder(
        stream: client.request(GTagTreeReq()),
        builder: (context, snap) {
          final data = snap.data?.data;
          if (snap.connectionState == ConnectionState.waiting && data == null) {
            return Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: t.ink2),
              ),
            );
          }
          final resp = snap.data;
          if (resp != null && resp.hasErrors) {
            return _ErrorView(
              message: resp.graphqlErrors?.map((e) => e.message).join('\n') ??
                  resp.linkException?.toString() ??
                  'unknown error',
              onRetry: () {
                // ignore: invalid_use_of_protected_member
                client.requestController.add(GTagTreeReq());
              },
            );
          }
          if (data == null) return const SizedBox.shrink();
          final roots = data.myTagRoots.toList();
          if (roots.isEmpty) {
            return const _EmptyView(
              title: 'No tags yet',
              subtitle: 'Ask an admin to grant you access.',
            );
          }
          // Partition roots into "Personal" (user-scoped) and "Spaces".
          final personal =
              roots.where((r) => r.rootKind == GTagRootKind.USER).toList();
          final spaces =
              roots.where((r) => r.rootKind != GTagRootKind.USER).toList();
          return ListView(
            padding: const EdgeInsets.only(top: 4, bottom: 12),
            children: [
              if (spaces.isNotEmpty) ...[
                const PulseSectionHead(title: 'SPACES'),
                for (final root in spaces) _TagNode(node: root, depth: 0),
              ],
              if (personal.isNotEmpty) ...[
                const PulseSectionHead(title: 'PERSONAL'),
                for (final root in personal) _TagNode(node: root, depth: 0),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// _TagNode is recursive: expand=true shows children inline. Expansion
/// state lives in [expandedTagPathsProvider] so it survives FeedScreen
/// remounts triggered by `context.go(...)` tag navigation.
class _TagNode extends ConsumerWidget {
  const _TagNode({required this.node, required this.depth});

  final GTagTreeData_myTagRoots node;
  final int depth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(currentTagIdProvider);
    final isSelected = selected == node.path;
    final expanded = ref.watch(
      expandedTagPathsProvider.select((s) => s.contains(node.path)),
    );
    final hasChildren = node.hasChildren;
    final inlineLeft = _inlineChildLevels - 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            if (hasChildren)
              SizedBox(
                width: 12,
                child: InkWell(
                  onTap: () => ref
                      .read(expandedTagPathsProvider.notifier)
                      .toggle(node.path),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Icon(
                      expanded
                          ? Icons.keyboard_arrow_down
                          : Icons.chevron_right,
                      size: 14,
                      color: context.tokens.ink3,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(width: 12),
            Expanded(
              child: PulseTagRow(
                label: node.displayName,
                indent: depth,
                prefix: node.rootKind == GTagRootKind.USER ? '~' : '#',
                isActive: isSelected,
                onTap: () => _selectTag(context, node.path),
              ),
            ),
          ],
        ),
        if (expanded && hasChildren)
          for (final child in node.children)
            _RecursiveChild(
              child: child,
              depth: depth + 1,
              inlineChildLevels: inlineLeft,
            ),
      ],
    );
  }
}

/// _RecursiveChild adapts the typed nested fragment to _TagNode. The
/// codegen emits a unique type per fragment depth, so we use `dynamic`
/// to keep recursion uniform across levels — and across the inline-vs-
/// lazy boundary, since `TagSummary` shapes match.
///
/// `inlineChildLevels` tracks how many levels of children are still
/// reachable via `child.children` from this node in the current GraphQL
/// response. When it hits 0 and `child.hasChildren` is true, we switch
/// to a lazy fetch via [_LazyChildren].
class _RecursiveChild extends ConsumerWidget {
  const _RecursiveChild({
    required this.child,
    required this.depth,
    required this.inlineChildLevels,
  });

  final dynamic child;
  final int depth;
  final int inlineChildLevels;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = child.path as String;
    final selected = ref.watch(currentTagIdProvider);
    final isSelected = selected == path;
    final expanded = ref.watch(
      expandedTagPathsProvider.select((s) => s.contains(path)),
    );
    final hasChildren = child.hasChildren as bool;
    final canRenderInline = inlineChildLevels > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            if (hasChildren)
              SizedBox(
                width: 12,
                child: InkWell(
                  onTap: () => ref
                      .read(expandedTagPathsProvider.notifier)
                      .toggle(path),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Icon(
                      expanded
                          ? Icons.keyboard_arrow_down
                          : Icons.chevron_right,
                      size: 14,
                      color: context.tokens.ink3,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(width: 12),
            Expanded(
              child: PulseTagRow(
                label: child.displayName as String,
                indent: depth,
                prefix: '·',
                isActive: isSelected,
                onTap: () => _selectTag(context, path),
              ),
            ),
          ],
        ),
        if (expanded && hasChildren)
          if (canRenderInline)
            for (final grandchild in child.children as Iterable)
              _RecursiveChild(
                child: grandchild,
                depth: depth + 1,
                inlineChildLevels: inlineChildLevels - 1,
              )
          else
            _LazyChildren(parentId: child.id as String, depth: depth + 1),
      ],
    );
  }
}

/// Fetches the next subtree under [parentId] and renders it as
/// `_RecursiveChild` rows once the data arrives. Spliced in by
/// `_RecursiveChild` when its inline children are exhausted.
class _LazyChildren extends ConsumerWidget {
  const _LazyChildren({required this.parentId, required this.depth});

  final String parentId;
  final int depth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final async = ref.watch(lazyTagChildrenProvider(parentId));
    return async.when(
      loading: () => Padding(
        padding: EdgeInsets.only(left: 12.0 + depth * 10.0, top: 4, bottom: 4),
        child: SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(strokeWidth: 1.5, color: t.ink3),
        ),
      ),
      error: (err, _) => Padding(
        padding: EdgeInsets.only(left: 12.0 + depth * 10.0, top: 2, bottom: 2),
        child: InkWell(
          onTap: () => ref.invalidate(lazyTagChildrenProvider(parentId)),
          child: Text(
            'failed to load — tap to retry',
            style: TextStyle(
              fontFamily: pulseMonoFamily,
              fontSize: 10,
              color: t.ink3,
            ),
          ),
        ),
      ),
      data: (kids) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final c in kids)
            _RecursiveChild(
              child: c,
              depth: depth,
              inlineChildLevels: _inlineChildLevels - 1,
            ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: pulseMonoFamily,
              fontSize: 11,
              color: t.ink2,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          PulseButton(
            label: 'Retry',
            icon: Icons.refresh,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: pulseMonoFamily,
              fontSize: 11,
              color: t.ink3,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

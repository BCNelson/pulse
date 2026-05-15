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

/// _TagNode is recursive: expand=true shows children inline.
class _TagNode extends ConsumerStatefulWidget {
  const _TagNode({required this.node, required this.depth});

  final GTagTreeData_myTagRoots node;
  final int depth;

  @override
  ConsumerState<_TagNode> createState() => _TagNodeState();
}

class _TagNodeState extends ConsumerState<_TagNode> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(currentTagIdProvider);
    final isSelected = selected == widget.node.path;
    final hasChildren = widget.node.children.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            if (hasChildren)
              SizedBox(
                width: 12,
                child: InkWell(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Icon(
                      _expanded
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
                label: widget.node.displayName,
                indent: widget.depth,
                prefix: widget.node.rootKind == GTagRootKind.USER ? '~' : '#',
                isActive: isSelected,
                onTap: () => _selectTag(context, widget.node.path),
              ),
            ),
          ],
        ),
        if (_expanded && hasChildren)
          for (final child in widget.node.children)
            _RecursiveChild(child: child, depth: widget.depth + 1),
      ],
    );
  }
}

/// _RecursiveChild adapts the typed nested fragment to _TagNode. The
/// codegen emits a unique type per fragment depth, so we build a tiny
/// adapter to keep recursion uniform.
class _RecursiveChild extends StatelessWidget {
  const _RecursiveChild({required this.child, required this.depth});

  final dynamic child;
  final int depth;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final selected = ref.watch(currentTagIdProvider);
        final isSelected = selected == child.path;
        return Padding(
          padding: const EdgeInsets.only(left: 12),
          child: PulseTagRow(
            label: child.displayName as String,
            indent: depth,
            prefix: '·',
            isActive: isSelected,
            onTap: () => _selectTag(context, child.path as String),
          ),
        );
      },
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/selection.dart';
import '../../graphql/__generated__/schema.schema.gql.dart';
import '../../graphql/operations/__generated__/tag_tree.data.gql.dart';
import '../../graphql/operations/__generated__/tag_tree.req.gql.dart';

class TagTreePane extends ConsumerWidget {
  const TagTreePane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    return StreamBuilder(
      stream: client.request(GTagTreeReq()),
      builder: (context, snap) {
        final data = snap.data?.data;
        if (snap.connectionState == ConnectionState.waiting && data == null) {
          return const Center(child: CircularProgressIndicator());
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
        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            for (final root in roots) _TagNode(node: root, depth: 0),
          ],
        );
      },
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
    final selected = ref.watch(selectedTagIdProvider);
    final isSelected = selected == widget.node.id;
    final hasChildren = widget.node.children.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          child: InkWell(
            onTap: () =>
                ref.read(selectedTagIdProvider.notifier).state = widget.node.id,
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.0 + widget.depth * 16,
                right: 8,
                top: 6,
                bottom: 6,
              ),
              child: Row(
                children: [
                  if (hasChildren)
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(_expanded
                          ? Icons.keyboard_arrow_down
                          : Icons.chevron_right),
                      onPressed: () => setState(() => _expanded = !_expanded),
                    )
                  else
                    const SizedBox(width: 24),
                  const SizedBox(width: 4),
                  Icon(
                    widget.node.rootKind == GTagRootKind.USER
                        ? Icons.person_outline
                        : Icons.folder_outlined,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      widget.node.displayName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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

  // The deepest nested type in the query; we stop expanding past depth 3.
  final dynamic child;
  final int depth;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final selected = ref.watch(selectedTagIdProvider);
        final isSelected = selected == child.id;
        return InkWell(
          onTap: () =>
              ref.read(selectedTagIdProvider.notifier).state = child.id,
          child: Container(
            color: isSelected
                ? Theme.of(context).colorScheme.primaryContainer
                : null,
            padding: EdgeInsets.only(
              left: 8.0 + depth * 16 + 28,
              right: 8,
              top: 6,
              bottom: 6,
            ),
            child: Row(
              children: [
                const Icon(Icons.label_outline, size: 14),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    child.displayName,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
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
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(subtitle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/selection.dart';
import '../../graphql/operations/__generated__/search.req.gql.dart';

/// CommandPaletteOverlay wraps the app and listens for Cmd/Ctrl+K to
/// open the palette. The palette overlays everything; Esc dismisses.
class CommandPaletteOverlay extends ConsumerStatefulWidget {
  const CommandPaletteOverlay({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<CommandPaletteOverlay> createState() =>
      _CommandPaletteOverlayState();
}

class _CommandPaletteOverlayState
    extends ConsumerState<CommandPaletteOverlay> {
  bool _open = false;

  void _toggle() => setState(() => _open = !_open);
  void _close() => setState(() => _open = false);

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyK, control: true): _toggle,
        const SingleActivator(LogicalKeyboardKey.keyK, meta: true): _toggle,
        const SingleActivator(LogicalKeyboardKey.escape): _close,
      },
      child: Focus(
        autofocus: true,
        child: Stack(
          children: [
            widget.child,
            if (_open)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _close,
                  child: Container(
                    color: Colors.black54,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 80),
                    child: GestureDetector(
                      onTap: () {},
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: _Palette(onClose: _close),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Palette extends ConsumerStatefulWidget {
  const _Palette({required this.onClose});

  final VoidCallback onClose;

  @override
  ConsumerState<_Palette> createState() => _PaletteState();
}

class _PaletteState extends ConsumerState<_Palette> {
  final _controller = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String v) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      setState(() => _query = v.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 8,
      child: SizedBox(
        height: 480,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search tags or content...',
                  border: OutlineInputBorder(),
                ),
                onChanged: _onChanged,
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: _query.isEmpty
                  ? const Center(child: Text('Type to search.'))
                  : _Results(query: _query, onClose: widget.onClose),
            ),
          ],
        ),
      ),
    );
  }
}

class _Results extends ConsumerWidget {
  const _Results({required this.query, required this.onClose});

  final String query;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(ferryClientProvider);
    return ListView(
      children: [
        _SectionHeader(title: 'Tags'),
        StreamBuilder(
          stream: client.request(
            GSearchTagsReq(
              (b) => b
                ..vars.query = query
                ..vars.first = 5,
            ),
          ),
          builder: (context, snap) {
            final hits = snap.data?.data?.searchTags.toList() ?? [];
            if (hits.isEmpty) {
              return const ListTile(
                dense: true,
                title: Text('No tag matches', style: TextStyle(fontStyle: FontStyle.italic)),
              );
            }
            return Column(
              children: [
                for (final hit in hits)
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.label_outline),
                    title: Text(hit.tag.displayName),
                    subtitle: Text(hit.tag.path),
                    onTap: () {
                      ref.read(selectedTagIdProvider.notifier).state = hit.tag.id;
                      onClose();
                    },
                  ),
              ],
            );
          },
        ),
        const Divider(),
        _SectionHeader(title: 'Posts & comments'),
        StreamBuilder(
          stream: client.request(
            GSearchReq(
              (b) => b
                ..vars.query = query
                ..vars.first = 10,
            ),
          ),
          builder: (context, snap) {
            final edges = snap.data?.data?.search.edges.toList() ?? [];
            if (edges.isEmpty) {
              return const ListTile(
                dense: true,
                title: Text('No content matches', style: TextStyle(fontStyle: FontStyle.italic)),
              );
            }
            return Column(
              children: [
                for (final edge in edges)
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.article_outlined),
                    title: Text(_titleOf(edge.node) ?? '(untitled)'),
                    subtitle: Text(edge.node.G__typename),
                    onTap: () {
                      final id = _idOf(edge.node);
                      if (id != null) {
                        ref.read(selectedPostIdProvider.notifier).state = id;
                      }
                      onClose();
                    },
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  String? _titleOf(dynamic node) {
    try {
      return node.title as String?;
    } catch (_) {
      try {
        return node.body as String?;
      } catch (_) {
        return null;
      }
    }
  }

  String? _idOf(dynamic node) {
    try {
      return node.id as String?;
    } catch (_) {
      return null;
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../core/selection.dart';
import '../../design/atoms/pulse_kbd.dart';
import '../../design/atoms/pulse_section_head.dart';
import '../../design/tokens.dart';
import '../../design/typography.dart';
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

class _CommandPaletteOverlayState extends ConsumerState<CommandPaletteOverlay> {
  bool _open = false;

  void _toggle() => setState(() => _open = !_open);
  void _close() => setState(() => _open = false);

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
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
                    color: t.isDark
                        ? Colors.black.withValues(alpha: 0.7)
                        : Colors.black.withValues(alpha: 0.35),
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 64),
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
    final t = context.tokens;
    return Container(
      height: 480,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: t.paper,
        border: Border.all(color: t.hair),
        borderRadius: BorderRadius.circular(t.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: t.isDark ? 0.5 : 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(t.radiusLg),
        child: Column(
          children: [
            // Search input
            Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
              decoration: BoxDecoration(
                color: t.paper,
                border: Border(bottom: BorderSide(color: t.hair2)),
              ),
              child: Row(
                children: [
                  Text(
                    '⌘',
                    style: TextStyle(
                      fontFamily: pulseMonoFamily,
                      fontSize: 14,
                      color: t.ink3,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      style: TextStyle(fontSize: 14, color: t.ink),
                      decoration: InputDecoration(
                        hintText: 'jump or search…',
                        hintStyle: TextStyle(color: t.ink3, fontSize: 14),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: _onChanged,
                    ),
                  ),
                  const PulseKbd('esc'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: t.paper,
                child: _query.isEmpty
                    ? Center(
                        child: Text(
                          'type to search · tags, posts, comments',
                          style: TextStyle(
                            fontFamily: pulseMonoFamily,
                            fontSize: 11,
                            color: t.ink3,
                          ),
                        ),
                      )
                    : _Results(query: _query, onClose: widget.onClose),
              ),
            ),
            // Footer hint strip
            Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: t.paper2,
                border: Border(top: BorderSide(color: t.hair2)),
              ),
              child: Row(
                children: [
                  const PulseKbd('↵'),
                  const SizedBox(width: 6),
                  Text(
                    'open',
                    style: TextStyle(
                      fontFamily: pulseMonoFamily,
                      fontSize: 10.5,
                      color: t.ink3,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const PulseKbd('↑↓'),
                  const SizedBox(width: 6),
                  Text(
                    'navigate',
                    style: TextStyle(
                      fontFamily: pulseMonoFamily,
                      fontSize: 10.5,
                      color: t.ink3,
                    ),
                  ),
                ],
              ),
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
      padding: const EdgeInsets.only(bottom: 6),
      children: [
        const PulseSectionHead(title: 'TAGS'),
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
              return _Empty(label: 'no tag matches');
            }
            return Column(
              children: [
                for (final hit in hits)
                  _ResultRow(
                    prefix: '#',
                    title: hit.tag.displayName,
                    subtitle: hit.tag.path,
                    onTap: () {
                      ref.read(selectedTagIdProvider.notifier).state =
                          hit.tag.id;
                      onClose();
                    },
                  ),
              ],
            );
          },
        ),
        const PulseSectionHead(title: 'POSTS · COMMENTS'),
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
              return _Empty(label: 'no content matches');
            }
            return Column(
              children: [
                for (final edge in edges)
                  _ResultRow(
                    prefix: _prefixOf(edge.node.G__typename),
                    title: _titleOf(edge.node) ?? '(untitled)',
                    subtitle: edge.node.G__typename.toLowerCase(),
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

  String _prefixOf(String typename) {
    switch (typename) {
      case 'Post':
        return '¶';
      case 'Comment':
        return '↳';
      case 'Task':
        return '☐';
      case 'Message':
        return '✉';
      default:
        return '·';
    }
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

class _ResultRow extends StatelessWidget {
  const _ResultRow({
    required this.prefix,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String prefix;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        child: Row(
          children: [
            SizedBox(
              width: 18,
              child: Text(
                prefix,
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 12,
                  color: t.ink3,
                  height: 1.0,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: t.ink,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: pulseMonoFamily,
                        fontSize: 10.5,
                        color: t.ink3,
                        height: 1.3,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: pulseMonoFamily,
          fontSize: 11,
          color: t.ink3,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

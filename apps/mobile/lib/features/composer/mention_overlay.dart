import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ferry_client.dart';
import '../../design/tokens.dart';
import '../../graphql/operations/__generated__/search.req.gql.dart';

/// MentionOverlay wraps the markdown-mode TextField with a typeahead
/// popover that fires when the user types `@` or `#` at the start of a
/// token. Picking a suggestion splices the canonical Markdown-link form
/// into the controller — that link form is what the backend extracts
/// and persists, so a bare `@foo` typed without using the popover stays
/// plain text and is never resolved to a principal or tag.
class MentionOverlay extends ConsumerStatefulWidget {
  const MentionOverlay({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.child,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Widget child;

  @override
  ConsumerState<MentionOverlay> createState() => _MentionOverlayState();
}

enum _Trigger { user, tag }

class _ActiveTrigger {
  _ActiveTrigger({
    required this.kind,
    required this.start,
    required this.partial,
  });
  final _Trigger kind;

  /// The character index of the trigger character (`@` or `#`).
  final int start;

  /// The text between the trigger character and the caret.
  final String partial;
}

class _MentionOverlayState extends ConsumerState<MentionOverlay> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;
  _ActiveTrigger? _active;
  List<_Suggestion> _suggestions = const [];
  int _highlighted = 0;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    widget.focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant MentionOverlay old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller.removeListener(_onTextChanged);
      widget.controller.addListener(_onTextChanged);
    }
    if (old.focusNode != widget.focusNode) {
      old.focusNode.removeListener(_onFocusChanged);
      widget.focusNode.addListener(_onFocusChanged);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.controller.removeListener(_onTextChanged);
    widget.focusNode.removeListener(_onFocusChanged);
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChanged() {
    if (!widget.focusNode.hasFocus) {
      _dismiss();
    }
  }

  void _onTextChanged() {
    if (!widget.focusNode.hasFocus) {
      _dismiss();
      return;
    }
    final next = _detectTrigger(widget.controller);
    if (next == null) {
      _dismiss();
      return;
    }
    _active = next;
    _highlighted = 0;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 150), _runQuery);
    _showOrUpdateOverlay();
  }

  Future<void> _runQuery() async {
    final active = _active;
    if (active == null) return;
    final client = ref.read(ferryClientProvider);
    if (active.kind == _Trigger.user) {
      final stream = client.request(
        GSearchUsersReq(
          (b) => b
            ..vars.query = active.partial
            ..vars.first = 5,
        ),
      );
      final resp = await stream.firstWhere((r) => r.data != null);
      if (!mounted || _active != active) return;
      final users = resp.data?.searchUsers.toList() ?? const [];
      setState(() {
        _suggestions = [
          for (final u in users)
            _Suggestion(
              kind: _Trigger.user,
              label: '@${u.homeTag?.slug ?? u.displayName.toLowerCase()}',
              subtitle: u.displayName,
              slug: u.homeTag?.slug ?? u.displayName.toLowerCase(),
            ),
        ];
      });
      _entry?.markNeedsBuild();
    } else {
      final stream = client.request(
        GSearchTagsReq(
          (b) => b
            ..vars.query = active.partial
            ..vars.first = 5,
        ),
      );
      final resp = await stream.firstWhere((r) => r.data != null);
      if (!mounted || _active != active) return;
      final hits = resp.data?.searchTags.toList() ?? const [];
      setState(() {
        _suggestions = [
          for (final h in hits)
            _Suggestion(
              kind: _Trigger.tag,
              label: '#${h.tag.path}',
              subtitle: h.tag.displayName,
              slug: h.tag.path,
            ),
        ];
      });
      _entry?.markNeedsBuild();
    }
  }

  void _showOrUpdateOverlay() {
    if (_entry != null) {
      _entry!.markNeedsBuild();
      return;
    }
    _entry = OverlayEntry(builder: _buildPopover);
    Overlay.of(context, rootOverlay: true).insert(_entry!);
  }

  void _removeOverlay() {
    _entry?.remove();
    _entry?.dispose();
    _entry = null;
  }

  void _dismiss() {
    if (_active == null && _entry == null) return;
    _active = null;
    _suggestions = const [];
    _highlighted = 0;
    _removeOverlay();
    if (mounted) setState(() {});
  }

  Widget _buildPopover(BuildContext overlayCtx) {
    final t = context.tokens;
    final hasResults = _suggestions.isNotEmpty;
    return Positioned(
      width: 280,
      child: CompositedTransformFollower(
        link: _link,
        showWhenUnlinked: false,
        // Anchor: just below the composer; we render the popover above
        // the bar so it appears between the toolbar and the keyboard.
        targetAnchor: Alignment.topLeft,
        followerAnchor: Alignment.bottomLeft,
        offset: const Offset(0, -2),
        child: Material(
          color: t.paper,
          elevation: 4,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: t.hair),
            borderRadius: BorderRadius.circular(t.radius),
          ),
          child: hasResults
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (var i = 0; i < _suggestions.length; i++)
                      _SuggestionRow(
                        suggestion: _suggestions[i],
                        highlighted: i == _highlighted,
                        onTap: () => _accept(_suggestions[i]),
                      ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'no matches',
                    style: TextStyle(color: t.ink3, fontSize: 12),
                  ),
                ),
        ),
      ),
    );
  }

  void _accept(_Suggestion s) {
    final active = _active;
    if (active == null) return;
    final controller = widget.controller;
    final caret = controller.selection.baseOffset;
    if (caret < 0) return;
    final text = controller.text;
    // [trigger, caret) is the partial token (including the @ or # char).
    final triggerChar = active.kind == _Trigger.user ? '@' : '#';
    final scheme = active.kind == _Trigger.user ? 'pulse-user' : 'pulse-tag';
    final canonical = '[$triggerChar${s.slug}]($scheme:${s.slug}) ';
    final newText = text.replaceRange(active.start, caret, canonical);
    final newOffset = active.start + canonical.length;
    controller.value = controller.value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
      composing: TextRange.empty,
    );
    _dismiss();
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (_active == null || _suggestions.isEmpty) {
      return KeyEventResult.ignored;
    }
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _highlighted = (_highlighted + 1) % _suggestions.length;
      });
      _entry?.markNeedsBuild();
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _highlighted =
            (_highlighted - 1 + _suggestions.length) % _suggestions.length;
      });
      _entry?.markNeedsBuild();
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.tab) {
      _accept(_suggestions[_highlighted]);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      _dismiss();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: _handleKey,
      canRequestFocus: false,
      descendantsAreFocusable: true,
      child: CompositedTransformTarget(
        link: _link,
        child: widget.child,
      ),
    );
  }
}

class _Suggestion {
  const _Suggestion({
    required this.kind,
    required this.label,
    required this.subtitle,
    required this.slug,
  });
  final _Trigger kind;
  final String label;
  final String subtitle;
  final String slug;
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({
    required this.suggestion,
    required this.highlighted,
    required this.onTap,
  });

  final _Suggestion suggestion;
  final bool highlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return InkWell(
      onTap: onTap,
      child: Container(
        color: highlighted ? t.paper2 : null,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          children: [
            Text(
              suggestion.label,
              style: TextStyle(
                color: t.blueInk,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                suggestion.subtitle,
                style: TextStyle(color: t.ink2, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Scan back from the caret to find a `@` or `#` that starts a token.
/// A token starts when the trigger character is preceded by start-of-string
/// or whitespace and there's no whitespace between it and the caret. The
/// captured `partial` excludes the leading trigger character.
_ActiveTrigger? _detectTrigger(TextEditingController c) {
  final sel = c.selection;
  if (!sel.isCollapsed) return null;
  final caret = sel.baseOffset;
  if (caret < 0) return null;
  final text = c.text;
  // Walk back from the caret, skipping over valid slug characters until
  // we hit a trigger or a boundary.
  var i = caret - 1;
  while (i >= 0) {
    final ch = text.codeUnitAt(i);
    if (ch == 0x40 /* @ */ || ch == 0x23 /* # */) {
      final prevOk = i == 0 || _isBoundary(text.codeUnitAt(i - 1));
      if (!prevOk) return null;
      final kind = ch == 0x40 ? _Trigger.user : _Trigger.tag;
      return _ActiveTrigger(
        kind: kind,
        start: i,
        partial: text.substring(i + 1, caret),
      );
    }
    if (_isSlugChar(ch, kind: _Trigger.tag)) {
      i--;
      continue;
    }
    return null;
  }
  return null;
}

bool _isBoundary(int ch) {
  // Whitespace, newline, or common openers count as token boundaries.
  return ch == 0x20 ||
      ch == 0x09 ||
      ch == 0x0A ||
      ch == 0x0D ||
      ch == 0x28 || // (
      ch == 0x5B; // [
}

bool _isSlugChar(int ch, {required _Trigger kind}) {
  // a-z, A-Z, 0-9, '-' for both. '/' only for tag paths.
  if ((ch >= 0x30 && ch <= 0x39) ||
      (ch >= 0x41 && ch <= 0x5A) ||
      (ch >= 0x61 && ch <= 0x7A) ||
      ch == 0x2D) {
    return true;
  }
  return ch == 0x2F /* / */;
}

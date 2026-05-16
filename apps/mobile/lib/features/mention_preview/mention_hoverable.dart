import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mention_hover_card.dart';
import 'mention_preview_provider.dart';

/// MentionHoverable wraps any widget so that hovering over it pops a
/// [MentionHoverCard] anchored to its bottom edge. Touch devices and
/// platforms without hover ignore the wrapper entirely; tap behavior
/// is the child's responsibility.
///
/// The hover delay [_openDelay] avoids accidental cards on the way
/// through. [_closeDelay] keeps the card mounted briefly after the
/// pointer leaves so users can move into the card itself (e.g. to
/// select text or follow a link inside it later).
class MentionHoverable extends ConsumerStatefulWidget {
  const MentionHoverable({
    super.key,
    required this.target,
    required this.child,
    this.onTap,
  });

  factory MentionHoverable.user({
    Key? key,
    required String slug,
    required Widget child,
    VoidCallback? onTap,
  }) =>
      MentionHoverable(
        key: key,
        target: MentionPreviewUserTarget(slug),
        onTap: onTap,
        child: child,
      );

  factory MentionHoverable.tag({
    Key? key,
    required String path,
    required Widget child,
    VoidCallback? onTap,
  }) =>
      MentionHoverable(
        key: key,
        target: MentionPreviewTagTarget(path),
        onTap: onTap,
        child: child,
      );

  final MentionPreviewTarget target;
  final Widget child;

  /// Optional tap handler. Hover is purely additive — taps still flow
  /// through to whatever the child widget already handles.
  final VoidCallback? onTap;

  @override
  ConsumerState<MentionHoverable> createState() => _MentionHoverableState();
}

class _MentionHoverableState extends ConsumerState<MentionHoverable> {
  static const Duration _openDelay = Duration(milliseconds: 320);
  static const Duration _closeDelay = Duration(milliseconds: 120);

  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;
  Timer? _openTimer;
  Timer? _closeTimer;

  @override
  void dispose() {
    _openTimer?.cancel();
    _closeTimer?.cancel();
    _removeEntry();
    super.dispose();
  }

  void _onEnter(PointerEvent _) {
    _closeTimer?.cancel();
    _closeTimer = null;
    if (_entry != null) return;
    _openTimer?.cancel();
    _openTimer = Timer(_openDelay, _showCard);
  }

  void _onExit(PointerEvent _) {
    _openTimer?.cancel();
    _openTimer = null;
    if (_entry == null) return;
    _closeTimer?.cancel();
    _closeTimer = Timer(_closeDelay, _removeEntry);
  }

  void _showCard() {
    if (!mounted) return;
    if (_entry != null) return;
    _entry = OverlayEntry(
      builder: (overlayContext) => Positioned(
        width: 260,
        child: CompositedTransformFollower(
          link: _link,
          showWhenUnlinked: false,
          // Anchor: below the child, aligned to the start (left in LTR).
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: const Offset(0, 4),
          child: MouseRegion(
            onEnter: (_) {
              // Keep the card open if the pointer moves into it.
              _closeTimer?.cancel();
              _closeTimer = null;
            },
            onExit: (_) {
              _closeTimer?.cancel();
              _closeTimer = Timer(_closeDelay, _removeEntry);
            },
            child: MentionHoverCard(target: widget.target),
          ),
        ),
      ),
    );
    final overlay = Overlay.of(context, rootOverlay: true);
    overlay.insert(_entry!);
  }

  void _removeEntry() {
    _entry?.remove();
    _entry?.dispose();
    _entry = null;
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.onTap != null
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onTap,
            child: widget.child,
          )
        : widget.child;
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      cursor: SystemMouseCursors.click,
      child: CompositedTransformTarget(
        link: _link,
        child: child,
      ),
    );
  }
}

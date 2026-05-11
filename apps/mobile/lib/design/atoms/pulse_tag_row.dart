import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

/// Sidebar tag row matching `.hf-row`. Supports indent levels, an "active"
/// state with a left-side ink marker, and right-side count / unread-dot /
/// attention badge.
class PulseTagRow extends StatelessWidget {
  const PulseTagRow({
    super.key,
    required this.label,
    this.prefix = '#',
    this.indent = 0,
    this.isActive = false,
    this.count,
    this.unread = false,
    this.attentionCount,
    this.dotColor,
    this.onTap,
  });

  final String label;

  /// `#` for top-level tags, `·` for nested ones.
  final String prefix;

  /// Nesting depth, 0–3.
  final int indent;
  final bool isActive;

  /// A trailing soft count (e.g. unread posts).
  final int? count;

  /// Show a small ink dot to indicate unread (overrides [count]).
  final bool unread;

  /// Show an amber attention pill (e.g. assignments needing action).
  final int? attentionCount;

  /// Optional colored dot before the label (top-level tag color).
  final Color? dotColor;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final leftPad = 18.0 + indent * 12.0;

    Widget? trailing;
    if (attentionCount != null) {
      trailing = Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        decoration: BoxDecoration(
          color: t.amber,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          '$attentionCount',
          style: TextStyle(
            fontFamily: pulseMonoFamily,
            fontSize: 10,
            color: t.ink,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.02 * 10,
            height: 1.0,
          ),
        ),
      );
    } else if (unread) {
      trailing = Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(color: t.ink, shape: BoxShape.circle),
      );
    } else if (count != null) {
      trailing = Text(
        '$count',
        style: TextStyle(
          fontFamily: pulseMonoFamily,
          fontSize: 10,
          color: t.ink3,
          height: 1.0,
        ),
      );
    }

    return Material(
      color: isActive ? t.paper : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            if (isActive)
              Positioned(
                left: 0,
                top: 4,
                bottom: 4,
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    color: t.ink,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(
                left: leftPad,
                right: 12,
                top: 4,
                bottom: 4,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 14,
                    child: Text(
                      prefix,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: pulseMonoFamily,
                        fontSize: 11,
                        color: t.ink3,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (dotColor != null) ...[
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? t.ink : t.ink2,
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                  ),
                  if (trailing != null) ...[
                    const SizedBox(width: 6),
                    trailing,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

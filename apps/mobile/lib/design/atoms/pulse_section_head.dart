import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

/// Mono uppercase section header. Used both in the sidebar (`.hf-side .sec`)
/// and in the inbox (`.hf-inbox-section-head`).
class PulseSectionHead extends StatelessWidget {
  const PulseSectionHead({
    super.key,
    required this.title,
    this.count,
    this.action,
    this.padding =
        const EdgeInsets.only(top: 10, bottom: 4, left: 12, right: 12),
    this.dense = true,
  });

  /// Convenience for the inbox style with a counter pill and wider padding.
  const PulseSectionHead.inbox({
    super.key,
    required this.title,
    this.count,
    this.action,
  })  : padding =
            const EdgeInsets.only(top: 10, bottom: 6, left: 22, right: 22),
        dense = false;

  final String title;
  final int? count;
  final Widget? action;
  final EdgeInsets padding;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontFamily: pulseMonoFamily,
              fontSize: dense ? 10 : 10.5,
              letterSpacing: 0.08 * (dense ? 10 : 10.5),
              color: t.ink3,
              height: 1.2,
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: t.paper2,
                border: Border.all(color: t.hair),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 10,
                  color: t.ink2,
                  letterSpacing: 0.04 * 10,
                  height: 1.0,
                ),
              ),
            ),
          ],
          const Spacer(),
          if (action != null) action!,
        ],
      ),
    );
  }
}

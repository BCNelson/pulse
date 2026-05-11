import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

/// Centered "TODAY" style day divider with hairlines on both sides.
/// Matches `.hf-day`.
class PulseDayDivider extends StatelessWidget {
  const PulseDayDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Divider(color: t.hair2, height: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              label.toUpperCase(),
              style: TextStyle(
                fontFamily: pulseMonoFamily,
                fontSize: 10,
                letterSpacing: 0.08 * 10,
                color: t.ink3,
                height: 1.0,
              ),
            ),
          ),
          Expanded(child: Divider(color: t.hair2, height: 1)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

/// Footer-style status strip. Used on wide layouts only.
class PulseStatusBar extends StatelessWidget {
  const PulseStatusBar({super.key, this.left, this.right = const []});

  final String? left;
  final List<Widget> right;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: t.paper2,
        border: Border(top: BorderSide(color: t.hair)),
      ),
      child: Row(
        children: [
          if (left != null)
            Text(
              left!,
              style: TextStyle(
                fontFamily: pulseMonoFamily,
                fontSize: 10.5,
                color: t.ink,
                height: 1.2,
              ),
            ),
          const Spacer(),
          for (int i = 0; i < right.length; i++) ...[
            if (i > 0) const SizedBox(width: 14),
            right[i],
          ],
        ],
      ),
    );
  }
}

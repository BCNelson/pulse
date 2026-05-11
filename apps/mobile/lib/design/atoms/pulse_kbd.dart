import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

/// Keyboard hint pill matching `.hf-kbd`.
class PulseKbd extends StatelessWidget {
  const PulseKbd(this.label, {super.key, this.solid = false});

  final String label;
  final bool solid;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      height: 16,
      constraints: const BoxConstraints(minWidth: 14),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: solid ? t.ink : t.paper,
        border: Border.all(color: solid ? t.ink : t.hair),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: pulseMonoFamily,
          fontSize: 10,
          color: solid ? t.paper : t.ink2,
          letterSpacing: 0.04 * 10,
          height: 1.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';
import 'pulse_kbd.dart';

enum PulseButtonVariant { normal, primary, ghost }

/// Compact button matching `.hf-btn` — small, mono-style, hairline border.
class PulseButton extends StatelessWidget {
  const PulseButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = PulseButtonVariant.normal,
    this.kbdHint,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final PulseButtonVariant variant;
  final String? kbdHint;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final isPrimary = variant == PulseButtonVariant.primary;
    final isGhost = variant == PulseButtonVariant.ghost;

    final bg = isPrimary ? t.ink : (isGhost ? Colors.transparent : t.paper);
    final fg = isPrimary ? t.paper : t.ink;
    final border = isGhost ? Colors.transparent : (isPrimary ? t.ink : t.hair);

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(t.radius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(t.radius),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(
            border: Border.all(color: border),
            borderRadius: BorderRadius.circular(t.radius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 12, color: fg),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontFamily: pulseMonoFamily,
                  fontSize: 11,
                  color: fg,
                  height: 1.2,
                ),
              ),
              if (kbdHint != null) ...[
                const SizedBox(width: 8),
                PulseKbd(kbdHint!, solid: isPrimary),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

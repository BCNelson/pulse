import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

enum PulseTagChipVariant { normal, isThis, solid }

/// Tag chip matching `.hf-chip` (and `.wf-chip` in atoms.jsx). Renders
/// `#engineering/backend/auth` with a faint hash and hairline border.
class PulseTagChip extends StatelessWidget {
  const PulseTagChip({
    super.key,
    required this.path,
    this.variant = PulseTagChipVariant.normal,
    this.onTap,
    this.dotColor,
  });

  final String path;
  final PulseTagChipVariant variant;
  final VoidCallback? onTap;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final bg = switch (variant) {
      PulseTagChipVariant.normal => t.paper,
      PulseTagChipVariant.isThis => t.paper2,
      PulseTagChipVariant.solid => t.ink,
    };
    final fg = switch (variant) {
      PulseTagChipVariant.normal => t.ink2,
      PulseTagChipVariant.isThis => t.ink3,
      PulseTagChipVariant.solid => t.paper,
    };
    final border = switch (variant) {
      PulseTagChipVariant.normal => t.hair,
      PulseTagChipVariant.isThis => t.hair,
      PulseTagChipVariant.solid => t.ink,
    };
    final child = Container(
      height: 17,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dotColor != null) ...[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            '#',
            style: TextStyle(
              fontFamily: pulseMonoFamily,
              fontSize: 10.5,
              color: variant == PulseTagChipVariant.solid ? t.paper : t.ink3,
              height: 1.0,
            ),
          ),
          Text(
            path,
            style: TextStyle(
              fontFamily: pulseMonoFamily,
              fontSize: 10.5,
              color: fg,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
    if (onTap == null) return child;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: child,
    );
  }
}

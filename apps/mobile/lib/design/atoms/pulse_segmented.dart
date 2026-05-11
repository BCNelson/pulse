import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

/// Segmented control matching `.hf-seg`.
///
/// Sizes naturally when the parent gives it room. When the natural width
/// exceeds the parent constraint (e.g. 5 options on a phone), the row
/// scrolls horizontally rather than overflowing or truncating labels.
class PulseSegmented<T> extends StatelessWidget {
  const PulseSegmented({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.labelOf,
  });

  final List<T> options;
  final T selected;
  final ValueChanged<T> onChanged;
  final String Function(T) labelOf;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      height: 22,
      decoration: BoxDecoration(
        color: t.paper,
        border: Border.all(color: t.hair),
        borderRadius: BorderRadius.circular(t.radius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(t.radius),
        // SingleChildScrollView keeps natural sizing when the parent has
        // room and silently scrolls when it doesn't (e.g. 5 options on a
        // phone).
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < options.length; i++) ...[
                  if (i > 0)
                    VerticalDivider(width: 1, color: t.hair, thickness: 1),
                  _Seg<T>(
                    option: options[i],
                    selected: selected == options[i],
                    onChanged: onChanged,
                    label: labelOf(options[i]),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Seg<T> extends StatelessWidget {
  const _Seg({
    required this.option,
    required this.selected,
    required this.onChanged,
    required this.label,
  });

  final T option;
  final bool selected;
  final ValueChanged<T> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Material(
      color: selected ? t.ink : Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(option),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 1),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: pulseMonoFamily,
                fontSize: 11,
                color: selected ? t.paper : t.ink2,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

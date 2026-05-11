import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

/// Page header matching `.hf-pagehead`. Big title, optional mono subtitle,
/// and an optional meta row with pip separators.
class PulsePageHead extends StatelessWidget {
  const PulsePageHead({
    super.key,
    required this.title,
    this.subtitle,
    this.metaParts = const [],
    this.trailing,
    this.padding =
        const EdgeInsets.only(left: 22, right: 22, top: 14, bottom: 10),
  });

  final String title;
  final String? subtitle;
  final List<String> metaParts;
  final Widget? trailing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: t.hair2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(width: 14),
                Flexible(
                  child: Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: pulseMonoFamily,
                      fontSize: 11,
                      color: t.ink3,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
              if (trailing != null) ...[
                const Spacer(),
                trailing!,
              ],
            ],
          ),
          if (metaParts.isNotEmpty) ...[
            const SizedBox(height: 8),
            DefaultTextStyle(
              style: TextStyle(
                fontFamily: pulseMonoFamily,
                fontSize: 11,
                color: t.ink2,
                height: 1.2,
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for (int i = 0; i < metaParts.length; i++) ...[
                    if (i > 0)
                      Container(
                        width: 2,
                        height: 2,
                        decoration: BoxDecoration(
                          color: t.ink3,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Text(metaParts[i]),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

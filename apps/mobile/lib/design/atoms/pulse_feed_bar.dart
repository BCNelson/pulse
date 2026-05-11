import 'package:flutter/material.dart';

import '../tokens.dart';

/// Compact filter / sort strip above feeds — matches `.hf-feedbar`.
class PulseFeedBar extends StatelessWidget {
  const PulseFeedBar({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
  });

  final List<Widget> children;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: t.hair2)),
      ),
      child: Row(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: 10),
            children[i],
          ],
        ],
      ),
    );
  }
}

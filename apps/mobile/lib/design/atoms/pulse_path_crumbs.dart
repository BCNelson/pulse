import 'package:flutter/material.dart';

import '../tokens.dart';
import '../typography.dart';

/// Breadcrumb-style tag path: `#engineering / backend / auth` with the
/// leaf bolded. Mirrors the topbar `.crumbs` block and `PathCrumbs` atom.
class PulsePathCrumbs extends StatelessWidget {
  const PulsePathCrumbs({super.key, required this.path, this.leafIndex});

  final String path;
  final int? leafIndex;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final parts = path.split('/');
    final leaf = leafIndex ?? parts.length - 1;
    final segments = <InlineSpan>[];
    segments.add(TextSpan(
      text: '#',
      style: TextStyle(
        fontFamily: pulseMonoFamily,
        fontSize: 11,
        color: t.ink3,
        height: 1.2,
      ),
    ));
    for (int i = 0; i < parts.length; i++) {
      if (i > 0) {
        segments.add(TextSpan(
          text: ' / ',
          style: TextStyle(
            fontFamily: pulseMonoFamily,
            fontSize: 11,
            color: t.ink3,
            height: 1.2,
          ),
        ));
      }
      segments.add(TextSpan(
        text: parts[i],
        style: TextStyle(
          fontFamily: pulseMonoFamily,
          fontSize: 11,
          color: i == leaf ? t.ink : t.ink2,
          fontWeight: i == leaf ? FontWeight.w600 : FontWeight.w400,
          height: 1.2,
        ),
      ));
    }
    return RichText(
        text: TextSpan(children: segments), overflow: TextOverflow.ellipsis);
  }
}

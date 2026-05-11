import 'package:flutter/material.dart';

import 'tokens.dart';

/// System monospace family name. Flutter resolves this through the
/// platform font fallback chain.
const String pulseMonoFamily = 'monospace';

/// Build a [TextTheme] that matches the designer's CSS sizing.
///
/// Sizes are taken verbatim from `hifi.css`:
/// - body: 13px (rendered inside cards)
/// - page title: 22px (`.hf-pagehead .title`)
/// - post title: 14px (`.hf-post .ttl`)
/// - mono labels: 10–11px (kbd, section heads, breadcrumbs)
TextTheme pulseTextTheme(PulseTokens t) {
  return TextTheme(
    // Page titles
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.012 * 22,
      color: t.ink,
      height: 1.2,
    ),
    // Post / section titles
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.005 * 14,
      color: t.ink,
      height: 1.35,
    ),
    titleSmall: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: t.ink,
      height: 1.35,
    ),
    // Body
    bodyMedium: TextStyle(
      fontSize: 13,
      color: t.ink,
      height: 1.4,
    ),
    bodySmall: TextStyle(
      fontSize: 12.5,
      color: t.ink2,
      height: 1.4,
    ),
    // Captions / mono metadata
    labelMedium: TextStyle(
      fontFamily: pulseMonoFamily,
      fontSize: 11,
      color: t.ink2,
      letterSpacing: 0.04 * 11,
      height: 1.3,
    ),
    labelSmall: TextStyle(
      fontFamily: pulseMonoFamily,
      fontSize: 10,
      color: t.ink3,
      letterSpacing: 0.08 * 10,
      height: 1.3,
    ),
  );
}

/// Convenience: a mono label style derived from the current theme.
TextStyle pulseMono(
  BuildContext context, {
  double size = 11,
  Color? color,
  FontWeight? weight,
  double letterSpacing = 0.04,
}) {
  final t = Theme.of(context).extension<PulseTokens>()!;
  return TextStyle(
    fontFamily: pulseMonoFamily,
    fontSize: size,
    color: color ?? t.ink2,
    fontWeight: weight,
    letterSpacing: letterSpacing * size,
    height: 1.3,
  );
}

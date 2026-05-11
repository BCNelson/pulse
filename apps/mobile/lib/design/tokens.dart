import 'package:flutter/material.dart';

/// Design tokens for Pulse, ported from the designer's `hifi.css` /
/// `hifi-themes.css`. Twelve themes rebind the same names; pick one with
/// [PulseThemeKey] and the rest of the UI consumes [PulseTokens] via
/// `Theme.of(context).extension<PulseTokens>()!`.
class PulseTokens extends ThemeExtension<PulseTokens> {
  const PulseTokens({
    required this.paper,
    required this.paper2,
    required this.paper3,
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.hair,
    required this.hair2,
    required this.amber,
    required this.amberSoft,
    required this.amberInk,
    required this.green,
    required this.greenSoft,
    required this.greenInk,
    required this.blue,
    required this.blueSoft,
    required this.blueInk,
    required this.accent,
    required this.accentInk,
    required this.accentOn,
    required this.isDark,
  });

  /// Primary reading surface — `--paper`.
  final Color paper;

  /// Slightly tinted surface (sidebar, chips) — `--paper-2`.
  final Color paper2;

  /// Darker surface for sunken/hover states — `--paper-3`.
  final Color paper3;

  /// Dominant text & primary fill — `--ink`.
  final Color ink;

  /// Secondary text — `--ink-2`.
  final Color ink2;

  /// Tertiary / muted text — `--ink-3`.
  final Color ink3;

  /// Hairline divider — `--hair`.
  final Color hair;

  /// Lighter hairline (inner separators) — `--hair-2`.
  final Color hair2;

  /// Urgent / warning fill — `--amber`.
  final Color amber;

  /// Background wash for "due" badges — `--amber-soft`.
  final Color amberSoft;

  /// Text-on-amber-soft — `--amber-ink`.
  final Color amberInk;

  /// "Decided" semantic — `--green`.
  final Color green;
  final Color greenSoft;
  final Color greenInk;

  /// Tag / informational — `--blue`.
  final Color blue;
  final Color blueSoft;
  final Color blueInk;

  /// Accent for "bold" / "shell-accent" themes. Falls back to [ink] when
  /// the theme doesn't define its own accent.
  final Color accent;
  final Color accentInk;
  final Color accentOn;

  /// Whether this is a dark theme (drives a few contrast-sensitive bits
  /// that can't be derived from individual colors — e.g. the live-dot halo).
  final bool isDark;

  /// Card / chip rounding from `--r`.
  double get radius => 5;

  /// Larger rounding from `--r-lg`.
  double get radiusLg => 8;

  /// A neutral hairline that reads on both [paper] and [paper2]; used by
  /// dividers that span two surfaces.
  Color get divider => hair;

  @override
  PulseTokens copyWith({
    Color? paper,
    Color? paper2,
    Color? paper3,
    Color? ink,
    Color? ink2,
    Color? ink3,
    Color? hair,
    Color? hair2,
    Color? amber,
    Color? amberSoft,
    Color? amberInk,
    Color? green,
    Color? greenSoft,
    Color? greenInk,
    Color? blue,
    Color? blueSoft,
    Color? blueInk,
    Color? accent,
    Color? accentInk,
    Color? accentOn,
    bool? isDark,
  }) {
    return PulseTokens(
      paper: paper ?? this.paper,
      paper2: paper2 ?? this.paper2,
      paper3: paper3 ?? this.paper3,
      ink: ink ?? this.ink,
      ink2: ink2 ?? this.ink2,
      ink3: ink3 ?? this.ink3,
      hair: hair ?? this.hair,
      hair2: hair2 ?? this.hair2,
      amber: amber ?? this.amber,
      amberSoft: amberSoft ?? this.amberSoft,
      amberInk: amberInk ?? this.amberInk,
      green: green ?? this.green,
      greenSoft: greenSoft ?? this.greenSoft,
      greenInk: greenInk ?? this.greenInk,
      blue: blue ?? this.blue,
      blueSoft: blueSoft ?? this.blueSoft,
      blueInk: blueInk ?? this.blueInk,
      accent: accent ?? this.accent,
      accentInk: accentInk ?? this.accentInk,
      accentOn: accentOn ?? this.accentOn,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  PulseTokens lerp(ThemeExtension<PulseTokens>? other, double t) {
    if (other is! PulseTokens) return this;
    return PulseTokens(
      paper: Color.lerp(paper, other.paper, t)!,
      paper2: Color.lerp(paper2, other.paper2, t)!,
      paper3: Color.lerp(paper3, other.paper3, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      ink2: Color.lerp(ink2, other.ink2, t)!,
      ink3: Color.lerp(ink3, other.ink3, t)!,
      hair: Color.lerp(hair, other.hair, t)!,
      hair2: Color.lerp(hair2, other.hair2, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      amberSoft: Color.lerp(amberSoft, other.amberSoft, t)!,
      amberInk: Color.lerp(amberInk, other.amberInk, t)!,
      green: Color.lerp(green, other.green, t)!,
      greenSoft: Color.lerp(greenSoft, other.greenSoft, t)!,
      greenInk: Color.lerp(greenInk, other.greenInk, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      blueSoft: Color.lerp(blueSoft, other.blueSoft, t)!,
      blueInk: Color.lerp(blueInk, other.blueInk, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentInk: Color.lerp(accentInk, other.accentInk, t)!,
      accentOn: Color.lerp(accentOn, other.accentOn, t)!,
      isDark: t < 0.5 ? isDark : other.isDark,
    );
  }
}

/// Shorthand for use within widgets.
extension PulseTokensContext on BuildContext {
  PulseTokens get tokens => Theme.of(this).extension<PulseTokens>()!;
}

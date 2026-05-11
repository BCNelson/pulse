import 'package:flutter/material.dart';

import 'oklch.dart';
import 'tokens.dart';
import 'typography.dart';

/// The 12 designer-defined themes. Each rebinds [PulseTokens] using the
/// `oklch()` values from `hifi-themes.css`.
enum PulseThemeKey {
  bone,
  linen,
  editorial,
  sage,
  iron,
  carbon,
  citron,
  cobalt,
  punch,
  plum,
  tangerine,
  forest,
}

extension PulseThemeKeyLabel on PulseThemeKey {
  String get label {
    switch (this) {
      case PulseThemeKey.bone:
        return 'Bone';
      case PulseThemeKey.linen:
        return 'Cool Linen';
      case PulseThemeKey.editorial:
        return 'Editorial';
      case PulseThemeKey.sage:
        return 'Sage & Ochre';
      case PulseThemeKey.iron:
        return 'Iron';
      case PulseThemeKey.carbon:
        return 'Carbon Amber';
      case PulseThemeKey.citron:
        return 'Citron';
      case PulseThemeKey.cobalt:
        return 'Cobalt';
      case PulseThemeKey.punch:
        return 'Punch';
      case PulseThemeKey.plum:
        return 'Plum';
      case PulseThemeKey.tangerine:
        return 'Tangerine';
      case PulseThemeKey.forest:
        return 'Forest Neon';
    }
  }

  String get tagline {
    switch (this) {
      case PulseThemeKey.bone:
        return 'Warm paper · amber, green, blue triad';
      case PulseThemeKey.linen:
        return 'Cool grey · indigo voice';
      case PulseThemeKey.editorial:
        return 'Pure paper · oxblood accent';
      case PulseThemeKey.sage:
        return 'Green-leaning · ochre + rust';
      case PulseThemeKey.iron:
        return 'Dark cool · mint accent';
      case PulseThemeKey.carbon:
        return 'Warm dark · monochrome amber';
      case PulseThemeKey.citron:
        return 'Chartreuse · hot magenta';
      case PulseThemeKey.cobalt:
        return 'Cream · saturated cobalt';
      case PulseThemeKey.punch:
        return 'White · hot coral';
      case PulseThemeKey.plum:
        return 'Aubergine · lemon';
      case PulseThemeKey.tangerine:
        return 'Peach · marigold';
      case PulseThemeKey.forest:
        return 'Forest · neon chartreuse';
    }
  }
}

bool _isDark(PulseThemeKey key) {
  switch (key) {
    case PulseThemeKey.iron:
    case PulseThemeKey.carbon:
    case PulseThemeKey.plum:
    case PulseThemeKey.forest:
      return true;
    case PulseThemeKey.bone:
    case PulseThemeKey.linen:
    case PulseThemeKey.editorial:
    case PulseThemeKey.sage:
    case PulseThemeKey.citron:
    case PulseThemeKey.cobalt:
    case PulseThemeKey.punch:
    case PulseThemeKey.tangerine:
      return false;
  }
}

PulseTokens _tokensFor(PulseThemeKey key) {
  switch (key) {
    case PulseThemeKey.bone:
      return PulseTokens(
        paper: oklch(0.985, 0.004, 80),
        paper2: oklch(0.965, 0.006, 78),
        paper3: oklch(0.945, 0.008, 78),
        ink: oklch(0.225, 0.012, 75),
        ink2: oklch(0.43, 0.010, 75),
        ink3: oklch(0.62, 0.008, 75),
        hair: oklch(0.89, 0.006, 75),
        hair2: oklch(0.93, 0.006, 75),
        amber: oklch(0.78, 0.135, 75),
        amberSoft: oklch(0.95, 0.045, 80),
        amberInk: oklch(0.40, 0.090, 75),
        green: oklch(0.70, 0.115, 150),
        greenSoft: oklch(0.95, 0.038, 150),
        greenInk: oklch(0.40, 0.075, 150),
        blue: oklch(0.65, 0.115, 248),
        blueSoft: oklch(0.95, 0.030, 245),
        blueInk: oklch(0.42, 0.090, 248),
        accent: oklch(0.225, 0.012, 75),
        accentInk: oklch(0.225, 0.012, 75),
        accentOn: oklch(0.985, 0.004, 80),
        isDark: false,
      );
    case PulseThemeKey.linen:
      return PulseTokens(
        paper: oklch(0.985, 0.004, 240),
        paper2: oklch(0.965, 0.006, 240),
        paper3: oklch(0.945, 0.008, 240),
        ink: oklch(0.235, 0.020, 260),
        ink2: oklch(0.46, 0.016, 258),
        ink3: oklch(0.65, 0.012, 255),
        hair: oklch(0.89, 0.012, 250),
        hair2: oklch(0.93, 0.010, 250),
        amber: oklch(0.62, 0.165, 265),
        amberSoft: oklch(0.94, 0.045, 265),
        amberInk: oklch(0.42, 0.130, 265),
        green: oklch(0.62, 0.090, 265),
        greenSoft: oklch(0.95, 0.025, 265),
        greenInk: oklch(0.42, 0.075, 265),
        blue: oklch(0.62, 0.165, 265),
        blueSoft: oklch(0.94, 0.045, 265),
        blueInk: oklch(0.42, 0.130, 265),
        accent: oklch(0.62, 0.165, 265),
        accentInk: oklch(0.42, 0.130, 265),
        accentOn: oklch(0.985, 0.004, 240),
        isDark: false,
      );
    case PulseThemeKey.editorial:
      return PulseTokens(
        paper: oklch(0.992, 0.001, 0),
        paper2: oklch(0.975, 0.001, 0),
        paper3: oklch(0.955, 0.002, 0),
        ink: oklch(0.18, 0.005, 30),
        ink2: oklch(0.42, 0.005, 30),
        ink3: oklch(0.64, 0.003, 30),
        hair: oklch(0.88, 0.003, 30),
        hair2: oklch(0.93, 0.002, 30),
        amber: oklch(0.52, 0.155, 25),
        amberSoft: oklch(0.94, 0.040, 25),
        amberInk: oklch(0.42, 0.135, 25),
        green: oklch(0.52, 0.155, 25),
        greenSoft: oklch(0.94, 0.040, 25),
        greenInk: oklch(0.42, 0.135, 25),
        blue: oklch(0.52, 0.155, 25),
        blueSoft: oklch(0.94, 0.040, 25),
        blueInk: oklch(0.42, 0.135, 25),
        accent: oklch(0.52, 0.155, 25),
        accentInk: oklch(0.42, 0.135, 25),
        accentOn: oklch(0.992, 0.001, 0),
        isDark: false,
      );
    case PulseThemeKey.sage:
      return PulseTokens(
        paper: oklch(0.975, 0.012, 130),
        paper2: oklch(0.955, 0.018, 130),
        paper3: oklch(0.935, 0.022, 130),
        ink: oklch(0.245, 0.025, 135),
        ink2: oklch(0.45, 0.022, 135),
        ink3: oklch(0.62, 0.018, 135),
        hair: oklch(0.86, 0.018, 130),
        hair2: oklch(0.91, 0.016, 130),
        amber: oklch(0.74, 0.140, 65),
        amberSoft: oklch(0.95, 0.045, 65),
        amberInk: oklch(0.42, 0.105, 55),
        green: oklch(0.62, 0.095, 145),
        greenSoft: oklch(0.93, 0.038, 145),
        greenInk: oklch(0.40, 0.075, 145),
        blue: oklch(0.55, 0.075, 220),
        blueSoft: oklch(0.93, 0.028, 220),
        blueInk: oklch(0.40, 0.065, 220),
        accent: oklch(0.74, 0.140, 65),
        accentInk: oklch(0.42, 0.105, 55),
        accentOn: oklch(0.975, 0.012, 130),
        isDark: false,
      );
    case PulseThemeKey.iron:
      return PulseTokens(
        paper: oklch(0.205, 0.012, 250),
        paper2: oklch(0.235, 0.013, 250),
        paper3: oklch(0.265, 0.014, 250),
        ink: oklch(0.965, 0.006, 250),
        ink2: oklch(0.78, 0.010, 250),
        ink3: oklch(0.58, 0.012, 250),
        hair: oklch(0.32, 0.014, 250),
        hair2: oklch(0.27, 0.013, 250),
        amber: oklch(0.78, 0.155, 160),
        amberSoft: oklch(0.32, 0.060, 160),
        amberInk: oklch(0.86, 0.140, 160),
        green: oklch(0.78, 0.140, 160),
        greenSoft: oklch(0.30, 0.055, 160),
        greenInk: oklch(0.86, 0.130, 160),
        blue: oklch(0.68, 0.140, 230),
        blueSoft: oklch(0.30, 0.060, 235),
        blueInk: oklch(0.80, 0.130, 230),
        accent: oklch(0.78, 0.155, 160),
        accentInk: oklch(0.86, 0.140, 160),
        accentOn: oklch(0.205, 0.012, 250),
        isDark: true,
      );
    case PulseThemeKey.carbon:
      return PulseTokens(
        paper: oklch(0.195, 0.010, 60),
        paper2: oklch(0.225, 0.011, 60),
        paper3: oklch(0.255, 0.012, 60),
        ink: oklch(0.965, 0.008, 80),
        ink2: oklch(0.78, 0.010, 75),
        ink3: oklch(0.58, 0.012, 70),
        hair: oklch(0.32, 0.012, 65),
        hair2: oklch(0.27, 0.011, 65),
        amber: oklch(0.78, 0.150, 70),
        amberSoft: oklch(0.32, 0.070, 65),
        amberInk: oklch(0.86, 0.140, 75),
        green: oklch(0.78, 0.150, 70),
        greenSoft: oklch(0.32, 0.070, 65),
        greenInk: oklch(0.86, 0.140, 75),
        blue: oklch(0.78, 0.150, 70),
        blueSoft: oklch(0.32, 0.070, 65),
        blueInk: oklch(0.86, 0.140, 75),
        accent: oklch(0.78, 0.150, 70),
        accentInk: oklch(0.86, 0.140, 75),
        accentOn: oklch(0.195, 0.010, 60),
        isDark: true,
      );
    case PulseThemeKey.citron:
      return PulseTokens(
        paper: oklch(0.965, 0.055, 115),
        paper2: oklch(0.935, 0.065, 115),
        paper3: oklch(0.905, 0.075, 115),
        ink: oklch(0.18, 0.020, 115),
        ink2: oklch(0.38, 0.022, 115),
        ink3: oklch(0.55, 0.020, 115),
        hair: oklch(0.82, 0.060, 115),
        hair2: oklch(0.88, 0.055, 115),
        amber: oklch(0.62, 0.245, 358),
        amberSoft: oklch(0.92, 0.080, 358),
        amberInk: oklch(0.48, 0.220, 358),
        green: oklch(0.55, 0.155, 145),
        greenSoft: oklch(0.92, 0.075, 145),
        greenInk: oklch(0.40, 0.130, 145),
        blue: oklch(0.45, 0.180, 265),
        blueSoft: oklch(0.92, 0.060, 265),
        blueInk: oklch(0.40, 0.170, 265),
        accent: oklch(0.62, 0.245, 358),
        accentInk: oklch(0.48, 0.220, 358),
        accentOn: oklch(0.985, 0.010, 358),
        isDark: false,
      );
    case PulseThemeKey.cobalt:
      return PulseTokens(
        paper: oklch(0.978, 0.012, 85),
        paper2: oklch(0.955, 0.018, 85),
        paper3: oklch(0.930, 0.022, 85),
        ink: oklch(0.225, 0.020, 260),
        ink2: oklch(0.45, 0.020, 260),
        ink3: oklch(0.62, 0.018, 260),
        hair: oklch(0.86, 0.020, 85),
        hair2: oklch(0.91, 0.018, 85),
        amber: oklch(0.66, 0.215, 45),
        amberSoft: oklch(0.94, 0.075, 50),
        amberInk: oklch(0.48, 0.180, 45),
        green: oklch(0.55, 0.155, 145),
        greenSoft: oklch(0.93, 0.060, 145),
        greenInk: oklch(0.40, 0.130, 145),
        blue: oklch(0.44, 0.245, 265),
        blueSoft: oklch(0.93, 0.075, 265),
        blueInk: oklch(0.40, 0.220, 265),
        accent: oklch(0.44, 0.245, 265),
        accentInk: oklch(0.40, 0.220, 265),
        accentOn: oklch(0.985, 0.010, 85),
        isDark: false,
      );
    case PulseThemeKey.punch:
      return PulseTokens(
        paper: oklch(0.995, 0.001, 0),
        paper2: oklch(0.972, 0.002, 30),
        paper3: oklch(0.948, 0.003, 30),
        ink: oklch(0.16, 0.005, 30),
        ink2: oklch(0.42, 0.005, 30),
        ink3: oklch(0.62, 0.004, 30),
        hair: oklch(0.88, 0.005, 30),
        hair2: oklch(0.93, 0.003, 30),
        amber: oklch(0.66, 0.245, 25),
        amberSoft: oklch(0.93, 0.075, 25),
        amberInk: oklch(0.52, 0.220, 25),
        green: oklch(0.66, 0.245, 25),
        greenSoft: oklch(0.93, 0.075, 25),
        greenInk: oklch(0.52, 0.220, 25),
        blue: oklch(0.66, 0.245, 25),
        blueSoft: oklch(0.93, 0.075, 25),
        blueInk: oklch(0.52, 0.220, 25),
        accent: oklch(0.66, 0.245, 25),
        accentInk: oklch(0.52, 0.220, 25),
        accentOn: oklch(0.995, 0.005, 25),
        isDark: false,
      );
    case PulseThemeKey.plum:
      return PulseTokens(
        paper: oklch(0.205, 0.040, 320),
        paper2: oklch(0.235, 0.045, 320),
        paper3: oklch(0.265, 0.050, 320),
        ink: oklch(0.965, 0.015, 90),
        ink2: oklch(0.78, 0.020, 90),
        ink3: oklch(0.58, 0.025, 320),
        hair: oklch(0.32, 0.045, 320),
        hair2: oklch(0.28, 0.045, 320),
        amber: oklch(0.88, 0.190, 100),
        amberSoft: oklch(0.32, 0.080, 100),
        amberInk: oklch(0.92, 0.180, 100),
        green: oklch(0.78, 0.150, 160),
        greenSoft: oklch(0.32, 0.070, 160),
        greenInk: oklch(0.86, 0.140, 160),
        blue: oklch(0.78, 0.155, 270),
        blueSoft: oklch(0.32, 0.075, 270),
        blueInk: oklch(0.85, 0.140, 270),
        accent: oklch(0.88, 0.190, 100),
        accentInk: oklch(0.88, 0.190, 100),
        accentOn: oklch(0.18, 0.040, 320),
        isDark: true,
      );
    case PulseThemeKey.tangerine:
      return PulseTokens(
        paper: oklch(0.955, 0.045, 60),
        paper2: oklch(0.930, 0.055, 60),
        paper3: oklch(0.905, 0.065, 55),
        ink: oklch(0.255, 0.080, 35),
        ink2: oklch(0.45, 0.070, 35),
        ink3: oklch(0.62, 0.055, 40),
        hair: oklch(0.82, 0.060, 55),
        hair2: oklch(0.88, 0.055, 55),
        amber: oklch(0.68, 0.215, 50),
        amberSoft: oklch(0.92, 0.080, 55),
        amberInk: oklch(0.48, 0.180, 45),
        green: oklch(0.55, 0.130, 155),
        greenSoft: oklch(0.92, 0.055, 155),
        greenInk: oklch(0.40, 0.110, 155),
        blue: oklch(0.45, 0.150, 235),
        blueSoft: oklch(0.92, 0.055, 235),
        blueInk: oklch(0.40, 0.135, 235),
        accent: oklch(0.68, 0.215, 50),
        accentInk: oklch(0.48, 0.180, 45),
        accentOn: oklch(0.985, 0.010, 60),
        isDark: false,
      );
    case PulseThemeKey.forest:
      return PulseTokens(
        paper: oklch(0.205, 0.040, 155),
        paper2: oklch(0.235, 0.045, 155),
        paper3: oklch(0.265, 0.050, 155),
        ink: oklch(0.965, 0.012, 125),
        ink2: oklch(0.78, 0.018, 145),
        ink3: oklch(0.58, 0.025, 155),
        hair: oklch(0.32, 0.045, 155),
        hair2: oklch(0.28, 0.045, 155),
        amber: oklch(0.90, 0.220, 125),
        amberSoft: oklch(0.32, 0.075, 125),
        amberInk: oklch(0.92, 0.215, 125),
        green: oklch(0.90, 0.220, 125),
        greenSoft: oklch(0.32, 0.075, 125),
        greenInk: oklch(0.92, 0.215, 125),
        blue: oklch(0.78, 0.135, 220),
        blueSoft: oklch(0.32, 0.060, 220),
        blueInk: oklch(0.86, 0.120, 220),
        accent: oklch(0.90, 0.220, 125),
        accentInk: oklch(0.92, 0.215, 125),
        accentOn: oklch(0.18, 0.040, 155),
        isDark: true,
      );
  }
}

/// Build a complete [ThemeData] for the given Pulse theme key.
ThemeData pulseTheme(PulseThemeKey key) {
  final t = _tokensFor(key);
  final dark = _isDark(key);

  final scheme = ColorScheme(
    brightness: dark ? Brightness.dark : Brightness.light,
    primary: t.ink,
    onPrimary: t.paper,
    secondary: t.accent,
    onSecondary: t.accentOn,
    error: t.amber,
    onError: t.paper,
    surface: t.paper,
    onSurface: t.ink,
    surfaceContainerLowest: t.paper,
    surfaceContainerLow: t.paper2,
    surfaceContainer: t.paper2,
    surfaceContainerHigh: t.paper3,
    surfaceContainerHighest: t.paper3,
    surfaceTint: t.ink,
    outline: t.hair,
    outlineVariant: t.hair2,
    primaryContainer: t.paper3,
    onPrimaryContainer: t.ink,
    secondaryContainer: t.amberSoft,
    onSecondaryContainer: t.amberInk,
    tertiary: t.blue,
    onTertiary: t.paper,
    tertiaryContainer: t.blueSoft,
    onTertiaryContainer: t.blueInk,
  );

  final text = pulseTextTheme(t);

  return ThemeData(
    useMaterial3: true,
    brightness: scheme.brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: t.paper,
    canvasColor: t.paper,
    dividerColor: t.hair,
    textTheme: text,
    extensions: [t],
    appBarTheme: AppBarTheme(
      backgroundColor: t.paper,
      foregroundColor: t.ink,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: text.titleMedium,
      iconTheme: IconThemeData(color: t.ink2, size: 20),
      shape: Border(bottom: BorderSide(color: t.hair, width: 1)),
    ),
    dividerTheme: DividerThemeData(
      color: t.hair,
      thickness: 1,
      space: 1,
    ),
    iconTheme: IconThemeData(color: t.ink2, size: 18),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: t.paper,
      hintStyle: text.bodyMedium?.copyWith(color: t.ink3),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(t.radius),
        borderSide: BorderSide(color: t.hair),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(t.radius),
        borderSide: BorderSide(color: t.hair),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(t.radius),
        borderSide: BorderSide(color: t.ink, width: 1.5),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: t.paper2,
      selectedItemColor: t.ink,
      unselectedItemColor: t.ink3,
      selectedLabelStyle: TextStyle(
        fontFamily: pulseMonoFamily,
        fontSize: 10,
        letterSpacing: 0.08 * 10,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: pulseMonoFamily,
        fontSize: 10,
        letterSpacing: 0.08 * 10,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: t.ink,
      contentTextStyle: text.bodyMedium?.copyWith(color: t.paper),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: t.paper,
      surfaceTintColor: Colors.transparent,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: t.ink,
      foregroundColor: t.paper,
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(t.radiusLg),
      ),
    ),
    cardTheme: CardThemeData(
      color: t.paper,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(t.radius),
        side: BorderSide(color: t.hair),
      ),
    ),
  );
}

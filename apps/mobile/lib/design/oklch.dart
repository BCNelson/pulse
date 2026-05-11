import 'dart:math' as math;
import 'dart:ui';

/// Convert an OKLCH color (lightness 0–1, chroma 0+, hue in degrees) to a
/// Flutter [Color] in the sRGB color space.
///
/// The designer's CSS specifies palette tokens as `oklch(L C H)`. Doing the
/// conversion at theme-build time means every theme can be written with the
/// exact numbers from `hifi-themes.css`.
Color oklch(double l, double c, double h, {double opacity = 1.0}) {
  final hRad = h * math.pi / 180.0;
  final a = c * math.cos(hRad);
  final b = c * math.sin(hRad);

  final lp = l + 0.3963377774 * a + 0.2158037573 * b;
  final mp = l - 0.1055613458 * a - 0.0638541728 * b;
  final sp = l - 0.0894841775 * a - 1.2914855480 * b;

  final lc = lp * lp * lp;
  final mc = mp * mp * mp;
  final sc = sp * sp * sp;

  final rLin = 4.0767416621 * lc - 3.3077115913 * mc + 0.2309699292 * sc;
  final gLin = -1.2684380046 * lc + 2.6097574011 * mc - 0.3413193965 * sc;
  final bLin = -0.0041960863 * lc - 0.7034186147 * mc + 1.7076147010 * sc;

  int toByte(double v) {
    final clamped = v.clamp(0.0, 1.0);
    final encoded = clamped <= 0.0031308
        ? 12.92 * clamped
        : 1.055 * math.pow(clamped, 1.0 / 2.4) - 0.055;
    return (encoded * 255.0).round().clamp(0, 255);
  }

  return Color.fromARGB(
    (opacity * 255).round().clamp(0, 255),
    toByte(rLin),
    toByte(gLin),
    toByte(bLin),
  );
}

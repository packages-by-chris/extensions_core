import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  /// Converts a Color to a hex string.
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${(a * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}'
      '${(r * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}'
      '${(g * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}'
      '${(b * 255.0).round().clamp(0, 255).toRadixString(16).padLeft(2, '0')}';

  /// Checks if a color is dark.
  bool get isDark =>
      ThemeData.estimateBrightnessForColor(this) == Brightness.dark;

  /// Checks if a color is light.
  bool get isLight =>
      ThemeData.estimateBrightnessForColor(this) == Brightness.light;

  /// Blends the color with another color.
  Color blend(Color other, [double factor = 0.5]) {
    return Color.lerp(this, other, factor)!;
  }

  /// Darkens the color towards black.
  Color darken([double amount = 0.1]) =>
      Color.lerp(this, Colors.black, amount.clamp(0.0, 1.0))!;

  /// Lightens the color towards white.
  Color lighten([double amount = 0.1]) =>
      Color.lerp(this, Colors.white, amount.clamp(0.0, 1.0))!;

  /// Inverted (complementary in RGB) color, alpha preserved.
  Color get inverse {
    final argb = toARGB32();
    final a = (argb >> 24) & 0xff;
    final r = (argb >> 16) & 0xff;
    final g = (argb >> 8) & 0xff;
    final b = argb & 0xff;
    return Color.fromARGB(a, 255 - r, 255 - g, 255 - b);
  }

  /// Hue-rotated 180 degrees.
  Color get complementary =>
      HSVColor.fromColor(this).withHue((hue + 180) % 360).toColor();

  /// Hue in degrees (0-360).
  double get hue => HSVColor.fromColor(this).hue;

  /// Saturation (0-1).
  double get saturation => HSVColor.fromColor(this).saturation;

  /// Value / brightness (0-1). Named `brightness` because `Color` already
  /// has a (deprecated) `value` getter that would shadow an extension.
  double get brightness => HSVColor.fromColor(this).value;

  /// Copies the color with the HSV value set to [v] (0-1).
  Color withBrightness(double v) =>
      HSVColor.fromColor(this).withValue(v.clamp(0.0, 1.0)).toColor();

  /// Whether the color is fully transparent.
  bool get isTransparent => a == 0;

  /// Generates a [MaterialColor] swatch from this color.
  MaterialColor toMaterialColor() {
    final argb = toARGB32();
    final r = (argb >> 16) & 0xff;
    final g = (argb >> 8) & 0xff;
    final b = argb & 0xff;
    Color shade(double f) => Color.fromARGB(255, (r * f).round().clamp(0, 255),
        (g * f).round().clamp(0, 255), (b * f).round().clamp(0, 255));
    return MaterialColor(argb, <int, Color>{
      50: shade(0.1),
      100: shade(0.2),
      200: shade(0.3),
      300: shade(0.4),
      400: shade(0.5),
      500: this,
      600: shade(0.7),
      700: shade(0.8),
      800: shade(0.9),
      900: shade(1.0),
    });
  }
}

/// Parses `#RGB`, `#RRGGBB`, `#AARRGGBB` (with or without `#`) into a [Color].
/// Throws a [FormatException] for invalid input.
Color colorFromHex(String hex) {
  var h = hex.replaceFirst('#', '').trim();
  if (h.length == 3 || h.length == 4) {
    h = h.split('').map((c) => '$c$c').join();
  }
  if (h.length == 6) h = 'ff$h';
  if (h.length != 8) throw FormatException('Invalid hex color: $hex');
  final value = int.tryParse(h, radix: 16);
  if (value == null) throw FormatException('Invalid hex color: $hex');
  return Color(value);
}

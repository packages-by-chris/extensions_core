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
}

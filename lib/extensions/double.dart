extension DoubleExtensions on double {
  /// Formats a double to a fixed number of decimal places.
  double toFixed(int fractionDigits) {
    return double.parse(toStringAsFixed(fractionDigits));
  }

  /// Linearly interpolates between two doubles.
  double lerp(double other, double t) {
    return this + (other - this) * t;
  }
}

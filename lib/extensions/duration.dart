/// Formatting helpers on [Duration].
library;

/// Extensions on [Duration] for week math and formatting.
extension DurationExtensions on Duration {
  /// Number of whole weeks.
  int get inWeeks => inDays ~/ 7;

  /// Formats the duration as `H:MM:SS` (e.g. `2:03:45`).
  String format() {
    String two(int n) => n.toString().padLeft(2, '0');
    return '$inHours:${two(inMinutes % 60)}:${two(inSeconds % 60)}';
  }

  /// Whether this duration is longer than [other].
  bool isLongerThan(Duration other) => this > other;

  /// Whether this duration is shorter than [other].
  bool isShorterThan(Duration other) => this < other;
}

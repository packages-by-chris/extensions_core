/// Formatting, conversion, and predicate helpers on [num].
library;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Formatting and conversion extensions on [num].
extension NumExtension on num {
  /// Convert number to currency format
  String toCurrency({String symbol = '\$', String locale = 'en_US'}) {
    return NumberFormat.currency(
      symbol: symbol,
      locale: locale,
    ).format(this);
  }

  /// Convert number to compact format (e.g., 1K, 1M)
  String toCompact({String locale = 'en_US'}) {
    return NumberFormat.compact(locale: locale).format(this);
  }

  /// Convert number to percentage
  String toPercentage({int decimals = 0, String locale = 'en_US'}) {
    return NumberFormat.percentPattern(locale)
        .format(this / 100)
        .replaceAll(RegExp(r'0+%'), '%');
  }

  /// Format number with specific decimal places
  String toDecimal({int decimals = 2, String locale = 'en_US'}) {
    return NumberFormat.decimalPattern(locale).format(this);
  }

  /// Convert to Duration
  Duration get milliseconds => Duration(milliseconds: toInt());

  /// This number as a [Duration] of seconds.
  Duration get seconds => Duration(seconds: toInt());

  /// This number as a [Duration] of minutes.
  Duration get minutes => Duration(minutes: toInt());

  /// This number as a [Duration] of hours.
  Duration get hours => Duration(hours: toInt());

  /// This number as a [Duration] of days.
  Duration get days => Duration(days: toInt());

  /// Convert to SizedBox (useful for spacing)
  Widget get heightBox => SizedBox(height: toDouble());

  /// This number as a [SizedBox] width.
  Widget get widthBox => SizedBox(width: toDouble());

  /// Check if number is between a range
  bool isBetween(num start, num end) {
    return this >= start && this <= end;
  }

  /// Ensure number is within a range
  num clamp(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Convert to radians/degrees
  double get toRadians => this * (pi / 180);

  /// This number converted from degrees to radians.
  double get toDegrees => this * (180 / pi);

  // --- Predicates ---

  /// Whether the number is greater than zero.
  bool get isPositive => this > 0;

  /// Whether the number equals zero.
  bool get isZero => this == 0;

  /// Whether the number divides evenly by [other].
  bool isDivisibleBy(num other) => other != 0 && this % other == 0;

  /// Percentage this number represents of [total] (0-100).
  double percentageOf(num total) => total == 0 ? 0 : this / total * 100;

  /// Human-readable byte size (e.g. `1.50 MB`).
  String formatBytes({int decimals = 2}) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    var v = toDouble();
    var i = 0;
    while (v >= 1024 && i < suffixes.length - 1) {
      v /= 1024;
      i++;
    }
    return '${v.toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

/// Even/odd checks, ordinal suffixes, and radix conversions on [int].
extension IntExtensions on int {
  /// Whether the int is even.
  bool get isEven => this % 2 == 0;

  /// Whether the int is odd.
  bool get isOdd => this % 2 != 0;

  /// Ordinal suffix (e.g. `1st`, `2nd`, `3rd`, `11th`).
  String ordinal() {
    if (this % 100 >= 11 && this % 100 <= 13) return '${this}th';
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }

  /// Binary representation (e.g. `5.toBinary()` -> `101`).
  String toBinary() => toRadixString(2);

  /// Octal representation.
  String toOctal() => toRadixString(8);

  /// Uppercase hexadecimal representation (e.g. `255.toHex()` -> `FF`).
  String toHex() => toRadixString(16).toUpperCase();
}

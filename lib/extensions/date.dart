import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

/// Extension for DateTime with BuildContext support
extension DateTimeExtensions on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  String format(String pattern) {
    final formatter = DateFormat(pattern);
    return formatter.format(this);
  }

  /// Get formatted date string based on locale from BuildContext
  String formattedDate(BuildContext context, {String pattern = 'yyyy-MM-dd'}) {
    Locale locale = Localizations.localeOf(context);
    return DateFormat(pattern, locale.toString()).format(this);
  }

  /// Get relative time description (e.g., "5 minutes ago")
  String timeAgo(BuildContext context) {
    Duration difference = DateTime.now().difference(this);

    if (difference.inDays > 8) {
      // Use formatted date if more than a week
      return formattedDate(context);
    } else if (difference.inDays >= 1) {
      return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
    } else if (difference.inHours >= 1) {
      return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
    } else if (difference.inMinutes >= 1) {
      return "${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago";
    } else {
      return "Just now";
    }
  }

  /// Check if the DateTime is yesterday
  bool isYesterday() {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if the DateTime is in the future
  bool isInFuture() {
    return isAfter(DateTime.now());
  }

  /// Check if the DateTime is in the past
  bool isInPast() {
    return isBefore(DateTime.now());
  }

  /// Check if the DateTime is tomorrow.
  bool isTomorrow() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Whether it is the same calendar day as [other].
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Whether it is the same month (and year) as [other].
  bool isSameMonth(DateTime other) =>
      year == other.year && month == other.month;

  /// Whether it is the same year as [other].
  bool isSameYear(DateTime other) => year == other.year;

  /// Whether the day is Saturday or Sunday.
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Whether the day is Monday-Friday.
  bool get isWeekday => !isWeekend;

  /// Whether the year is a leap year.
  bool get isLeapYear => (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;

  /// Whether this date falls between [start] and [end] (inclusive).
  bool isBetween(DateTime start, DateTime end) =>
      !isBefore(start) && !isAfter(end);

  // --- Boundary helpers ---

  /// January 1st of the year.
  DateTime get startOfYear => DateTime(year, 1, 1);

  /// December 31st, end of day (23:59:59.999).
  DateTime get endOfYear => DateTime(year, 12, 31, 23, 59, 59, 999);

  /// First day of the month.
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Last day of the month, end of day.
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  /// Monday of the current week (start of day).
  DateTime get startOfWeek =>
      DateTime(year, month, day - (weekday - DateTime.monday));

  /// Sunday of the current week, end of day.
  DateTime get endOfWeek => startOfWeek.add(const Duration(
      days: 6, hours: 23, minutes: 59, seconds: 59, milliseconds: 999));

  /// Start of day (00:00:00.000).
  DateTime get startOfDay => DateTime(year, month, day);

  /// End of day (23:59:59.999).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Quarter of the year (1-4).
  int get quarter => (month / 3).ceil();

  /// Tomorrow at the same time of day.
  DateTime get tomorrow => add(const Duration(days: 1));

  /// Yesterday at the same time of day.
  DateTime get yesterday => subtract(const Duration(days: 1));

  /// Copy this date with selected fields overridden (local time, preserved by default).
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  /// Whole years between this date and now (or [at]).
  int ageInYears([DateTime? at]) {
    final ref = at ?? DateTime.now();
    var age = ref.year - year;
    if (ref.month < month || (ref.month == month && ref.day < day)) age--;
    return age;
  }
}

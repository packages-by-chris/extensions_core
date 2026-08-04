import 'dart:convert';

/// String helpers that can also be used on `null` strings.
extension NullableStringExtensions on String? {
  /// Whether the string is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

List<String> _wordParts(String s) => s
    .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]} ${m[2]}')
    .split(RegExp(r'[^a-zA-Z0-9]+'))
    .where((w) => w.isNotEmpty)
    .map((w) => w.toLowerCase())
    .toList();

extension StringExtensions on String {
  /// Checks if the string is a valid email.
  bool isEmail() {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(this);
  }

  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  /// Returns true if the string contains only numeric characters.
  bool isNumeric() {
    final numericRegex = RegExp(r'^\d+$');
    return numericRegex.hasMatch(this);
  }

  /// Checks if the string is a valid URL.
  bool isUrl() {
    final urlRegex =
        RegExp(r'^(https?:\/\/)?([\w\-]+(\.[\w\-]+)+)([\/\w\.\-]*)*\/?$');
    return urlRegex.hasMatch(this);
  }

  /// Removes all whitespace from the string.
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Returns a reversed version of the string.
  String reverse() {
    return split('').reversed.join();
  }

  /// Returns true if the string is null, empty, or contains only whitespace.
  bool isNullOrWhiteSpace() {
    return trim().isEmpty;
  }

  /// Shortens the string to a specified length with an optional ellipsis.
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Converts the string to Title Case.
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Checks if the string contains only alphabetic characters.
  bool isAlphabetic() {
    final alphabeticRegex = RegExp(r'^[a-zA-Z]+$');
    return alphabeticRegex.hasMatch(this);
  }

  /// Checks if the string contains at least one uppercase letter.
  bool containsUppercase() {
    return contains(RegExp(r'[A-Z]'));
  }

  /// Checks if the string contains at least one lowercase letter.
  bool containsLowercase() {
    return contains(RegExp(r'[a-z]'));
  }

  /// Checks if the string contains at least one digit.
  bool containsDigit() {
    return contains(RegExp(r'\d'));
  }

  /// Checks if the string is a valid phone number (basic check).
  bool isPhoneNumber() {
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    return phoneRegex.hasMatch(this);
  }

  // --- Case conversion ---

  /// Converts to `camelCase`.
  String toCamelCase() {
    final parts = _wordParts(this);
    if (parts.isEmpty) return '';
    final first = parts.first;
    final rest = parts.skip(1).map((w) => w[0].toUpperCase() + w.substring(1));
    return first + rest.join();
  }

  /// Converts to `snake_case`.
  String toSnakeCase() => _wordParts(this).join('_');

  /// Converts to `kebab-case`.
  String toKebabCase() => _wordParts(this).join('-');

  /// Converts to `PascalCase` (Title Case without spaces).
  String toPascalCase() {
    final parts = _wordParts(this);
    return parts.map((w) => w[0].toUpperCase() + w.substring(1)).join();
  }

  // --- Safe parsing ---

  /// Parses as `int`, or `null` if not a valid integer.
  int? toIntSafe() => int.tryParse(trim());

  /// Parses as `double`, or `null` if not a valid number.
  double? toDoubleSafe() => double.tryParse(trim());

  /// Parses boolean-ish strings: `true/yes/1/y` -> `true`, `false/no/0/n` -> `false`,
  /// otherwise `null`.
  bool? toBool() {
    switch (trim().toLowerCase()) {
      case 'true':
      case 'yes':
      case '1':
      case 'y':
        return true;
      case 'false':
      case 'no':
      case '0':
      case 'n':
        return false;
      default:
        return null;
    }
  }

  // --- Slicing ---

  /// Part before the first occurrence of [delimiter], or the whole string if absent.
  String before(String delimiter) {
    final i = indexOf(delimiter);
    return i == -1 ? this : substring(0, i);
  }

  /// Part after the first occurrence of [delimiter], or the whole string if absent.
  String after(String delimiter) {
    final i = indexOf(delimiter);
    return i == -1 ? this : substring(i + delimiter.length);
  }

  /// Text between [start] and [end], or `null` if markers are missing or out of order.
  String? between(String start, String end) {
    final s = indexOf(start);
    if (s == -1) return null;
    final from = s + start.length;
    final e = indexOf(end, from);
    if (e == -1) return null;
    return substring(from, e);
  }

  /// Replaces the last occurrence of [from] with [to].
  String replaceLast(String from, String to) {
    final i = lastIndexOf(from);
    if (i == -1) return this;
    return replaceRange(i, i + from.length, to);
  }

  // --- Counting / checks ---

  /// Number of (non-overlapping) occurrences of [pattern].
  int countOccurrences(String pattern) => pattern.allMatches(this).length;

  /// Whether the string contains only letters and digits.
  bool isAlphanumeric() => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  /// Whether the string contains at least one non-alphanumeric character.
  bool containsSpecialCharacter() => contains(RegExp(r'[^a-zA-Z0-9\s]'));

  /// Whether the string meets common password strength rules.
  bool isStrongPassword(
          {int minLength = 8,
          bool requireUppercase = true,
          bool requireLowercase = true,
          bool requireDigit = true,
          bool requireSpecial = true}) =>
      length >= minLength &&
      (!requireUppercase || containsUppercase()) &&
      (!requireLowercase || containsLowercase()) &&
      (!requireDigit || containsDigit()) &&
      (!requireSpecial || containsSpecialCharacter());

  /// Whether the string is valid JSON (object or array).
  bool isJson() {
    try {
      final v = jsonDecode(this);
      return v is Map || v is List;
    } catch (_) {
      return false;
    }
  }

  // --- Transformations ---

  /// Lowercases, collapses whitespace and non-alphanumerics into single hyphens.
  String slugify() =>
      trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-+|-+$'), '');

  /// Replaces runs of whitespace with a single space, trimming ends.
  String collapseWhitespace() => trim().replaceAll(RegExp(r'\s+'), ' ');

  /// Removes all digit characters.
  String withoutDigits() => replaceAll(RegExp(r'\d'), '');

  /// Keeps only digit characters.
  String onlyDigits() => replaceAll(RegExp(r'[^0-9]'), '');

  /// Masks all but the last [visibleCount] characters.
  String masked({int visibleCount = 4, String mask = '*'}) {
    if (length <= visibleCount) return this;
    return mask * (length - visibleCount) + substring(length - visibleCount);
  }

  /// Uppercase initial letters (up to [max] words), useful for avatars.
  String initials({int max = 2}) {
    final words = _wordParts(this);
    if (words.isEmpty) return '';
    if (words.length == 1) {
      final w = words.first;
      return w.substring(0, w.length < max ? w.length : max).toUpperCase();
    }
    return words.take(max).map((w) => w[0].toUpperCase()).join();
  }
}

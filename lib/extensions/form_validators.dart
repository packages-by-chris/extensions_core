import 'strings.dart';

/// Validator helpers returning an error [String] or `null` when valid.
/// Use directly as `validator:` for `TextFormField`/`FormField`.
typedef FormValidator = String? Function(String?);

/// Field must not be null/blank.
String? requiredField(String? value,
        {String message = 'This field is required'}) =>
    (value == null || value.trim().isEmpty) ? message : null;

/// Field must be a valid email (blank passes).
String? emailValidator(String? value,
    {String message = 'Enter a valid email'}) {
  if (value == null || value.trim().isEmpty) return null;
  return value.isEmail() ? null : message;
}

/// Field must be a valid phone number (blank passes).
String? phoneValidator(String? value,
    {String message = 'Enter a valid phone number'}) {
  if (value == null || value.trim().isEmpty) return null;
  return value.isPhoneNumber() ? null : message;
}

/// Field must be at least [minLength] characters (blank passes).
String? minLengthValidator(String? value, int minLength, {String? message}) {
  if (value == null || value.trim().isEmpty) return null;
  return value.length >= minLength
      ? null
      : message ?? 'Must be at least $minLength characters';
}

/// Field must be at most [maxLength] characters (blank passes).
String? maxLengthValidator(String? value, int maxLength, {String? message}) {
  if (value == null || value.trim().isEmpty) return null;
  return value.length <= maxLength
      ? null
      : message ?? 'Must be at most $maxLength characters';
}

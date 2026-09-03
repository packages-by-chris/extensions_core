/// Scope functions and null checks on any object.
library;

/// Object helpers (Kotlin-style scope functions).
extension ObjectExtensions<T> on T {
  /// Calls [block] with `this` as argument and returns the result.
  R let<R>(R Function(T) block) => block(this);

  /// Runs [block] with `this`, then returns `this`.
  T also(void Function(T) block) {
    block(this);
    return this;
  }

  /// Runs [block] with `this` and returns the result (alias of [let]).
  R run<R>(R Function(T) block) => block(this);
}

/// Null checks on any nullable value.
extension NullableObjectExtensions on Object? {
  /// Whether the value is `null`.
  bool get isNull => this == null;

  /// Whether the value is not `null`.
  bool get isNotNull => this != null;
}

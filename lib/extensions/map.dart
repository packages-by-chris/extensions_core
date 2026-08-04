
extension MapExtensions<K, V> on Map<K, V> {
  /// Gets a value from a map, or a default value if the key doesn't exist.
  V getOrElse(K key, V defaultValue) {
    return this[key] ?? defaultValue;
  }

  /// Recursively merges two maps.
  Map<K, V> deepMerge(Map<K, V> other) {
    final result = Map<K, V>.from(this);
    other.forEach((key, value) {
      if (result.containsKey(key) && result[key] is Map && value is Map) {
        result[key] = (result[key] as Map).deepMerge(value as Map) as V;
      } else {
        result[key] = value;
      }
    });
    return result;
  }

  /// Filters a map based on a predicate.
  Map<K, V> where(bool Function(K key, V value) test) {
    final result = <K, V>{};
    forEach((key, value) {
      if (test(key, value)) {
        result[key] = value;
      }
    });
    return result;
  }

  /// Transforms the keys of a map.
  Map<T, V> mapKeys<T>(T Function(K key) transform) {
    final result = <T, V>{};
    forEach((key, value) {
      result[transform(key)] = value;
    });
    return result;
  }

  /// Transforms the values of a map.
  Map<K, T> mapValues<T>(T Function(V value) transform) {
    final result = <K, T>{};
    forEach((key, value) {
      result[key] = transform(value);
    });
    return result;
  }

  /// Swaps keys and values.
  Map<V, K> invert() => {for (final entry in entries) entry.value: entry.key};

  /// Returns the value for [key], computing and storing it if absent.
  V getOrPut(K key, V Function() put) {
    if (!containsKey(key)) {
      this[key] = put();
    }
    return this[key] as V;
  }

  /// Returns a new map with only the given [keys] (missing keys ignored).
  Map<K, V> pick(Iterable<K> keys) {
    final result = <K, V>{};
    for (final key in keys) {
      if (containsKey(key)) result[key] = this[key] as V;
    }
    return result;
  }

  /// Returns a new map without the given [keys].
  Map<K, V> omit(Iterable<K> keys) {
    final excluded = keys.toSet();
    return {...this}..removeWhere((key, value) => excluded.contains(key));
  }

  /// Keeps entries whose key matches [test].
  Map<K, V> filterKeys(bool Function(K key) test) => where((key, value) => test(key));

  /// Keeps entries whose value matches [test].
  Map<K, V> filterValues(bool Function(V value) test) => where((key, value) => test(value));

  /// Keys whose value equals [value].
  List<K> keysOf(V value) =>
      [for (final entry in entries) if (entry.value == value) entry.key];

  /// Shallow merge with [other] (other wins on key conflicts).
  Map<K, V> merge(Map<K, V> other) => {...this, ...other};
}

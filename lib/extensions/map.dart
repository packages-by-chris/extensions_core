
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
}

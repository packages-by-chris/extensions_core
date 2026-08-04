
extension IterableExtensions<T> on Iterable<T> {
  /// Finds the first element that satisfies a condition, or return `null`.
  T? firstWhereOrNull(bool Function(T) test) {
    for (var element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  /// Sums the values of a property of each element.
  num sumBy(num Function(T) selector) {
    return fold(0, (prev, element) => prev + selector(element));
  }

  /// Calculates the average of a property of each element.
  double averageBy(num Function(T) selector) {
    if (isEmpty) return 0;
    return sumBy(selector) / length;
  }

  /// Groups elements by a key.
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final map = <K, List<T>>{};
    for (var element in this) {
      (map[keySelector(element)] ??= []).add(element);
    }
    return map;
  }
}

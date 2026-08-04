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

  /// Removes duplicates by [key] and returns a new list.
  List<T> distinctBy<K>(K Function(T) key) {
    final seen = <K>{};
    final result = <T>[];
    for (var element in this) {
      if (seen.add(key(element))) result.add(element);
    }
    return result;
  }

  /// Number of elements matching [test].
  int countWhere(bool Function(T) test) => where(test).length;

  /// Whether every element of [other] is contained in this iterable.
  bool containsAll(Iterable<T> other) => other.every(contains);

  /// Whether any element of [other] is contained in this iterable.
  bool containsAny(Iterable<T> other) => other.any(contains);

  /// Pairs elements with [other], stopping at the shorter iterable.
  List<(T, R)> zip<R>(Iterable<R> other) {
    final it = other.iterator;
    final result = <(T, R)>[];
    for (final element in this) {
      if (!it.moveNext()) break;
      result.add((element, it.current));
    }
    return result;
  }

  /// Inserts [separator] between consecutive elements.
  List<T> insertBetween(T separator) {
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(elementAt(i));
      if (i != length - 1) result.add(separator);
    }
    return result;
  }
}

extension NumIterableExtensions on Iterable<num> {
  /// Sum of all elements (0 when empty).
  num get sum => fold(0, (a, b) => a + b);

  /// Smallest element (0 when empty).
  num get min {
    if (isEmpty) return 0;
    var m = first;
    for (final e in this) {
      if (e < m) m = e;
    }
    return m;
  }

  /// Largest element (0 when empty).
  num get max {
    if (isEmpty) return 0;
    var m = first;
    for (final e in this) {
      if (e > m) m = e;
    }
    return m;
  }

  /// Arithmetic mean (0.0 when empty).
  double get average => isEmpty ? 0.0 : sum / length;
}

extension IterableNestedExtensions<T> on Iterable<Iterable<T>> {
  /// Flattens a nested iterable into a single list.
  List<T> flatten() => expand((e) => e).toList();
}

extension RecordIterableExtensions<R, S> on Iterable<(R, S)> {
  /// Splits an iterable of records into two lists.
  (List<R>, List<S>) unzip() {
    final left = <R>[];
    final right = <S>[];
    for (final (a, b) in this) {
      left.add(a);
      right.add(b);
    }
    return (left, right);
  }
}

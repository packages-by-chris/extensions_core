/// Collection helpers: grouping, zipping, and numeric aggregates.
library;

/// Extensions on [Iterable] for querying and grouping.
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

  /// Element with the smallest [selector] value.
  ///
  /// Throws [StateError] when the iterable is empty.
  T minBy<R extends Comparable>(R Function(T) selector) {
    if (isEmpty) throw StateError('minBy called on empty iterable');
    var best = first;
    var bestKey = selector(best);
    for (final element in this) {
      final key = selector(element);
      if (key.compareTo(bestKey) < 0) {
        best = element;
        bestKey = key;
      }
    }
    return best;
  }

  /// Element with the largest [selector] value.
  ///
  /// Throws [StateError] when the iterable is empty.
  T maxBy<R extends Comparable>(R Function(T) selector) {
    if (isEmpty) throw StateError('maxBy called on empty iterable');
    var best = first;
    var bestKey = selector(best);
    for (final element in this) {
      final key = selector(element);
      if (key.compareTo(bestKey) > 0) {
        best = element;
        bestKey = key;
      }
    }
    return best;
  }

  /// Number of occurrences of each element.
  Map<T, int> frequency() {
    final map = <T, int>{};
    for (final element in this) {
      map[element] = (map[element] ?? 0) + 1;
    }
    return map;
  }

  /// Whether no element matches [test].
  bool none(bool Function(T) test) => !any(test);

  /// All distinct elements of this iterable and [other].
  List<T> union(Iterable<T> other) => <T>{...this, ...other}.toList();

  /// Distinct elements present in both this iterable and [other].
  List<T> intersection(Iterable<T> other) =>
      toSet().intersection(other.toSet()).toList();

  /// Distinct elements of this iterable that are not in [other].
  List<T> difference(Iterable<T> other) =>
      toSet().difference(other.toSet()).toList();
}

/// Numeric aggregates (`sum`, `min`, `max`, `average`).
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

/// Helpers for nullable iterables and iterables of nullable elements.
extension NullableIterableExtensions<T> on Iterable<T>? {
  /// Whether the iterable is `null` or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

/// Removes `null` elements while narrowing the element type.
extension NullableElementIterableExtensions<T> on Iterable<T?> {
  /// Returns a new list with every `null` element removed.
  List<T> whereNotNull() => [
        for (final element in this)
          if (element != null) element
      ];
}

/// Helpers for iterables of iterables.
extension IterableNestedExtensions<T> on Iterable<Iterable<T>> {
  /// Flattens a nested iterable into a single list.
  List<T> flatten() => expand((e) => e).toList();
}

/// Helpers for iterables of 2-element records.
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

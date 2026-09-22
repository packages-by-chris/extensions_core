/// List helpers: slicing, chunking, deduplication, rotation.
library;

/// Extensions on [List] for slicing and transformations.
extension ListExtensions<T> on List<T> {
  /// Returns the last [n] elements of the list.
  List<T> takeLast(int n) {
    if (isEmpty) return [];
    if (n >= length) {
      return List.from(this);
    }
    return sublist(length - n);
  }

  /// Returns the first [n] elements of the list.
  List<T> takeFirst(int n) {
    if (isEmpty) return [];
    if (n >= length) {
      return List.from(this);
    }
    return sublist(0, n);
  }

  /// Splits the list into chunks of size [chunkSize].
  List<List<T>> chunked(int chunkSize) {
    if (isEmpty || chunkSize <= 0) return [];
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += chunkSize) {
      chunks.add(sublist(i, (i + chunkSize > length) ? length : i + chunkSize));
    }
    return chunks;
  }

  /// Returns a reversed copy of the list.
  List<T> reversedList() {
    return List<T>.from(reversed);
  }

  /// Removes duplicate elements and returns a new list.
  List<T> distinct() {
    return toSet().toList();
  }

  /// Returns the list shuffled randomly.
  List<T> shuffledList() {
    final shuffled = List<T>.from(this);
    shuffled.shuffle();
    return shuffled;
  }

  /// Maps elements to a new list with a given function [transform].
  List<R> mapToList<R>(R Function(T item) transform) {
    return map(transform).toList();
  }

  /// Returns a safe element at the given index or null if out of bounds.
  T? safeGet(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Checks whether the list contains only unique elements.
  bool hasUniqueElements() {
    return length == toSet().length;
  }

  /// Rotates the list by [count] positions (negative rotates left).
  List<T> rotate(int count) {
    if (isEmpty) return [];
    final n = count % length;
    if (n == 0) return List.from(this);
    if (n < 0) return rotate(n + length);
    return [...sublist(length - n), ...sublist(0, length - n)];
  }
}

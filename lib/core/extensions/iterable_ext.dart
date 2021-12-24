extension IterableEx<E> on Iterable<E> {
  Iterable<T> mapIndex<T>(T Function(E e, int i, bool isLast) mapFunction) =>
      toList().asMap().entries.map((entry) =>
          mapFunction(entry.value, entry.key, entry.key == length - 1));

  /// Safely access `.first` and `.last` from an iterable without throwing an error. Must supply `fallback` for a
  /// fallback item to return in case the iterable is empty.
  /// Kudos to https://mcgilldevtech.com/2019/04/beware-flutter-dart-iterable-throws-bad-state-no-element/
  ///
  /// Example:
  /// ```dart
  ///   final foos = <Foo>[];
  ///   final firstFoo = foos.safeFirst(Foo()); // Won't throw StateError, will return Foo()
  /// ```
  E safeFirst(E fallback) {
    try {
      return isNotEmpty ? first : throw Error();
    } catch (e) {
      return fallback;
    }
  }

  E safeLast(E fallback) {
    if (isEmpty) {
      return fallback;
    }

    return last;
  }
}

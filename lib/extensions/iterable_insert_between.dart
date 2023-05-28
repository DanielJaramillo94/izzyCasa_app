extension IterableInsertBetweenExtension<T> on Iterable<T> {
  Iterable<T> insertBetween(T element) sync* {
    final Iterator<T> iterator = this.iterator;
    if (!iterator.moveNext()) {
      return;
    }

    yield iterator.current;

    while (iterator.moveNext()) {
      yield element;
      yield iterator.current;
    }
  }
}

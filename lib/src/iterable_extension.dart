import 'dart:math';

extension IterableExtension<E> on Iterable<E> {
  Iterable<E> subListEnd(int start, [int? end]) {
    return this.skip(start).take(min(end ?? this.length, this.length));
  }
}

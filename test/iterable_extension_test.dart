import 'package:flutter_test/flutter_test.dart';
import 'package:mini_extension/mini_extension.dart';

void main() {
  test("iterable", () {
    List<int> _list = List.generate(50, (index) => index + 1);
    print(_list.sublist(8, 10));
    print(_list.subListEnd(8, 11));
    print(_list.where((element) => element > 7 && element < 8));

    /// 判断是否存在
    print(_list.any((element) => element == 10));

    /// 判断是否全部满足
    print(_list.every((element) => element >= 0 && element < 10));

    print(_list.expand((element) => [element, element + 1]));

    print(_list.skip(10));

    print(_list.take(10));

    print(_list.skipWhile((value) => value % 3 == 0));

    print(_list.take(15).takeWhile((value) => value > 10));
  });
}

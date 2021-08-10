import 'package:flutter_test/flutter_test.dart';
import 'package:mini_extension/mini_extension.dart';

void main() {
  test('string_extension', () {
    String str = "18516634912";
    assert(str.isPhone);
    str = "tel12121";
    assert(!str.isPhone);
    str = "1212@12.com";
    assert(str.isEmail);
    str = "-1212";
    assert(str.isAllNumber);
    str = "342921201002032133";
    assert(str.isIdCard18);
    str = "1234";
    assert(str.isPositiveNumber);
    str = "http://123.com";
    assert(str.isUrl);
    str = "https://123.com";
    assert(str.isUrl);
    str = "ftp://123.com";
    assert(str.isUrl);
    str = "121-swaa-21";
    assert(str.containsList(['12', 'aa']));
    str = "AA" * 5 + "BBB" * 7;
    print(str.ellipsis(12));
    print(str.isIncludeIndex(10, 12));
    assert(str.isIncludeIndex(10, 31));
    str = "JsonYe叶";
    assert(str.hasZh);
    str = "127.0.0.1";
    assert(str.isIp);
    str = "12.0.0";
    assert(!str.isIp);
  });
}

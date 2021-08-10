import 'package:flutter_test/flutter_test.dart';
import 'package:mini_extension/mini_extension.dart';

void main() {
  test('datetime_extension', () {
    String _dayStr = "2021-12-09 12:12:21.233";
    DateTime _day = _dayStr.toDateTime ?? DateTime.now();
    print(_day.getDateStr());
    print(_day.getDateTimeStr());
    print(_day.getDateTimeStr(format: 'yyyy-MM-dd HH:mm:ss.SSS EEEE',localType: MiniLocalType.en));
    print(_day.getDateStr(format: "EEEE"));
    print(_day.getDateStr(format: "EE"));
    print(_day.firstDayInMonth.getDateStr());
    print(_day.lastDayInMonth
        .getDateStr(format: 'MM-dd EEEE', localType: MiniLocalType.en));
    print(_day.firstDayInWeek.getDateStr(format: 'MM月dd日 EEEE'));
    print(_day.lastDayInWeek.getDateStr());
    _day = DateTime.now();
    print(_day.getDateTimeStr(format: 'yyyy年MM月dd日 HH时mm分ss秒 EEEE'));
    print(_day.getDateTimeStr(format: 'yyyy-MM-dd HH:mm:ss.SSS EEEE',localType: MiniLocalType.en));
    print(_day.getDateTimeStr());
    print(_day.getDateTimeStr(format: 'MM-dd HH:mm EE'));
    print(_day.getDateTimeStr(format: 'MM-dd HH:mm'));
    print(_day.millisecondsSinceEpoch);
    print(_day.microsecondsSinceEpoch);
    print(_day.firstDayInWeekWithZh.getDateStr());
    print(_day.lastDayInWeekWithZh.getDateStr());
    print(_day.isToday());
    print(_day.isYesterday());
    print(_day.previousMonth.getDateStr());
    print(_day.nextMonth.getDateStr());
    DateTime _one = "2020-02-12 01:12:11".toDateTime ?? DateTime.now();
    DateTime _two = "2020-02-12 01:12:12".toDateTime ?? DateTime.now();
    assert(_two > _one);
    assert(_two >= _one);
    assert(_one < _two);
    assert(_one <= _two);
  });

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

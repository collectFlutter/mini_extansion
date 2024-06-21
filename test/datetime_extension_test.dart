import 'package:mini_extension/mini_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('time', () {
    String _dayStr = "2021-12-09 12:12:21.233";
    DateTime _day = _dayStr.toDateTime ?? DateTime.now();
    print(_day.getDateTimeStr());
    print(_day.getDateTimeStr(
        format: 'yyyy-MM-dd HH:mm:ss.SSS EEEE', localType: MiniLocalType.en));
    _day = DateTime.now();
    print(_day.getDateTimeStr(format: 'yyyy年MM月dd日 HH时mm分ss秒 EEEE'));
    print(_day.getDateTimeStr(
        format: 'yyyy-MM-dd HH:mm:ss.SSS EEEE', localType: MiniLocalType.en));
    print(_day.getDateTimeStr());
    print(_day.getDateTimeStr(format: 'MM-dd HH:mm EE'));
    print(_day.getDateTimeStr(format: 'MM-dd HH:mm'));
    DateTime _one = "2020-02-12 01:12:11".toDateTime ?? DateTime.now();
    DateTime _two = "2020-02-12 01:12:12".toDateTime ?? DateTime.now();

    expect(_two > _one, true);
    expect(_two >= _one, true);
    expect(_one < _two, true);
    expect(_one <= _two, true);
  });

  test("month", () {
    StringBuffer buffer = StringBuffer();
    // StringBuffer title = StringBuffer();
    DateTime _start = DateTime(2021, 1, 31);
    // var firstDay = 31;
    List.generate(28, (firstDay) {
      firstDay += 1;
      DateTime _month = _start.copyWith();
      buffer.write("${firstDay.twoDigits} | ");
      List.generate(12, (_) {
        buffer
          ..write(_month.firstDayInMonth(firstDay).getDateStr(format: "MM-dd"))
          ..write('~')
          ..write(_month.lastDayInMonth(firstDay).getDateStr(format: "MM-dd"))
          ..write('  ');
        _month = _month.firstDayInNextMonth(firstDay);
      });
      buffer.write("\n");
    });
    print(buffer);
  });

  test("weekday", () {
    DateTime _time = "2021-01-10".toDateTime ?? DateTime.now();
    StringBuffer buffer = StringBuffer("当前时间: ")
      ..write(_time.getDateStr(format: 'yyyy-MM-dd EEEE'))
      ..write("，全年")
      ..write(_time.daysOfYear)
      ..write('天，现在是第')
      ..write(_time.dayIndexOfYear)
      ..write('天。\n')
      ..write("=======" * 7 + " 获取当前所在周  " + "=======" * 7)
      ..write('\n');
    for (int i = 1; i < 8; i++) {
      buffer
        ..write("| ")
        ..write(_time.firstDayInWeek(i).getDateStr(format: 'EEEE'))
        ..write("作为每周的第一天。")
        ..write('\n');
      List<DateTime> _weekdays = _time.getWeekdays(i);
      buffer
        ..write("| 本周包含：")
        ..write(_weekdays.map((e) => e.getDateStr(format: 'MM-dd EE')))
        ..write('\n')
        ..write("| 本年第一周：")
        ..write(_time
            .getFirstWeekdaysInYear(i)
            .map((e) => e.getDateStr(format: 'MM-dd EE')))
        ..write('\n')
        ..write("| 当前日期：")
        ..write(_time.getDateStr(format: 'yyyy-MM-dd EEEE'))
        ..write(
            "处在第 ${_time.weekIndexOfYear(i)} 周第 ${_time.dayIndexOfWeek(i)} 天。")
        ..write('\n')
        ..write("------" * 18)
        ..write('\n');
    }
    print(buffer);
  });
}

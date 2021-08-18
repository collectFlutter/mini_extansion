export 'num_extension.dart';

import 'dart:math';

import 'package:mini_extension/src/_i18nModel.dart';

extension DateTimeExtension on DateTime {
  /// 是否是今天 [now] - 当前时间，默认DateTime.now()
  bool isToday([DateTime? now]) {
    now ??= DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  /// 是否是昨天 [now] - 当前时间，默认DateTime.now()
  bool isYesterday([DateTime? now]) {
    now ??= DateTime.now();
    var yesterday = now.subtract(Duration(days: 1));
    return isToday(yesterday);
  }

  /// 上月第一天
  ///
  /// [firstDay] - 每月起算日期，assert(firstDay > 0 && firstDay < 29)
  DateTime firstDayInPreviousMonth([int firstDay = 1]) {
    return lastDayInPreviousMonth(firstDay).firstDayInMonth(firstDay);
  }

  /// 上月最后一天
  ///
  /// [firstDay] - 每月起算日期，assert(firstDay > 0 && firstDay < 29)
  DateTime lastDayInPreviousMonth([int firstDay = 1]) {
    return firstDayInMonth(firstDay).subtract(Duration(days: 1));
  }

  /// 下月第一天
  ///
  /// [firstDay] - 每月起算日期，assert(firstDay > 0 && firstDay < 29)
  DateTime firstDayInNextMonth([int firstDay = 1]) {
    return lastDayInMonth(firstDay).add(Duration(days: 1));
  }

  /// 下月最后一天
  ///
  /// [firstDay] - 每月起算日期，assert(firstDay > 0 && firstDay < 29)
  DateTime lastDayInNextMonth([int firstDay = 1]) {
    return firstDayInNextMonth(firstDay).lastDayInMonth(firstDay);
  }

  /// 当月第一天
  ///
  /// [firstDay] - 每月起算日期，assert(firstDay > 0 && firstDay < 29)
  DateTime firstDayInMonth([int firstDay = 1]) {
    assert(firstDay > 0 && firstDay < 29);
    if (firstDay <= day) {
      return DateTime(year, month, firstDay);
    } else {
      return DateTime(year, month - 1,
          min(firstDay, DateTime(year, month).subtract(Duration(days: 1)).day));
    }
  }

  /// 当月最后一天
  ///
  /// [firstDay] - 每月起算日期，assert(firstDay > 0 && firstDay < 29)
  DateTime lastDayInMonth([int firstDay = 1]) {
    assert(firstDay > 0 && firstDay < 29);
    if (firstDay <= day) {
      return DateTime(
          year,
          month + 1,
          min(firstDay - 1,
              DateTime(year, month + 2).subtract(Duration(days: 1)).day));
    } else {
      return DateTime(
          year,
          month,
          min(firstDay - 1,
              DateTime(year, month + 1).subtract(Duration(days: 1)).day));
    }
  }

  /// 当月总天数
  ///
  /// [firstDay] - 每月起算日期，assert(firstDay > 0 && firstDay < 29)
  int daysInMonth([int firstDay = 1]) =>
      ((lastDayInMonth(firstDay) - firstDayInMonth(firstDay)) / 86400000)
          .ceil();

  /// 获取时区
  double get timeZone {
    DateTime _local = DateTime.now();
    DateTime _localUtc = _local.toUtc();
    DateTime _nowUtc = DateTime.utc(_local.year, _local.month, _local.day,
        _local.hour, _local.minute, _local.second);
    DateTime _utc = DateTime.utc(_localUtc.year, _localUtc.month, _localUtc.day,
        _localUtc.hour, _localUtc.minute, _localUtc.second);
    Duration _d = _nowUtc.difference(_utc);
    return _d.inMinutes / 60.0;
  }

  /// 当年最早的时间
  DateTime get firstDayInYear => DateTime(year);

  /// 当年最后的时间
  DateTime get lastDayInYear =>
      DateTime(year + 1).subtract(Duration(microseconds: 1));

  /// 当年第一周的第一天。
  /// 算法：获取1月4号所在周的第一天
  DateTime firstWeekFirstDayInYear([int firstWeekDay = 1]) {
    return DateTime(year, 1, 4).firstDayInWeek(firstWeekDay);
  }

  /// 当年第一周所有日期
  List<DateTime> getFirstWeekdaysInYear([int firstWeekDay = 1]) {
    DateTime _day = firstWeekFirstDayInYear(firstWeekDay);
    return List.generate(7, (index) => _day.add(Duration(days: index)));
  }

  /// 当年第一周的最后一天。
  /// 算法：获取1月4号所在的周
  DateTime firstWeekLastDayInYear([int firstWeekDay = 1]) {
    return DateTime(year, 1, 4).lastDayInWeek(firstWeekDay);
  }

  /// 获取当前时间是一年中的第几周<br/>
  /// 0-上一年的最后一周<br/>
  /// -1-下一年的第一周
  int weekIndexOfYear([int firstWeekDay = 1]) {
    if (this > DateTime(year + 1).firstWeekFirstDayInYear(firstWeekDay)) {
      // 下一年的第一周
      return -1;
    }
    DateTime _firstDay = this.firstWeekFirstDayInYear(firstWeekDay);
    if (_firstDay > this) {
      // 上一年的最后一周
      return 0;
    }
    return ((this - _firstDay) / 604800000).ceil();
  }

  /// 本周第一天
  ///
  /// [firstWeekDay] - 设置每周起始日, assert(firstWeekDay > 0 && firstWeekDay < 7)
  DateTime firstDayInWeek([int firstWeekDay = 1]) {
    assert(firstWeekDay > 0 && firstWeekDay < 7);
    DateTime _day =
        this.subtract(Duration(days: (7 + weekday - firstWeekDay) % 7));
    return DateTime(_day.year, _day.month, _day.day);
  }

  /// 本周最后一天
  ///
  /// [firstWeekDay] - 设置每周起始日, assert(firstWeekDay > 0 && firstWeekDay < 7)
  DateTime lastDayInWeek([int firstWeekDay = 1]) {
    assert(firstWeekDay > 0 && firstWeekDay < 7);
    DateTime _day =
        this.subtract(Duration(days: (7 + weekday - firstWeekDay) % 7 - 6));
    return DateTime(_day.year, _day.month, _day.day);
  }

  /// 本周所有日期
  ///
  /// [firstWeekDay] - 设置每周起始日, assert(firstWeekDay > 0 && firstWeekDay < 7)
  List<DateTime> getWeekdays([int firstWeekDay = 1]) {
    assert(firstWeekDay > 0 && firstWeekDay < 7);
    DateTime _day = firstDayInWeek(firstWeekDay);
    return List.generate(7, (index) => _day.add(Duration(days: index)));
  }

  /// 上周第一天
  ///
  /// [firstWeekDay] - 设置每周起始日, assert(firstWeekDay > 0 && firstWeekDay < 7)
  DateTime firstDayInPreviousWeek([int firstWeekDay = 1]) {
    assert(firstWeekDay > 0 && firstWeekDay < 7);

    return this.subtract(Duration(days: 7)).firstDayInWeek(firstWeekDay);
  }

  /// 上周最后一天
  ///
  /// [firstWeekDay] - 设置每周起始日, assert(firstWeekDay > 0 && firstWeekDay < 7)
  DateTime lastDayInPreviousWeek([int firstWeekDay = 1]) {
    assert(firstWeekDay > 0 && firstWeekDay < 7);

    return this.subtract(Duration(days: 7)).lastDayInWeek(firstWeekDay);
  }

  /// 下周第一天
  ///
  /// [firstWeekDay] - 设置每周起始日, assert(firstWeekDay > 0 && firstWeekDay < 7)
  DateTime firstDayInNextWeek([int firstWeekDay = 1]) {
    assert(firstWeekDay > 0 && firstWeekDay < 7);

    return this.add(Duration(days: 7)).firstDayInWeek(firstWeekDay);
  }

  /// 下周最后一天
  ///
  /// [firstWeekDay] - 设置每周起始日, assert(firstWeekDay > 0 && firstWeekDay < 7)
  DateTime lastDayInNextWeek([int firstWeekDay = 1]) {
    assert(firstWeekDay > 0 && firstWeekDay < 7);

    return this.add(Duration(days: 7)).lastDayInWeek(firstWeekDay);
  }

  String getWeekStr([MiniLocalType localType = MiniLocalType.zh]) =>
      i18nObjInLocal(localType)['weekList'][weekday % 7];

  String getWeekShortStr([MiniLocalType localType = MiniLocalType.zh]) =>
      i18nObjInLocal(localType)['weekShortList'][weekday % 7];

  bool operator >=(DateTime other) =>
      this.millisecondsSinceEpoch >= other.millisecondsSinceEpoch;

  bool operator >(DateTime other) =>
      this.millisecondsSinceEpoch > other.millisecondsSinceEpoch;

  bool operator <=(DateTime other) =>
      this.millisecondsSinceEpoch <= other.millisecondsSinceEpoch;

  bool operator <(DateTime other) =>
      this.millisecondsSinceEpoch < other.millisecondsSinceEpoch;

  int operator -(DateTime other) =>
      this.millisecondsSinceEpoch - other.millisecondsSinceEpoch;

  String _fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  String _threeDigits(int n) {
    if (n >= 100) return "$n";
    if (n >= 10) return "0$n";
    return "00$n";
  }

  String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  /// 是否是闰年
  bool get isLeapYearByYear =>
      year % 4 == 0 && year % 100 != 0 || year % 400 == 0;

  /// 处在当年的第几天
  int get dayIndexOfYear {
    int days = day;
    for (int i = 1; i < month; i++) {
      days += DateTime(year, i + 1).subtract(Duration(days: 1)).day;
    }
    return days;
  }

  /// 获取当前日期处在当前周的第几天
  ///
  /// [firstWeekDay] - 设置每周起始日, assert(firstWeekDay > 0 && firstWeekDay < 7)
  int dayIndexOfWeek([int firstWeekDay = 1]) {
    assert(firstWeekDay > 0 && firstWeekDay < 7);
    int sub = this - this.firstDayInWeek(firstWeekDay);
    return (sub / 86400000).ceil() + 1;
  }

  /// 当年的总天数
  int get daysOfYear => isLeapYearByYear ? 366 : 365;

  DateTime copyWith(
          {int? year,
          int? month,
          int? day,
          int? hour,
          int? minute,
          int? second,
          int? millisecond,
          int? microsecond}) =>
      DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
        millisecond ?? this.millisecond,
        microsecond ?? this.microsecond,
      );

  /// 获取时间字符串
  /// `yyyy-MM-dd HH:mm:ss.SSS EEEE/EE` <br/>
  /// - yyyy:年份
  /// - MM：月份
  /// - dd：日
  /// - HH：时
  /// - mm：分
  /// - ss：秒
  /// - SSS：毫秒
  /// - EEEE：长星期
  /// - EE：短星期
  String getDateTimeStr(
      {String format = 'yyyy-MM-dd HH:mm:ss',
      MiniLocalType localType = MiniLocalType.zh}) {
    String str = format;
    if (str.contains('yyyy')) {
      String y = _fourDigits(year);
      str = str.replaceAll('yyyy', y);
    }
    if (str.contains('MM')) {
      String m = _twoDigits(month);
      str = str.replaceAll('MM', m);
    }
    if (str.contains('dd')) {
      String d = _twoDigits(day);
      str = str.replaceAll('dd', d);
    }
    if (str.contains('HH')) {
      String h = _twoDigits(hour);
      str = str.replaceAll('HH', h);
    }
    if (str.contains('mm')) {
      String min = _twoDigits(minute);
      str = str.replaceAll('mm', min);
    }
    if (str.contains('ss')) {
      String sec = _twoDigits(second);
      str = str.replaceAll('ss', sec);
    }
    if (str.contains('SSS')) {
      String ms = _threeDigits(millisecond);
      str = str.replaceAll('SSS', ms);
    }
    if (str.contains('EEEE')) {
      String weekday = getWeekStr(localType);
      str = str.replaceAll('EEEE', weekday);
    }
    if (str.contains('EE')) {
      String weekShortStr = getWeekShortStr(localType);
      str = str.replaceAll('EE', weekShortStr);
    }
    return str;
  }

  /// 获取日期显示字符串 yyyy-MM-dd EEEE/EE
  String getDateStr(
      {String format = 'yyyy-MM-dd',
      MiniLocalType localType = MiniLocalType.zh}) {
    String str = format;
    if (str.contains('yyyy')) {
      String y = _fourDigits(year);
      str = str.replaceAll('yyyy', y);
    }
    if (str.contains('MM')) {
      String m = _twoDigits(month);
      str = str.replaceAll('MM', m);
    }
    if (str.contains('dd')) {
      String d = _twoDigits(day);
      str = str.replaceAll('dd', d);
    }
    if (str.contains('EEEE')) {
      String weekday = getWeekStr(localType);
      str = str.replaceAll('EEEE', weekday);
    }
    if (str.contains('EE')) {
      String weekShortStr = getWeekShortStr(localType);
      str = str.replaceAll('EE', weekShortStr);
    }
    return str;
  }
}

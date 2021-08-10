export 'num_extension.dart';

import 'package:mini_extension/src/_i18nModel.dart';

extension DateTimeExtension on DateTime {
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

  bool isToday([DateTime? now]) {
    now ??= DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday([DateTime? now]) {
    now ??= DateTime.now();
    var yesterday = now.subtract(Duration(days: 1));
    return isToday(yesterday);
  }

  DateTime get previousMonth => DateTime(year, month - 1);

  DateTime get nextMonth => DateTime(year, month + 1);

  DateTime get firstDayInMonth => DateTime(year, month);

  DateTime get lastDayInMonth =>
      DateTime(year, month + 1).subtract(Duration(days: 1));

  int get daysInMonth => lastDayInMonth.day;

  DateTime get firstDayInWeekWithZh {
    var _day = this.subtract(Duration(days: weekday - 1));
    return DateTime(_day.year, _day.month, _day.day);
  }

  DateTime get lastDayInWeekWithZh {
    var _day = this.add(Duration(days: 7 - weekday));
    return DateTime(_day.year, _day.month, _day.day);
  }

  DateTime get firstDayInWeek {
    var _day = this.subtract(Duration(days: weekday % 7));
    return DateTime(_day.year, _day.month, _day.day);
  }

  DateTime get lastDayInWeek {
    var _day =
        this.subtract(Duration(days: weekday % 7)).add(Duration(days: 6));
    return DateTime(_day.year, _day.month, _day.day);
  }

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

  String getWeekStr([MiniLocalType localType = MiniLocalType.zh]) =>
      i18nObjInLocal(localType)['weekList'][weekday - 1];

  String getWeekShortStr([MiniLocalType localType = MiniLocalType.zh]) =>
      i18nObjInLocal(localType)['weekShortList'][weekday - 1];

  // String getDateTimeStr({
  //   String yearSeparate = '-',
  //   String monthSeparate = '-',
  //   String daySeparate = ' ',
  //   String hourSeparate = ':',
  //   String minuteSeparate = ':',
  //   String secondSeparate = '',
  // }) {
  //   return "${_fourDigits(year)}$yearSeparate${_twoDigits(month)}$monthSeparate${_twoDigits(day)}$daySeparate${_twoDigits(hour)}$hourSeparate${_twoDigits(minute)}$minuteSeparate${_twoDigits(second)}$secondSeparate";
  // }

  bool operator >=(DateTime other) =>
      this.millisecondsSinceEpoch >= other.millisecondsSinceEpoch;

  bool operator >(DateTime other) =>
      this.millisecondsSinceEpoch > other.millisecondsSinceEpoch;

  bool operator <=(DateTime other) =>
      this.millisecondsSinceEpoch <= other.millisecondsSinceEpoch;

  bool operator <(DateTime other) =>
      this.millisecondsSinceEpoch < other.millisecondsSinceEpoch;

  // String _fourDigits(int num) {
  //   var sign = num < 0 ? '-' : '';
  //   int abs = num.abs();
  //   if (abs > 999) return "$num";
  //   if (abs > 99) return "${sign}0$abs";
  //   if (abs > 9) return "${sign}00$abs";
  //   return "${sign}000$abs";
  // }
  //
  // String _twoDigits(int num) {
  //   var sign = num < 0 ? '-' : '';
  //   int abs = num.abs();
  //   if (abs > 9) return "$num";
  //   return "${sign}0$abs";
  // }

  String _fourDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  String _sixDigits(int n) {
    assert(n < -9999 || n > 9999);
    int absN = n.abs();
    String sign = n < 0 ? "-" : "+";
    if (absN >= 100000) return "$sign$absN";
    return "${sign}0$absN";
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
}

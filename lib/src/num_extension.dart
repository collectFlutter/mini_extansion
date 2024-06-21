/// 整数相关
extension IntExtension on int {
  String get fourDigits {
    int absN = this.abs();
    String sign = this < 0 ? "-" : "";
    if (absN >= 1000) return "$this";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  String get threeDigits {
    int absN = this.abs();
    String sign = this < 0 ? "-" : "";
    if (absN >= 100) return "$this";
    if (absN >= 10) return "${sign}0$this";
    return "${sign}00$this";
  }

  String get twoDigits {
    int absN = this.abs();
    String sign = this < 0 ? "-" : "";
    if (absN >= 10) return "$this";
    return "${sign}0$absN";
  }
}

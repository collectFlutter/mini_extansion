extension intExtension on int {
  String get fourDigits {
    var sign = this < 0 ? '-' : '';
    int abs = this.abs();
    if (abs > 999) return "$this";
    if (abs > 99) return "${sign}0$abs";
    if (abs > 9) return "${sign}00$abs";
    return "${sign}000$abs";
  }

  String get twoDigits {
    var sign = this < 0 ? '-' : '';
    int abs = this.abs();
    if (abs > 9) return "$this";
    return "${sign}0$abs";
  }
}

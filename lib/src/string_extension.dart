extension StringExtension on String {
  /// 字符串中间截取
  String ellipsis([int? length]) {
    if (isEmpty) return '';
    if (length == null || length < 0 || this.length <= length) return this;
    length = (length / 2).floor() - 3;
    return this.substring(0, length + 1) +
        '...' +
        this.substring(this.length - length - 1);
  }

  /// 多关键字模糊匹配
  bool containsList(List<String> keys) {
    if (keys.isEmpty) return true;
    String regStr = "(?=.*${keys.join(')(?=.*')})".toLowerCase();
    return this.toLowerCase().contains(RegExp(regStr));
  }

  /// 是否是url
  bool get isUrl =>
      isNotEmpty &&
      (this.indexOf("http://") == 0 ||
          this.indexOf("https://") == 0 ||
          this.indexOf("ftp://") == 0);

  /// 是否是手机号
  bool get isPhone => hasMatch(
      "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[6])|(17[0,1,3,5-8])|(18[0-9])|(19[8,9]))\\d{8}\$");

  /// 是否是座机号码
  bool get isTel => hasMatch("^0\\d{2,3}[- ]?\\d{7,8}");

  /// 是否是自然数
  bool get isAllNumber => hasMatch(r'^(\-|\+)?\d+(\.\d+)?$');

  /// 正数
  bool get isPositiveNumber => hasMatch(r'^(\+)?\d+?$');

  /// 是否是身份证
  bool get isIdCard18 => hasMatch(
      "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9Xx])\$");

  /// 是否是邮箱
  bool get isEmail =>
      hasMatch("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$");

  /// 正则表达式匹配
  bool hasMatch(String source) => RegExp(source).hasMatch(this);

  /// 长度范围
  bool isIncludeIndex([int min = 10, int max = 20]) =>
      this.length >= min && this.length <= max;

  /// 是否含有中文
  bool get hasZh => hasMatch(r"[\u4E00-\u9FA5\uF900-\uFA2D]");

  /// 是否是ip地址
  bool get isIp => hasMatch(
      "((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)");
}

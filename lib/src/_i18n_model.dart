enum MiniLocalType { en, zh }

final _i18nModel = {
  'en': {
    'weekShortList': ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'],
    'weekList': [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ],
    'monthShortList': [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ],
    'monthList': [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ]
  },
  'zh': {
    'weekShortList': ['日', '一', '二', '三', '四', '五', '六'],
    'weekList': ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
    'monthShortList': [
      '一',
      '二',
      '三',
      '四',
      '五',
      '六',
      '七',
      '八',
      '九',
      '十',
      '十一',
      '十二'
    ],
    'monthList': [
      '一月',
      '二月',
      '三月',
      '四月',
      '五月',
      '六月',
      '七月',
      '八月',
      '九月',
      '十月',
      '十一月',
      '十二月'
    ]
  }
};

Map<String, dynamic> i18nObjInLocal(MiniLocalType type) {
  switch (type) {
    case MiniLocalType.en:
      return _i18nModel['en']!;
    case MiniLocalType.zh:
    default:
      return _i18nModel['zh']!;
  }
}

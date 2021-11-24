import 'package:flustars/flustars.dart';

class TimeUtils {
  // 获取当时字符串
  static String getNow() {
    return DateUtil.getNowDateStr();
  }

  // 获取字符串
  static String getTime(DateTime? time, {String format = "yyyy-MM-dd"}) {
    if (time == null) return "";
    return DateUtil.formatDate(time, format: format);
  }

  // 获取当时字符串
  static String getNowTime() {
    return DateUtil.formatDate(DateTime.now(), format: "yyyy-MM-dd");
  }

  static String getStartOfMouth(DateTime date, {String? format}) {
    String time = DateUtil.formatDate(date, format: "yyyy-MM-01");
    return time + " 00:00:00";
  }

  //获取当前时间的一天的开始时间
  static String getStartOfDay(DateTime date, {String? format}) {
    if (format != null) {
      return DateUtil.formatDate(date, format: format);
    }
    String time = DateUtil.formatDate(date, format: "yyyy-MM-dd");
    return time + " 00:00:00";
  }

  static DateTime getStartOfDayTime(DateTime date) {
    String time = DateUtil.formatDate(date, format: "yyyy-MM-dd");
    time += " 00:00:00";
    return DateUtil.getDateTime(time) as DateTime;
  }

  //获取当前时间的一天的结束时间
  static String getEndOfDay(DateTime date, {String? format}) {
    if (format != null) {
      return DateUtil.formatDate(date, format: format);
    }
    String time = DateUtil.formatDate(date, format: "yyyy-MM-dd");
    return time + " 23:59:59";
  }

  static DateTime getEndOfDayTime(DateTime date) {
    String time = DateUtil.formatDate(date, format: "yyyy-MM-dd");
    time += " 23:59:59";
    return DateUtil.getDateTime(time) as DateTime;
  }

  //获取几天前的时间
  static DateTime getDateBefore(int n) {
    int time = DateUtil.getNowDateMs() - n * 86400000;
    return DateUtil.getDateTimeByMs(time);
  }

  static int compare(String date1, String date2) {
    return DateUtil.getDateTime(date1)!.compareTo(DateUtil.getDateTime(date2)!);
  }

  static int during(String date1, String date2) {
    if (date2.substring(0, 10) != date1.substring(0, 10)) {
      //不是同一天，
      return DateUtil.getDateTime(date1 + " 23:59:59")!
          .difference(DateUtil.getDateTime(date2)!)
          .inDays;
    }
    return DateUtil.getDateTime(date1 + " 23:59:59")!
            .difference(DateUtil.getDateTime(date2)!)
            .inDays +
        1;
  }
}

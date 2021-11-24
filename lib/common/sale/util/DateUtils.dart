
class DateUtils {

  static DateTime? string2Date(String? time) {
    if (time == null || time.length == 0) return null;
    return DateTime.parse(time);
  }

  static String? date2String(DateTime? dateTime) {
    if (dateTime == null) return null;
    String time = dateTime.toString();
    return time.replaceAll(".000", "");
  }

}
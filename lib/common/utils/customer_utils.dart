


class CustomerUtils {

  static String encodePhone(String? phone) {
    if (phone == null) {
      return "";
    } else if (phone.length < 4) {
      return phone;
    } else if (phone.length > 4 && phone.length < 8) {
      var str = "${phone.substring(0, 3)}";
      var count = phone.length - 3;
      for (int i = 0; i < count; i++) {
        str = "$str*";
      }
      return str;
    } else {
      var start = phone.substring(0, 3);
      var end = phone.substring(7);
      return "$start****$end";
    }
  }

}
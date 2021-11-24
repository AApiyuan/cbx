import 'package:get/get.dart';

class ArgUtils {
  static Map<String, dynamic> string2Map(String arguments) {
    List<String> arg = arguments.split("&");
    Map<String, dynamic> map = {};
    arg.forEach((element) {
      List<String> items = element.split("=");
      map[items[0]] = items[1];
    });
    return map;
  }

  static String map2String({required String path, Map<String, dynamic>? arguments}) {
    //if (path == null && arguments == null) return "";
    if (arguments == null) return path;
    String arg = "";
    arguments.forEach((key, value) => arg = "$arg&$key=$value");
    arg = arg.replaceFirst("&", "?");
    //if (path == null) return arg;
    print("flutter_tag===============$arg");
    return "$path$arg";
  }

  static String? getArgument(String key) {
    return Get.parameters[key];
    //return Get.parameters == null ? null : Get.parameters[key];
  }

  static num? getArgument2num(String key, {num? def}) {
    String? value = getArgument(key);
    if (value == null || value == "null" || value == "(null)") {
      return def;
    }
    print("flutter_tag======getArgument2num======$value");
    return num.parse(value);
  }

  static bool? getArgument2bool(String key, {bool? def}) {
    String? value = getArgument(key);
    if (value == null || !value.isBool) {
      return def;
    }
    return value == "true";
  }
}

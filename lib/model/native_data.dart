
import 'dart:convert';

class NativeData {

  late num type;
  String? mode;
  String? data;

  static const TYPE_OFF = "off";
  static const TYPE_TO = "to";

  NativeData.fromJson(dynamic jsonStr) {
    var json = jsonDecode(jsonStr);
    type = json['type'];
    data = json['data'];
    mode = json['mode'] ?? TYPE_OFF;
  }

}
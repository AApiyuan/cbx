import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/formatter/num_text_input_formatter.dart';

class CommonUtils {
  static num? _lastClickTime;

  static const num _fastTime = 800;

  static RegExp regexp =
      RegExp("[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]");

  static bool isFastClick() {
    num currTime = DateTime.now().millisecondsSinceEpoch;
    // bool isFast = currTime - (_lastClickTime ?? 0) <= _fastTime;
    // _lastClickTime = currTime;
    // return isFast;
    if (currTime - (_lastClickTime ?? 0) <= _fastTime) {
      return true;
    }
    _lastClickTime = currTime;
    return false;
  }

  //获取input限制
  static List<TextInputFormatter> getTextInputFormatter(int length) {
    return [LengthLimitingTextInputFormatter(length), FilteringTextInputFormatter.deny(regexp)];
  }

  //获取input限制
  static List<TextInputFormatter> getTextInputNumFormatter({double? max}) {
    return [FilteringTextInputFormatter.deny(regexp), NumTextInputFormatter(max: max)];
  }

  static bool isisAllScreenDevice() {
    var rate = Get.height / Get.width;//超过 16：9；
    return rate > 1.78;
  }
}

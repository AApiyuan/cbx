import 'dart:ui';

import 'package:haidai_flutter_module/common/config/config.dart';

class DeviceUtil {
  static bool isPad() {
    var s = window.physicalSize.width;
    if (Config.isIOS &&
        (s == 2048.0 ||
            s == 1448.0 ||
            s == 1668.0 ||
            s == 1488.0 ||
            s == 1640.0 ||
            s == 1536.0 ||
            s == 768.0)) {
      return true;
    } else {
      return false;
    }
  }
}

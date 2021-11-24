import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';

class OssController extends GetxController {
  static Map<String, String> urlMap = {};

  String getUrl(String key) {
    _getImgPath(key);
    return urlMap.containsKey(key) ? (urlMap[key] ?? "") : key;
  }

  _getImgPath(String imgName) async {
    if (urlMap[imgName] == null) {
      MethodChannel channel = MethodChannel(ChannelConfig.flutterToNative);
      String url =
          await channel.invokeMethod(ChannelConfig.methodGetOss, imgName);
      if (urlMap[imgName] != url) {
        urlMap[imgName] = url;
        update([imgName]);
      }
    }
  }

  // Future<bool> checkTimeout() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   int currTime = DateTime.now().millisecond;
  //   if (sharedPreferences.containsKey("oss_update_time")) {
  //     int time = sharedPreferences.getInt("oss_update_time");
  //     if (time - currTime > 1000 * 60 * 30) {
  //       sharedPreferences.setInt("oss_update_time", currTime);
  //       return true;
  //     }
  //   }
  //   sharedPreferences.setInt("oss_update_time", currTime);
  //   return false;
  // }
}

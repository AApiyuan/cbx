import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';

class BackUtils {
  static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  static AndroidDeviceInfo? androidInfo;

  static void init() {
    if (GetPlatform.isAndroid) {
      deviceInfo.androidInfo.then((v) {
        androidInfo = v;
      });
    }
  }

  static bool canPop() {
    return Get.global(null).currentState?.canPop() ?? false;
  }

  static void back({Function(bool)? callback, dynamic result}) {
    bool can = canPop();
    if (callback == null) {
      if (can) {
        Get.back(result: result);
      } else {
        if (androidInfo != null && androidInfo!.brand == 'vivo') {
          Get.offAndToNamed(Routes.HOME);
          Future.delayed(Duration(milliseconds: 180), () {
            MethodChannel flutterToNative = const MethodChannel(ChannelConfig.flutterToNative);
            flutterToNative.invokeMethod(ChannelConfig.methodFinish);
          });
        } else {
          const MethodChannel(ChannelConfig.flutterToNative).invokeMethod(ChannelConfig.methodFinish);
        }
      }
    } else {
      callback.call(can);
    }
  }

  static void backToNative() {
    back();
    // if (androidInfo != null && androidInfo!.brand == 'vivo') {
    // Get.back();
    // Future.delayed(Duration(milliseconds: 150), () {
    //   MethodChannel flutterToNative = const MethodChannel(ChannelConfig.flutterToNative);
    //   flutterToNative.invokeMethod(ChannelConfig.methodFinish);
    // });
    // } else {
    //   MethodChannel flutterToNative = const MethodChannel(ChannelConfig.flutterToNative);
    //   flutterToNative.invokeMethod(ChannelConfig.methodFinish);
    // }
  }
}

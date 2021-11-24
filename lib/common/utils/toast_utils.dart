
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';


toastMsg(String msg) {
  // print("flutter_tag================$msg");
  // MethodChannel channel = new MethodChannel(ChannelConfig.flutterToNative);
  // channel.invokeMethod(ChannelConfig.methodToast, msg);
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Color.fromRGBO(0, 0, 0, 0.6)
    ..textColor = Colors.blue
    ..maskColor  = Colors.blue
    ..indicatorColor  = Colors.blue
    ..contentPadding = EdgeInsets.fromLTRB(30.w, 15.w, 30.w, 15.w)
    ..radius = 15.w
    ..textStyle = TextStyle(color: Color(ColorConfig.color_ffffff),fontSize: 26.w);
  EasyLoading.showToast(msg);
}
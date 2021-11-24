import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckTitle01 {
  PreferredSizeWidget appBar(BuildContext context, String content,
      {VoidCallback? callBack,List<Widget>? actions}) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: IconButton(
          icon: Image.asset("images/icon_back_gray.png"),
          onPressed: () {
            if (callBack == null) {
              Get.back(result: true);
            } else {
              callBack.call();
            }
          },
        ),
      ),
      leadingWidth: 102.w,
      toolbarHeight: 88.w,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        content,
        style:
            TextStyle(color: Color(ColorConfig.color_333333), fontSize: 34.w),
        textAlign: TextAlign.center,
      ),
      actions: actions,
    );
  }
}

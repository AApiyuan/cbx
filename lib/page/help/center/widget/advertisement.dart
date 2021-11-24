import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/help/center/controller/help_center_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';

Widget advertisement() {
  return GetBuilder<HelpCenterController>(builder: (ctl) {
    return Container(
      height: 140.w,
      margin:EdgeInsets.only(left: 24.w,right: 24.w,top:35.w),
      decoration: BoxDecoration(
          color: Color(ColorConfig.color_333333),
          borderRadius: BorderRadius.all(Radius.circular(20.w))),
      child: Container(),
    );
  });
}

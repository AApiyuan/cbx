import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';

Widget titleView(String title) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontSize: 34.w,
        fontWeight: FontWeight.bold,
        color: Color(ColorConfig.color_333333)),
  );
}

Widget backButton() {
  return IconButton(
    icon: Icon(
      Icons.arrow_back_ios_sharp,
    ),
    iconSize: 40.w,
    onPressed: () => BackUtils.back(),
  );
}


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

showDeleteDialog(Function function) {
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (_) => CustomDialog(
      type: 1,
      height: 220,
      outsideDismiss: false,
      content: pText(
        "确定删除货品吗？",
        ColorConfig.color_333333,
        32.w,
        fontWeight: FontWeight.bold,
      ),
      confirmTextColor: ColorConfig.color_FF3715,
      confirmContent: "删除",
      confirmCallback: (value) => function.call(),
    ),
  );
}
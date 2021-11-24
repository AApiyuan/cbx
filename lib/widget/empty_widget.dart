import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget emptyWidget({
  int bgColor = ColorConfig.color_ffffff,
  String image = "images/icon_goods_empty.png",
  String text = "当前没有数据哦~",
  double? width,
  double? height,
}) {
  return Container(
    alignment: Alignment.center,
    color: Color(bgColor),
    width: width,
    height: height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(image),
          width: 270.w,
        ),
        pText(text, ColorConfig.color_333333, 28.w),
      ],
    ),
  );
}

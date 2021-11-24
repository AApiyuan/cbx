import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

Widget skuBar({String stockText = "正品库存", String text = "盘点数量"}) {
  return Row(
    children: [
      Container(
        margin: EdgeInsetsDirectional.only(start: 24.w),
        color: Color(ColorConfig.color_f5f5f5),
        width: 147.w,
        height: 56.w,
        child: Center(
          child: Text(
            "颜色",
            style: textStyle(size: 24, color: ColorConfig.color_666666),
          ),
        ),
      ),
      Container(
        width: 1.w,
        height: 56.w,
        color: Color(ColorConfig.color_dcdcdc),
      ),
      Container(
        color: Color(ColorConfig.color_f5f5f5),
        width: 148.w,
        height: 56.w,
        child: Center(
          child: Text(
            "尺码",
            style: textStyle(size: 24, color: ColorConfig.color_666666),
          ),
        ),
      ),
      Container(
        width: 1.w,
        height: 56.w,
        color: Color(ColorConfig.color_dcdcdc),
      ),
      Container(
        color: Color(ColorConfig.color_f5f5f5),
        width: 145.w,
        height: 56.w,
        child: Center(
          child: Text(
            stockText,
            style: textStyle(size: 24, color: ColorConfig.color_666666),
          ),
        ),
      ),
      Container(
        width: 1.w,
        height: 56.w,
        color: Color(ColorConfig.color_dcdcdc),
      ),
      Container(
        color: Color(ColorConfig.color_f5f5f5),
        width: 259.w,
        height: 56.w,
        child: Center(
          child: Text(
            text,
            style: textStyle(size: 24, color: ColorConfig.color_666666),
          ),
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget bottomButton(String text, VoidCallback callback,
    {EdgeInsetsGeometry padding = EdgeInsetsDirectional.zero,
    Color? backgroundColor}) {
  return FlatButton(
    color: backgroundColor ?? Colors.transparent,
    padding: padding,
    onPressed: callback,
    child: Container(
      width: double.infinity,
      height: 96.w,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: textStyle(size: 32, color: ColorConfig.color_ffffff),
        ),
      ),
      decoration: ShapeDecoration(
        color: Color(ColorConfig.color_1678FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(58.w)),
        ),
      ),
    ),
  );
}

Widget bottomBtn(String text, Function function,
    {EdgeInsets margin = EdgeInsets.zero}) {
  return Expanded(
    child: GestureDetector(
      child: Container(
        decoration: ShapeDecoration(
          color: Color(ColorConfig.color_1678FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.w),
          ),
        ),
        height: 96.w,
        margin: margin,
        alignment: Alignment.center,
        child: pText(text, ColorConfig.color_ffffff, 32.w),
      ),
      onTap: () => function.call(),
    ),
  );
}

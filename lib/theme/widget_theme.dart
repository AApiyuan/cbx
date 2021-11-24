import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle textStyle({
  double size = 28,
  bool bold = false,
  int color = ColorConfig.color_333333,
  TextDecoration decoration = TextDecoration.none,
  int background = ColorConfig.color_00000000,
  double? letterSpacing,
}) {
  return TextStyle(
    fontSize: size.w,
    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    color: Color(color),
    decoration: decoration,
    backgroundColor: Color(background),
    letterSpacing: letterSpacing,
  );
}

BorderSide borderSide({
  int color = ColorConfig.color_efefef,
  double width = 1,
}) {
  return BorderSide(width: width.w, color: Color(color));
}

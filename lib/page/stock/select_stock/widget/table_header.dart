import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget tableHeader() {
  return Container(
    height: 56.w,
    decoration:
        BoxDecoration(color: Color(ColorConfig.color_f5f5f5), border: Border(bottom: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 1.w))),
    child: Row(
      children: [
        Container(
          width: 96.w,
          height: 56.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 1.w))),
          child: pText("序号", ColorConfig.color_666666, 24.w),
        ),
        Container(
          width: 163.w,
          height: 56.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 1.w))),
          child: pText("业务类型", ColorConfig.color_666666, 24.w),
        ),
        Container(
          width: 163.w,
          height: 56.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 1.w))),
          child: pText("变动数量", ColorConfig.color_666666, 24.w),
        ),
        Container(
          width: 163.w,
          height: 56.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border(right: BorderSide(color: Color(ColorConfig.color_dcdcdc), width: 1.w))),
          child: pText("操作人", ColorConfig.color_666666, 24.w),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: 56.w,
            child: pText("操作时间", ColorConfig.color_666666, 24.w),
          ),
        )
      ],
    ),
  );
}

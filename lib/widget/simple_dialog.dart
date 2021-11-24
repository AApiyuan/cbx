import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

// ignore: must_be_immutable
class CheckDialog extends Dialog {
  final title;
  final cancelText;
  final checkText;
  final cancelFunction;
  final checkFunction;
  TextStyle? checkStyle;

  static final redCheckStyle = textStyle(
    size: 32,
    color: ColorConfig.color_ff3715,
  );

  CheckDialog(
    this.title, {
    this.cancelText = "取消",
    this.checkText = "确定",
    this.cancelFunction,
    this.checkFunction,
    this.checkStyle,
  }) {
    if (checkStyle == null) {
      checkStyle = textStyle(
        size: 32,
        color: ColorConfig.color_1678FF,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(ColorConfig.color_88000000),
      alignment: Alignment.center,
      child: Container(
        height: 220.w,
        width: 550.w,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.w))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 48.w),
            Container(
              margin: EdgeInsetsDirectional.only(top: 48.w, bottom: 30.w),
              child: Text(title, style: textStyle(size: 32, bold: true)),
            ),
            // SizedBox(height: 30.w),
            Divider(color: Color(ColorConfig.color_efefef), height: 1.w),
            Container(
              height: 92.w,
              child: Row(
                children: [
                  SizedBox(width: 5.w),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      child: Text(
                        cancelText,
                        style: textStyle(
                          size: 32,
                          color: ColorConfig.color_999999,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      color: Colors.white,
                      onPressed: () {
                        if (cancelFunction != null) cancelFunction();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(color: Color(ColorConfig.color_efefef), width: 1.w),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      child: Text(
                        checkText,
                        style: checkStyle,
                        textAlign: TextAlign.center,
                      ),
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        if (checkFunction != null) checkFunction();
                      },
                    ),
                  ),
                  SizedBox(width: 5.w),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

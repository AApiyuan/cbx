import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// ignore: must_be_immutable
class CommonDialog extends StatelessWidget {
  var leftWidget;
  var title;
  var content;

  CommonDialog(this.title, this.content, {this.leftWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // header(),
        Expanded(
          child: Container(
            child: content,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  header() {
    return Container(
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: 108.w,
              child: leftWidget ?? pSizeBoxW(0),
              alignment: Alignment.center,
            ),
            left: 0,
          ),
          Expanded(
            child: Container(
              child: pText(title, ColorConfig.color_333333, 32.w,
                  fontWeight: FontWeight.bold),
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            child: InkWell(
              child: pImage("images/icon_dialog_close.png", 60.w, 60.w),
              onTap: () => Get.back(),
            ),
            right: 24.w,
            top: 24.w,
          ),
        ],
      ),
      height: 108.w,
      // margin: EdgeInsets.only(top: 192.w),
      decoration: ShapeDecoration(
        color: Color(ColorConfig.color_ffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.w),
            topRight: Radius.circular(30.w),
          ),
        ),
      ),
    );
  }

  showBottom(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: Get.context!,
      animationCurve: Curves.easeIn,
      builder: (context) => BottomSheetWidget(
        child: this,
        title: title,
        showCertain: false,
        leftWidget: leftWidget,
        height: 1400.w,
      ),
    );
  }
}

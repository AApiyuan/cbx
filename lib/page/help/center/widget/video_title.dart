import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/help/center/controller/help_center_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:url_launcher/url_launcher.dart';

Widget videoTitle() {
  return GetBuilder<HelpCenterController>(builder: (ctl) {
    return Container(
      height: 72.w,
      margin: EdgeInsets.only(top: 28.w),
      padding: EdgeInsets.only(left: 24.w, right: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              pImage("images/play.png", 36.w, 36.w),
              pSizeBoxW(14.w),
              pText("一看就会", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
              pSizeBoxW(14.w),
              pText("任意页面摇一摇就能打开", ColorConfig.color_999999, 24.w)
            ],
          ),
          GestureDetector(
            onTap: () {
              showCupertinoModalPopup(
                context: Get.context!,
                builder: (context) {
                  return Container(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.w),
                      child: CupertinoActionSheet(
                        actions: <Widget>[
                          //操作按钮集合
                          CupertinoActionSheetAction(
                            onPressed: () {
                              launch("tel://400-688-1896");
                              Navigator.pop(context);
                            },
                            child: pText('呼叫: 400-688-1896', ColorConfig.color_1678ff, 32.w),
                          )
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          //取消按钮
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: pText('取消', ColorConfig.color_1678ff, 32.w, fontWeight: FontWeight.w600),
                        ),
                      ));
                },
              );
            },
            child: Row(
              children: [
                pText(
                  "不会call我",
                  ColorConfig.color_999999,
                  24.w,
                ),
                pSizeBoxW(15.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 24.w,
                  color: new Color(ColorConfig.color_999999),
                )
              ],
            ),
          )
        ],
      ),
    );
  });
}

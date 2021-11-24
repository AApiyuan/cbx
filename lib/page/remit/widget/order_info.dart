import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/remit/controller/remit_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/date_pick.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget orderInfo() {
  return GetBuilder<RemitController>(builder: (ctl) {
    return Visibility(
        visible: true,
        child: Container(
          width: double.infinity,
          height: 165.w,
          margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.w),
          padding: EdgeInsets.fromLTRB(20.w, 30.w, 24.w, 30.w),
          decoration: BoxDecoration(color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.all(Radius.circular(20.w))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  showCupertinoModalBottomSheet(
                      context: Get.context!,
                      animationCurve: Curves.easeIn,
                      builder: (context) => DatePick(
                          initialSelectedDate: ctl.selectDate,
                          onCertain: (v) {
                            ctl.selectDate = v;
                            ctl.update(['selectDate']);
                          }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        pText("单据时间", ColorConfig.color_333333, 28.w, width: 140.w, alignment: Alignment.centerLeft),
                        GetBuilder<RemitController>(
                            id: "selectDate",
                            builder: (ctl) {
                              return pText(
                                ctl.selectDate == null ? "请选择单据时间" : ctl.selectDate.toString().substring(0, 10),
                                ColorConfig.color_999999,
                                28.w,
                              );
                            })
                      ],
                    ),
                    pImage("images/icon_goto.png", 20.w, 20.w)
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  showDialog(
                      context: Get.context as BuildContext,
                      barrierDismissible: false,
                      builder: (_) {
                        return CustomDialog(
                          title: '备注',
                          type: 0,
                          confirmCallback: (value) {
                            //直接添加单据 备注
                            ctl.remark.value = value;
                          },
                        );
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        pText("备注", ColorConfig.color_333333, 28.w, width: 140.w, alignment: Alignment.centerLeft),
                        Obx(() => pText(ctl.remark.value == '' ? "请输入" : ctl.remark.value, ColorConfig.color_999999, 28.w,
                            width: 450.w, alignment: Alignment.centerLeft))
                      ],
                    ),
                    pImage("images/icon_goto.png", 20.w, 20.w)
                  ],
                ),
              )
            ],
          ),
        ));
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/remit/controller/remit_controller.dart';
import 'package:haidai_flutter_module/page/remit/widget/select_sale.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/dashed_line.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget orderCheck() {
  return GetBuilder<RemitController>(
      id: "orderCheck",
      builder: (ctl) {
        return Visibility(
            visible: !ctl.isRefund.value,
            child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.w),
                padding: EdgeInsets.only(bottom: 24.w),
                decoration: BoxDecoration(
                    color: Color(ColorConfig.color_ffffff),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20.w), topLeft: Radius.circular(20.w))),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(ColorConfig.color_efefef), width: 1.w))),
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 34.w, bottom: 34.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          pText("核销", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                          Obx(
                            () => pText("选择核销模式${ctl.curMode.value != 2 ? '自动' : '手动'}核销", ColorConfig.color_999999, 24.w),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 34.w, bottom: 34.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => pText("核销金额（收款后账户余额￥${ctl.afterRemitBalance.value}）", ColorConfig.color_333333, 24.w)),
                          pSizeBoxH(12.w),
                          Obx(() => pText("${ctl.checkAmount.value}", ColorConfig.color_FA6400, 64.w, fontWeight: FontWeight.w600)),
                          pSizeBoxH(35.w),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              ctl.focusNode.unfocus();
                              showCupertinoModalBottomSheet(
                                  context: Get.context as BuildContext, animationCurve: Curves.easeIn, builder: (context) => selectMode());
                            },
                            child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 18.w, bottom: 18.w),
                                decoration:
                                    BoxDecoration(color: Color(ColorConfig.color_ffefef), borderRadius: BorderRadius.all(Radius.circular(20.w))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() {
                                      String text = "";

                                      if (ctl.selfFirst.value) {
                                        text += "优先核销本单，";
                                      }
                                      if (ctl.curMode.value == 0) {
                                        if (ctl.curSaleOrderId != -1) {
                                          text += "超过时间从最早时间订单开始核销";
                                        } else {
                                          text += "最早时间订单开始核销";
                                        }
                                      }
                                      if (ctl.curMode.value == 1) {
                                        if (ctl.curSaleOrderId != -1) {
                                          text += "超过时间从最近时间订单开始核销";
                                        } else {
                                          text += "最近时间订单开始核销";
                                        }
                                      }
                                      if (ctl.curMode.value == 2) {
                                        text += "手动选择";
                                      }
                                      return pText(text, ColorConfig.color_ffa0a0, 24.w);
                                    }),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(ColorConfig.color_ffa0a0),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    DashedLine(
                      axis: Axis.horizontal,
                      count: 30,
                      dashedWidth: 10.w,
                      dashedHeight: 1.w,
                      color: Color(ColorConfig.color_dcdcdc),
                    )
                  ],
                )));
      });
}

Widget selectMode() {
  return GetBuilder<RemitController>(
      id: "order_check",
      builder: (ctl) {
        var oldSelfFirst = true.obs;
        oldSelfFirst.value = ctl.selfFirst.value;
        var oldMode = 0.obs;
        oldMode.value = ctl.curMode.value;

        return BottomSheetWidget(
            title: "核销模式",
            height: 1280.w,
            onCertain: () {
              if (oldMode.value == ctl.curMode.value && oldSelfFirst.value == ctl.selfFirst.value) {
                //如果模式未改变，则不进行操作
                return;
              }
              ctl.curMode.value = oldMode.value;
              ctl.selfFirst.value = oldSelfFirst.value;
              ctl.onModeChange();
              if (ctl.curMode.value == 2) {
                //弹出手动选择框
                Future.delayed(Duration(milliseconds: 200)).then((value) {
                  showCupertinoModalBottomSheet(
                      context: Get.context as BuildContext, animationCurve: Curves.easeIn, builder: (context) => selectOrderList());
                });
              }
            },
            child: Container(
                padding: EdgeInsets.only(top: 20.w, left: 24.w, right: 24.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        pText("选择模式", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                        GestureDetector(
                          onTap: () {
                            oldSelfFirst.toggle();
                          },
                          child: Obx(() => Visibility(
                              visible: ctl.curSaleOrderId != -1,
                              child: Row(
                                children: [
                                  pImage(oldSelfFirst.value ? 'images/checked.png' : 'images/unChecked.png', 38.w, 38.w),
                                  pSizeBoxW(10),
                                  pText("优先本单", ColorConfig.color_666666, 28.w)
                                ],
                              ))),
                        )
                      ],
                    ),
                    Obx(() => pText("从最早时间订单开始核销（自动）", oldMode.value == 0 ? ColorConfig.color_1678ff : ColorConfig.color_666666, 32.w,
                            background: oldMode.value == 0 ? ColorConfig.color_E8F2FF : ColorConfig.color_f5f5f5,
                            fontWeight: oldMode.value == 0 ? FontWeight.w600 : FontWeight.w400,
                            width: double.infinity,
                            height: 76.w,
                            radius: 10.w, onTap: () {
                          oldMode.value = 0;
                        }, margin: EdgeInsets.only(top: 30.w))),
                    Obx(() => pText("从最近时间订单开始核销（自动）", oldMode.value == 1 ? ColorConfig.color_1678ff : ColorConfig.color_666666, 32.w,
                            background: oldMode.value == 1 ? ColorConfig.color_E8F2FF : ColorConfig.color_f5f5f5,
                            fontWeight: oldMode.value == 1 ? FontWeight.w600 : FontWeight.w400,
                            width: double.infinity,
                            height: 76.w,
                            radius: 10.w, onTap: () {
                          oldMode.value = 1;
                        }, margin: EdgeInsets.only(top: 30.w))),
                    Obx(() => pText("手动选择", oldMode.value == 2 ? ColorConfig.color_1678ff : ColorConfig.color_666666, 32.w,
                            background: oldMode.value == 2 ? ColorConfig.color_E8F2FF : ColorConfig.color_f5f5f5,
                            fontWeight: oldMode.value == 2 ? FontWeight.w600 : FontWeight.w400,
                            width: double.infinity,
                            height: 76.w,
                            radius: 10.w, onTap: () {
                          oldMode.value = 2;
                        }, margin: EdgeInsets.only(top: 30.w))),
                  ],
                )));
      });
}

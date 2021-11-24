import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/verification/model/order_sale_item_entity.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_select_order_list.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../verification_logic.dart';

Widget verificationList() {
  return GetBuilder<VerificationLogic>(
      id: "sixth",
      builder: (ctl) {
        if (ctl.verificationMode == 'CONFIG_NUCLEAR_3_5' ||
            ctl.verificationMode == 'CONFIG_NUCLEAR_1_2' ||
            ctl.verificationMode == 'CONFIG_NUCLEAR_1_5') {
          return SliverVisibility(
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((content, index) {
                  if (index == ctl.showOrderSaleList.length) {
                    return Container(
                        height: 144.w,
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: pActionText('+ 手动选择结欠单',
                            ColorConfig.color_333333, 24.w, 72.w, 284.w, () {
                          ctl.remainingWrittenOffAmount =
                              ctl.afterBalance() * 100;

                          showCupertinoModalBottomSheet(
                              context: Get.context!,
                              animationCurve: Curves.easeIn,
                              builder: (context) => BottomSheetWidget(
                                  title: '选择销售单',
                                  child: selectOrderList(),
                                  onCertain: () {
                                    ctl.selectSaleOrderConfirm();
                                  }));
                        }, radius: 5.w));
                  } else {
                    OrderSaleItemEntity entity = ctl.showOrderSaleList[index];

                    return Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 20.w, right: 20.w),
                        height: 120.w,
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  currentBill(ctl, entity),
                                  pText(
                                      " 核销¥ ${(entity.writeOffAmount / 100)} ",
                                      ColorConfig.color_999999,
                                      26.w),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              Row(
                                children: [
                                  pText(" ${entity.customizeTime}",
                                      ColorConfig.color_999999, 26.w),
                                  pText(
                                      " 结欠¥ ${(entity.balanceAmount ?? 0.0) / 100} ",
                                      ColorConfig.color_999999,
                                      26.w),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ],
                          ),
                        ));
                  }
                }, childCount: ctl.showOrderSaleList.length + 1),
              ),
              visible: ctl.groupValue == 1 ? true : false);
        } else {
          return SliverVisibility(
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((content, index) {
                  OrderSaleItemEntity entity = ctl.showOrderSaleList[index];

                  return Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20.w, right: 20.w),
                      height: 120.w,
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                currentBill(ctl, entity),
                                pText(" 核销¥ ${(entity.writeOffAmount / 100)} ",
                                    ColorConfig.color_999999, 26.w),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            Row(
                              children: [
                                pText(" ${entity.customizeTime}",
                                    ColorConfig.color_999999, 26.w),
                                pText(
                                    " 结欠¥ ${(entity.balanceAmount ?? 0.0) / 100} ",
                                    ColorConfig.color_999999,
                                    26.w),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ],
                        ),
                      ));
                }, childCount: ctl.showOrderSaleList.length),
              ),
              visible: ctl.groupValue == 1 ? true : false);
        }
      });
}

// 是否为本单的部件
Widget currentBill(VerificationLogic ctl, OrderSaleItemEntity entity) {
  if (ctl.orderSaleId == entity.id) {
    return pText(
        " (本单)销售单${entity.orderSaleSerial}", ColorConfig.color_999999, 26.w);
  } else {
    return pText(
        " 销售单${entity.orderSaleSerial}", ColorConfig.color_999999, 26.w);
  }
}

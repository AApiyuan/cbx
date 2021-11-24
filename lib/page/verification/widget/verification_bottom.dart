import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../verification_logic.dart';


Widget verificationBottom (){
  return GetBuilder<VerificationLogic>(
      id: "bottom",
      builder: (ctl) {
        if (ctl.groupValue == 1) {
          if (ctl.orderSaleId > 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    height: 100.w,
                    width: 550.w,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        pText(
                            " 核销本单¥${ctl.writeOffOrderAmount()} ｜ 核销他单¥${ctl.writeOffBillAmount()}",
                            ColorConfig.color_333333,
                            28.w),
                        pText(
                            " 本单剩余应收 ¥${ctl.getOrderSurplusReceivable() / 100}",
                            ColorConfig.color_333333,
                            28.w,
                            textAlign: TextAlign.left),
                      ],
                    )),
                Container(
                    height: 100.w,
                    width: 200.w,
                    color: Color(ColorConfig.color_1678ff),
                    child: GestureDetector(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          pText(
                              "¥${ctl.paidUpAmountDisplayed()}",
                              ColorConfig.color_ffffff,
                              24.w),
                          pText("完成收款",
                              ColorConfig.color_ffffff, 28.w),
                        ],
                      ),
                      onTap: () {
                        // print('完成退款-点击1');
                        ctl.paymentConfirm();
                        // print('完成退款-点击2');
                      },
                    )),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    height: 100.w,
                    width: 550.w,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        pText(
                            " 实收金额 ¥${ctl.paidUpAmountDisplayed()}",
                            ColorConfig.color_333333,
                            28.w),
                        pText(
                            " 核销金额 ¥${ctl.getVerification() / 100}",
                            ColorConfig.color_333333,
                            28.w,
                            textAlign: TextAlign.left),
                      ],
                    )),
                Container(
                    height: 100.w,
                    width: 200.w,
                    color: Color(ColorConfig.color_1678ff),
                    child: GestureDetector(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          pText(
                              "¥${ctl.paidUpAmountDisplayed()}",
                              ColorConfig.color_ffffff,
                              24.w),
                          pText("完成收款",
                              ColorConfig.color_ffffff, 28.w),
                        ],
                      ),
                      onTap: () {
                        // print('完成退款-点击1');
                        ctl.paymentConfirm();
                        // print('完成退款-点击2');
                      },
                    )),
              ],
            );
          }
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  height: 100.w,
                  width: 600.w,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          pText(" 实退金额 ",
                              ColorConfig.color_333333, 28.w),
                          pText(
                              "-¥${ctl.refundAmountDisplayed()}",
                              ColorConfig.color_333333,
                              28.w),
                        ],
                      )
                    ],
                  )),
              Container(
                  height: 100.w,
                  width: 150.w,
                  color: Color(ColorConfig.color_1678ff),
                  child: GestureDetector(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        pText("¥${ctl.refundAmountDisplayed()}",
                            ColorConfig.color_ffffff, 24.w),
                        pText("完成退款", ColorConfig.color_ffffff,
                            28.w),
                      ],
                    ),
                    onTap: () {
                      print('完成退款-点击1');
                      ctl.refundConfirm();
                      print('完成退款-点击2');
                    },
                  )),
            ],
          );
        }
      });
}


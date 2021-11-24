import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/remit/controller/remit_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget confirm() {
  return GetBuilder<RemitController>(
      id: "remitConfirm",
      builder: (ctl) {
        if (ctl.isRefund.value) {
          return refund();
        } else {
          //收款
          if (ctl.curSaleOrderId == -1) {
            //纯收款
            return remit();
          } else {
            return remitWithOrder();
          }
        }
      });
}

Widget remitWithOrder() {
  return GetBuilder<RemitController>(builder: (ctl) {
    return Container(
      height: 112.w,
      width: double.infinity,
      color: Color(ColorConfig.color_ffffff),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 24.w, top: 12.w, bottom: 12.w),
            width: 520.w,
            child:SingleChildScrollView(scrollDirection: Axis.horizontal, reverse: true, child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    pText("核销本单 ", ColorConfig.color_333333, 28.w),
                    pText("￥${ctl.checkSelfAmount.value}", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                    pText("| ", ColorConfig.color_efefef, 28.w, width: 40.w),
                    pText("核销他单 ", ColorConfig.color_333333, 28.w),
                    pText("￥${ctl.checkOtherAmount.value} ", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                  ],
                ),
                Row(
                  children: [
                    pText("剩余本单应收 ", ColorConfig.color_333333, 28.w),
                    pText("￥${NumUtil.subtract(ctl.amount.toDouble() / 100, ctl.checkSelfAmount.value)} ", ColorConfig.color_ff3715, 28.w,
                        fontWeight: FontWeight.w600),
                  ],
                )
              ],
            )),
          ),
          GestureDetector(
            onTap: () {
              submit(ctl);
            },
            child: Container(
              width: 194.w,
              padding: EdgeInsets.only(top: 13.w, bottom: 13.w),
              color: Color(ColorConfig.color_1678ff),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pText("￥${ctl.remitAmount.value}", ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.w600),
                  pText("完成收款 ", ColorConfig.color_ffffff, 28.w),
                ],
              ),
            ),
          )
        ],
      ),
    );
  });
}

Widget remit() {
  return GetBuilder<RemitController>(builder: (ctl) {
    return Container(
      height: 112.w,
      width: double.infinity,
      color: Color(ColorConfig.color_ffffff),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 24.w, top: 12.w, bottom: 12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    pText("核销金额 ", ColorConfig.color_333333, 28.w),
                    pText("￥${ctl.checkAmount.value} ", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                  ],
                ),
                Row(
                  children: [
                    pText("实收金额 ", ColorConfig.color_333333, 28.w),
                    pText("￥${ctl.remitAmount.value}  ", ColorConfig.color_ff3715, 28.w, fontWeight: FontWeight.w600),
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                submit(ctl);
              },
              child: Container(
                width: 194.w,
                padding: EdgeInsets.only(top: 13.w, bottom: 13.w),
                color: Color(ColorConfig.color_1678ff),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pText("￥${ctl.remitAmount.value}", ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.w600),
                    pText("完成收款 ", ColorConfig.color_ffffff, 28.w),
                  ],
                ),
              ))
        ],
      ),
    );
  });
}

Widget refund() {
  return GetBuilder<RemitController>(builder: (ctl) {
    return Container(
      height: 112.w,
      width: double.infinity,
      color: Color(ColorConfig.color_ffffff),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 24.w, top: 12.w, bottom: 12.w),
            child: Row(
              children: [
                pText("本单实退 ", ColorConfig.color_333333, 28.w),
                pText("￥${ctl.refundAmount.value}", ColorConfig.color_ff3715, 28.w, fontWeight: FontWeight.w600),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {
                submit(ctl);
              },
              child: Container(
                width: 194.w,
                padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
                color: Color(ColorConfig.color_1678ff),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pText("￥${ctl.refundAmount.value}", ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.w600),
                    pText("完成退款 ", ColorConfig.color_ffffff, 28.w),
                  ],
                ),
              ))
        ],
      ),
    );
  });
}

submit(RemitController ctl) {
  if (ctl.isRefund.value) {
    if (ctl.refundAmount.value == 0) {
      toastMsg("未录入退款金额 ");
      return;
    }
    if (ctl.refundAmount.value > ctl.customer!.balance!.toDouble() / 100) {
      toastMsg("余额不足 ");
      return;
    }
  } else {
    if (ctl.remitAmount.value == 0 && ctl.checkAmount.value == 0) {
      toastMsg("未录入收款或核销金额 ");
      return;
    }
  }
  if (ctl.remitMethods.length == 0 && ctl.refundAmount.value != 0) {
    toastMsg("请添加收退款方式后操作 ");
    return;
  }
  showDialog(
      context: Get.context as BuildContext,
      builder: (_) {
        return CustomDialog(
          type: 1,
          confirmTextColor: ColorConfig.color_1678ff,
          content: pText("确定${ctl.isRefund.value ? '退' : '收'}款吗？", ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w600),
          confirmCallback: (value) {
            ctl.confirm();
          },
        );
      });
}

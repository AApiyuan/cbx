import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/distribution/controller/confirm_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget deptTitle() {
  return GetBuilder<ConfirmController>(builder: (ctl) {
    return Container(
      height: 100.w,
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(ColorConfig.color_f5f5f5), width: 18.w))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                GetBuilder<ConfirmController>(
                    id: "orderDept",
                    builder: (ctl) {
                      return Container(
                        width: 370.w,
                        alignment: Alignment.centerLeft,
                        child: pText("对方店/仓：" + ctl.otherDeptName, ColorConfig.color_333333, 28.w),
                      );
                    }),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 140.w,
                alignment: Alignment.centerRight,
                child: pText(ctl.orderTransfer!.storeCustomer!.customerName ?? "", ColorConfig.color_333333, 28.w),
              ),
              pSizeBoxW(2.w),
              pText("#" + int.parse(ctl.orderTransfer!.orderSaleSerial!.substring(ctl.orderTransfer!.orderSaleSerial!.length - 3)).toString(),
                  ColorConfig.color_333333, 28.w),
              pSizeBoxW(8.w),
              pText(ctl.orderTransfer!.orderSaleCustomizeTime!.substring(5, 10), ColorConfig.color_333333, 28.w)
            ],
          )
        ],
      ),
    );
  });
}

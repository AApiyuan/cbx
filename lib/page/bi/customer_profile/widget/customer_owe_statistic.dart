import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/bi/customer_profile/controller/customer_profile_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget customerOweStatistic() {
  return GetBuilder<CustomerProfileController>(builder: (ctl) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20.w),
        padding: EdgeInsets.fromLTRB(30.w, 40.w, 30.w, 40.w),
        decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
        child: Column(children: [
          GetBuilder<CustomerProfileController>(
              id: "customerOweStatistic",
              builder: (ctl) {
                return Container(
                    child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pText("欠款", 0xb3ffffff, 24.w),
                          pSizeBoxH(10.w),
                          pText('${ctl.customerInfo != null ? PriceUtils.getPrice(ctl.customerInfo!.oweAmount).toString() : "--"}',
                              ColorConfig.color_ffffff, 36.w),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                pText("欠货", 0xb3ffffff, 24.w),
                                pSizeBoxH(10.w),
                                pText('${ctl.customerInfo != null ? ctl.customerInfo!.oweNum.toString() : "--"}',
                                    ColorConfig.color_ffffff, 36.w),
                              ],
                            ),
                          ],
                        ))
                  ],
                ));
              }),
          pSizeBoxH(36.w),
          GetBuilder<CustomerProfileController>(
              id: "customerCustomer",
              builder: (ctl) {
                return Container(
                  child: Row(
                    children: [
                      pText("账户余额", 0xb3ffffff, 24.w),
                      pText("${ctl.customerInfo != null?PriceUtils.getPrice(ctl.customerInfo!.balance).toString():'--'} ", ColorConfig.color_ffffff, 24.w,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                );
              })
        ]));
  });
}

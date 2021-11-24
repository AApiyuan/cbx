import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/controller/dept_user_profile_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget deptUserOweStatistic() {
  return GetBuilder<DeptUserProfileController>(builder: (ctl) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20.w),
        padding: EdgeInsets.fromLTRB(30.w, 40.w, 30.w, 40.w),
        decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
        child: Column(children: [
          GetBuilder<DeptUserProfileController>(
              id: "deptUserOweStatistic",
              builder: (ctl) {
                return Container(
                    child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pText("跟单欠款", 0xb3ffffff, 24.w),
                          pSizeBoxH(10.w),
                          pText('${ctl.biCustomerTotalDo != null ? PriceUtils.getPrice(ctl.biCustomerTotalDo!.orderOweAmount).toString() : "--"}',
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
                                pText("跟单欠货", 0xb3ffffff, 24.w),
                                pSizeBoxH(10.w),
                                pText('${ctl.biCustomerTotalDo != null ? ctl.biCustomerTotalDo!.shortageNum.toString() : "--"}',
                                    ColorConfig.color_ffffff, 36.w),
                              ],
                            ),
                          ],
                        ))
                  ],
                ));
              }),
          pSizeBoxH(36.w),
          GetBuilder<DeptUserProfileController>(
              id: "deptUserCustomer",
              builder: (ctl) {
                return Container(
                  child: Row(
                    children: [
                      pText("跟进客户数 ${ctl.customerNum != null ? ctl.customerNum : '--'}   本月 ", 0xb3ffffff, 24.w),
                      pText("+${ctl.newCustomerNum != null ? ctl.newCustomerNum : '--'} ", ColorConfig.color_ffffff, 24.w,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                );
              })
        ]));
  });
}

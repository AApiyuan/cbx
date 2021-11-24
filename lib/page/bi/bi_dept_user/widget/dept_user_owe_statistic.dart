import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/controller/bi_dept_user_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget deptUserOweStatistic() {
  return GetBuilder<BiDeptUserController>(
      id: "deptUserOweStatistic",
      builder: (ctl) {
        return Column(children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20.w),
              padding: EdgeInsets.fromLTRB(30.w, 40.w, 30.w, 40.w),
              decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pText("跟单客户欠货", 0xb3ffffff, 24.w),
                        pSizeBoxH(10.w),
                        pText(ctl.biCustomerTotalDo != null ? ctl.biCustomerTotalDo!.shortageNum.toString() : "--", ColorConfig.color_ffffff, 36.w),
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
                              pText("跟单客户欠货金额", 0xb3ffffff, 24.w),
                              pSizeBoxH(10.w),
                              pText('${ctl.biCustomerTotalDo != null ? PriceUtils.getPrice(ctl.biCustomerTotalDo!.shortageAmount).toString() : "--"}',
                                  ColorConfig.color_ffffff, 36.w),
                            ],
                          ),
                        ],
                      ))
                ],
              )),
          pSizeBoxH(20.w),
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20.w),
              padding: EdgeInsets.fromLTRB(30.w, 40.w, 30.w, 40.w),
              decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pText("跟单客户结欠", 0xb3ffffff, 24.w),
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
                              pText("跟单客户余额", 0xb3ffffff, 24.w),
                              pSizeBoxH(10.w),
                              pText('${ctl.biCustomerTotalDo != null ? PriceUtils.getPrice(ctl.biCustomerTotalDo!.balance).toString() : "--"}',
                                  ColorConfig.color_ffffff, 36.w),
                            ],
                          ),
                        ],
                      ))
                ],
              ))
        ]);
      });
}

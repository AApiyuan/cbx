import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit_record/widget/remit_record_list.dart';
import 'package:haidai_flutter_module/page/bi/customer_profile/controller/customer_profile_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget customerInfo() {
  return GetBuilder<CustomerProfileController>(
      id: "customerInfo",
      builder: (ctl) {
        return Container(
          width: double.infinity,
          child: Row(
            children: [
              customerLogo(
                  ctl.customerInfo != null ? ctl.customerInfo!.customerName : "", ctl.customerInfo != null ? ctl.customerInfo!.levelTag : 'A',
                  backgroundColor: ColorConfig.color_646582, borderColor: ColorConfig.color_ffffff, margin: EdgeInsets.only(right: 12.w, left: 44.w)),
              pSizeBoxW(12.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pText("${ctl.customerInfo != null ? ctl.customerInfo!.customerName.toString() : '--'}", ColorConfig.color_ffffff, 32.w),
                  pSizeBoxH(22.w),
                  pText(
                      "${ctl.customerInfo != null ? ctl.customerInfo!.customerPhone == null ? '' : ctl.customerInfo!.customerPhone.toString() : '--'}",
                      0xb3ffffff,
                      24.w),
                ],
              )
            ],
          ),
        );
      });
}

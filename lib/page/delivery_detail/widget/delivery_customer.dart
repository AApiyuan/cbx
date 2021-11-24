import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/remark_order_type.dart';
import 'package:haidai_flutter_module/model/remark.dart';
import 'package:haidai_flutter_module/page/customer/widget/customer_widget.dart';
import 'package:haidai_flutter_module/page/delivery_detail/controller/delivery_detail_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/sale_detail/controller/sale_detail_controller.dart';
import 'package:haidai_flutter_module/repository/order/remark_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget DeliveryCustomer() {
  return GetBuilder<DeliveryDetailController>(builder: (ctl) {
    var customer = ctl.saleOrder!.customer;
    var name = customer?.customerName;
    if ((customer?.customerName?.length ?? 0) > 6) {
      name = "${customer?.customerName?.substring(0, 5)}...";
    }
    return Container(
      padding: EdgeInsets.fromLTRB(0.w, 25.w, 24.w, 10.w),
      decoration: BoxDecoration(border: Border(top: BorderSide(width: 1.w, color: Color(ColorConfig.color_f5f5f5)))),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  customerLogo(customer?.customerName, customer?.levelTag),
                  pSizeBoxW(12.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pText(name ?? "", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                      pSizeBoxH(12.w),
                      pText("欠款 ${PriceUtils.getPrice(customer!.oweAmount)}", ColorConfig.color_999999, 24.w),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  });
}

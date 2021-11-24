import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/customer_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/direct_deliver/controller/direct_deliver_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget customerInfo() {
  return GetBuilder<DirectDeliverController>(
    builder: (ctl) => Row(
      children: [
        _customerLogo(ctl.customer?.customerName, ctl.customer?.levelTag),
        pSizeBoxW(16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customerNamePhone(ctl.customer?.customerName, ctl.customer?.customerPhone),
            pSizeBoxH(25.w),
            _customerBalance(ctl.customer),
          ],
        ),
      ],
    ),
    id: DirectDeliverController.idCustomer,
  );
}

Widget _customerBalance(StoreCustomerListItemDoEntity? customer) {
  return Row(
    children: [
      pText("余额${PriceUtils.getPrice(customer?.balance)}", ColorConfig.color_999999, 24.w),
      pSizeBoxW(35.w),
      pText("结欠${PriceUtils.getPrice(customer?.oweAmount)}", ColorConfig.color_999999, 24.w),
      pSizeBoxW(35.w),
      pText("总欠货${customer?.oweNum ?? 0}", ColorConfig.color_999999, 24.w),
    ],
  );
}

Widget _customerNamePhone(String? name, String? phone) {
  return Row(
    children: [
      pText(name ?? "", ColorConfig.color_333333, 32.w, width: 300.w, alignment: Alignment.centerLeft),
      pSizeBoxW(24.w),
      pText(CustomerUtils.encodePhone(phone), ColorConfig.color_999999, 28.w),
    ],
  );
}

Widget _customerLogo(String? customerName, String? levelTag) {
  var name = ((customerName?.length ?? 0) > 2
          ? customerName?.substring(customerName.length - 2)
          : customerName) ??
      "";
  var tagColor;
  switch (levelTag ?? "A") {
    case "B":
      tagColor = ColorConfig.color_FFBA17;
      break;
    case "A":
      tagColor = ColorConfig.color_FFA523;
      break;
    case "C":
      tagColor = ColorConfig.color_FFDA17;
      break;
  }
  return Stack(
    children: [
      Container(
        width: 90.w,
        height: 90.w,
        margin: EdgeInsets.only(top: 30.w, bottom: 30.w, left: 46.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(ColorConfig.color_646582),
          borderRadius: BorderRadius.all(Radius.circular(46.w)),
        ),
        child: pText(
          name,
          ColorConfig.color_ffffff,
          28.w,
          fontWeight: FontWeight.bold,
        ),
      ),
      Positioned(
        child: Container(
          width: 28.w,
          height: 28.w,
          margin: EdgeInsets.only(bottom: 30.w),
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            color: Color(tagColor),
            shape: CircleBorder(),
          ),
          child: pText(
            levelTag ?? "A",
            ColorConfig.color_ffffff,
            18.w,
            fontWeight: FontWeight.bold,
          ),
        ),
        right: 0,
        bottom: 0,
      )
    ],
  );
}

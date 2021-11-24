import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/model/enum/star.dart';
import 'package:haidai_flutter_module/page/customer/controller/search_customer_controller.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customerWidget(StoreCustomerListItemDoEntity customer, Function onTap) {
  return InkWell(
    child: Row(
      children: [
        Expanded(
          child: customerInfo(customer),
          flex: 15,
        ),
        Expanded(
          child: oweText(SearchCustomerController.idFilterOwe, customer.oweAmount),
          flex: 5,
        ),
        Expanded(
          child: oweText(SearchCustomerController.idFilterOweGoods, customer.oweNum),
          flex: 5,
        ),
        pSizeBoxW(24.w),
      ],
    ),
    onTap: () => onTap.call(),
  );
}

Widget customerInfo(StoreCustomerListItemDoEntity customer) {
  var phone = (customer.customerPhone?.length ?? 0) == 0 ? "--" : customer.customerPhone!;
  var name = (customer.customerName ?? "").length > 8 ? "${customer.customerName!.substring(0, 8)}..." : (customer.customerName ?? "");
  return Row(
    children: [
      customerLogo(customer.customerName, customer.levelTag),
      pSizeBoxW(16.w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              pText(name, ColorConfig.color_333333, 32.w),
              pSizeBoxW(8.w),
              Visibility(
                child: pImage("images/ic_star.png", 28.w, 28.w),
                visible: customer.star == Star.STAR,
              ),
            ],
          ),
          pSizeBoxH(20.w),
          pText(phone, ColorConfig.color_999999, 28.w, width: 200.w, alignment: Alignment.centerLeft),
        ],
      )
    ],
  );
}

Widget customerLogo(String? customerName, String? levelTag, {Function? onTap, int? backgroundColor, int? borderColor, EdgeInsetsGeometry? margin}) {
  var name = ((customerName?.length ?? 0) > 2 ? customerName?.substring(customerName.length - 2) : customerName) ?? "";
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
  return GestureDetector(
    child: Stack(
      children: [
        Container(
            width: 92.w,
            height: 92.w,
            margin: margin ?? EdgeInsets.only(top: 16.w, bottom: 16.w, left: 24.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Color(borderColor ?? ColorConfig.color_282940), borderRadius: BorderRadius.all(Radius.circular(46.w))),
            child: Container(
              width: 90.w,
              height: 90.w,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(color: Color(backgroundColor ?? ColorConfig.color_282940), borderRadius: BorderRadius.all(Radius.circular(45.w))),
              child: pText(name, ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.bold),
            )),
        Positioned(
          child: Container(
            width: 28.w,
            height: 28.w,
            margin: EdgeInsets.only(bottom: 16.w),
            alignment: Alignment.center,
            decoration: ShapeDecoration(color: Color(tagColor), shape: CircleBorder()),
            child: pText(levelTag ?? "A", ColorConfig.color_ffffff, 18.w, fontWeight: FontWeight.bold),
          ),
          right: 0.w,
          bottom: 0.w,
        )
      ],
    ),
    onTap: () => onTap?.call(),
  );
}

Widget oweText(String id, int? owe) {
  return GetBuilder<SearchCustomerController>(
    builder: (ctl) {
      if (!ctl.online) {
        return Container();
      }
      var filterColor = id == SearchCustomerController.idFilterOweGoods ? ColorConfig.color_FF861E : ColorConfig.color_FF765F;
      var bgColor = ctl.isCurrFilter(id) ? filterColor : ColorConfig.color_ffffff;
      var textColor = ctl.isCurrFilter(id) ? ColorConfig.color_ffffff : filterColor;
      var text =
          id == SearchCustomerController.idFilterOweGoods ? "${owe == null ? "--" : owe}" : "${PriceUtils.priceString(owe, def: "--", zero: "--")}";
      return Container(
        alignment: Alignment.center,
        width: 132.w,
        margin: EdgeInsets.only(top: 16.w, bottom: 16.w),
        height: 52.w,
        decoration: ShapeDecoration(
          color: Color(bgColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.w),
          ),
        ),
        child: pText(text, textColor, 28.w, fontWeight: FontWeight.bold),
      );
    },
  );
}

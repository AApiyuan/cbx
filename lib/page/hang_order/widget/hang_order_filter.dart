import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/hang_order/controller/hang_order_controller.dart';
import 'package:haidai_flutter_module/page/sale/controller/offline_gathering_controller.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/drawer_dialog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget orderTypeContent(DrawerDialog dialog) {
  var function = () => dialog.dismiss();
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _orderTypeItem("全部", HangOrderController.filterAll, function),
        _orderTypeItem("断网单", SaleEnterController.TYPE_OFFLINE_SALE, function),
        _orderTypeItem("销售单挂单", SaleEnterController.TYPE_SALE, function),
        _orderTypeItem("报价单", SaleEnterController.TYPE_QUOTATION, function),
        _orderTypeItem("收款单", OfflineGatheringController.TYPE_OFFLINE_GATHERING, function),
      ],
    ),
    color: Colors.white,
  );
}

Widget _orderTypeItem(String text, int type, Function function) {
  return GetBuilder<HangOrderController>(
    builder: (ctl) {
      var count = ctl.getOrderTypeCount(type);
      var select = ctl.isSelectOrderType(type);
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: EdgeInsets.only(left: 30.w),
          height: 92.w,
          alignment: Alignment.centerLeft,
          child: pText(
            "$text${count == 0 ? "" : " $count单"}",
            select ? ColorConfig.color_1678FF : ColorConfig.color_333333,
            28.w,
            fontWeight: select ? FontWeight.bold : FontWeight.w400,
          ),
        ),
        onTap: () {
          ctl.updateSelectOrderType(type);
          function.call();
        },
      );
    },
    id: HangOrderController.idFilterOrderType(type),
  );
}

Widget customerContent(DrawerDialog dialog) {
  return Container(
    color: Colors.white,
    height: 92.w * 8,
    child: GetBuilder<HangOrderController>(
      builder: (ctl) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (_, index) =>
              customerItem(ctl, index, () => dialog.dismiss()),
          itemCount: ctl.filterCustomer.length,
        );
      },
    ),
  );
}

customerItem(HangOrderController ctl, int index, Function function) {
  var customer = ctl.filterCustomer[index];
  var select = ctl.isSelectCustomer(customer.customer?.id);
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    child: Container(
      margin: EdgeInsets.only(left: 30.w),
      height: 92.w,
      alignment: Alignment.centerLeft,
      child: pText(
        "${customer.customer?.customerName} ${customer.count}单",
        select ? ColorConfig.color_1678FF : ColorConfig.color_333333,
        28.w,
        fontWeight: select ? FontWeight.bold : FontWeight.w400,
      ),
    ),
    onTap: () {
      ctl.updateSelectCustomer(customer.customer!.id!);
      function.call();
    },
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleBeforeReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleReq.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_relation_do.dart';
import 'package:haidai_flutter_module/page/sale/widget/order_detail_widget.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class OrderDetailDialog extends StatelessWidget {
  var title;
  var orderItemList;
  var customer;
  var bottomWidget;
  CreateSaleReq? saleReq;
  CreateSaleBeforeReq? saleBeforeReq;
  Function? dismissFunction;
  Function? updateFunction;
  List<CustomerDeptRelationDo>? warehouseList;
  var type;
  var edit;
  var checkAmount;

  OrderDetailDialog(this.title, this.orderItemList, this.saleReq,
      this.saleBeforeReq, this.type,
      {this.customer,
      this.bottomWidget,
      this.dismissFunction,
      this.updateFunction,
      this.warehouseList,
      this.checkAmount,
      this.edit = false,
      var key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        // margin: EdgeInsets.only(top: 150.w),
        child: Column(
          children: [
            // titleBar(),
            Expanded(
              child: OrderDetail(
                orderItemList,
                saleReq,
                saleBeforeReq,
                type,
                customer: customer,
                edit: edit,
                checkAmount: checkAmount,
                warehouseList: warehouseList,
                updateFunction: () => updateFunction?.call(),
              ),
            ),
            bottomWidget ?? Container(height: 0),
          ],
        ),
        color: Colors.white,
      ),
      onWillPop: () async => back(),
    );
  }

  titleBar() {
    return Stack(
      children: [
        Expanded(
          child: Container(
            height: 108.w,
            alignment: Alignment.center,
            child: pText(title, ColorConfig.color_333333, 36.w,
                fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          right: 30.w,
          top: 24.w,
          child: InkWell(
            child: pImage("images/icon_dialog_close.png", 60.w, 60.w),
            onTap: () => back(),
          ),
        ),
      ],
    );
  }

  back() {
    dismissFunction?.call();
    Get.back();
    return true;
  }
}

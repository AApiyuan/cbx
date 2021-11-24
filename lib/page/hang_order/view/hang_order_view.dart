import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/db/sql_db.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/common_utils.dart';
import 'package:haidai_flutter_module/common/utils/experience_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/hang_order/controller/hang_order_controller.dart';
import 'package:haidai_flutter_module/page/hang_order/widget/hang_order_filter.dart';
import 'package:haidai_flutter_module/page/hang_order/widget/hang_order_item.dart';
import 'package:haidai_flutter_module/page/sale/controller/offline_gathering_controller.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/drawer_dialog.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

// ignore: must_be_immutable
class HangOrderView extends GetView<HangOrderController> {
  var _orderTypeKey = GlobalKey();
  var _customerKey = GlobalKey();
  var _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Color(ColorConfig.color_f5f5f5),
        appBar: pAppBar("挂单工作台", backFunc: () {
          BackUtils.backToNative();
        }, actions: [checkDownloadDb()]),
        body: Column(
          children: [
            filterWidget(),
            orderList(),
            orderTypeWidget(),
            // closeWidget(),
          ],
        ),
      ),
      onWillPop: () {
        BackUtils.backToNative();
        return new Future.value(true);
      },
    );
  }

  filterWidget() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              child: Container(
                key: _orderTypeKey,
                color: Colors.white,
                alignment: Alignment.center,
                child: pText("单据类型", ColorConfig.color_999999, 24.w),
              ),
              onTap: () => DrawerDialog((dialog) => orderTypeContent(dialog)).show(_context, _orderTypeKey),
            ),
          ),
          Expanded(
            child: InkWell(
              child: Container(
                key: _customerKey,
                color: Colors.white,
                alignment: Alignment.center,
                child: pText("客户", ColorConfig.color_999999, 24.w),
              ),
              onTap: () => DrawerDialog((dialog) => customerContent(dialog)).show(_context, _customerKey),
            ),
          ),
        ],
      ),
      height: 96.w,
    );
  }

  orderList() {
    return Expanded(
      child: GetBuilder<HangOrderController>(
        builder: (ctl) {
          if (ctl.dataList.length == 0) {
            return emptyWidget(image: "images/icon_empty_hang_order.png", text: "");
          }
          return ListView.builder(
            itemBuilder: (_, index) => listItem(index),
            itemCount: ctl.dataList.length,
          );
        },
        id: HangOrderController.idDataList,
      ),
    );
  }

  orderTypeWidget() {
    return Container(
      color: Color(ColorConfig.color_282940),
      padding: EdgeInsets.only(bottom: CommonUtils.isisAllScreenDevice() ? 35.w : 0),
      child: Row(
        children: [
          Visibility(
            child: orderTypeItem(
              "断网收款",
              "images/icon_hang_order_offline_payment.png",
              () => ExperienceUtils.checkExperience(controller.online, ExperienceUtils.TYPE_OFFLINE, controller.depId!)
                  .then((value) {
                if (value) {
                  toOfflineGatheringPage();
                }
              }),
            ),
            visible: true,
          ),
          Visibility(
            child: orderTypeItem(
              "断网开单",
              "images/icon_hang_order_offline_sale.png",
              () => ExperienceUtils.checkExperience(controller.online, ExperienceUtils.TYPE_OFFLINE, controller.depId!)
                  .then((value) {
                if (value) {
                  toEnterGoodsPage(SaleEnterController.TYPE_OFFLINE_SALE);
                }
              }),
            ),
            visible: true,
          ),
          Visibility(
            child: orderTypeItem(
              "销售单",
              "images/icon_hang_order_sale.png",
              () => toEnterGoodsPage(SaleEnterController.TYPE_SALE),
            ),
            visible: controller.online,
          ),
          Visibility(
            child: orderTypeItem(
              "收款/核销",
              "images/icon_hang_order_payment.png",
              () => Get.toNamed(
                ArgUtils.map2String(path: Routes.SEARCH_CUSTOMER, arguments: {Constant.DEPT_ID: controller.depId}),
              )?.then(
                (value) {
                  if (value != null) {
                    Get.toNamed(ArgUtils.map2String(path: Routes.SALE_REMIT, arguments: {
                      Constant.DEPT_ID: controller.depId,
                      Constant.CUSTOMER_ID: value.id,
                    }));
                  }
                },
              ),
            ),
            visible: controller.online,
          ),
          Visibility(
            child: orderTypeItem(
              "报价单",
              "images/icon_hang_order_quotation.png",
              () =>
                  ExperienceUtils.checkExperience(controller.online, ExperienceUtils.TYPE_QUOTATION, controller.depId!)
                      .then((value) {
                if (value) {
                  toEnterGoodsPage(SaleEnterController.TYPE_QUOTATION);
                }
              }),
            ),
            visible: Config.isDebug && controller.online,
          ),
        ],
      ),
    );
  }

  toEnterGoodsPage(int type, {int? orderId}) {
    Get.toNamed(ArgUtils.map2String(
      path: Routes.SALE_ENTER,
      arguments: {Constant.DEPT_ID: controller.depId, Constant.TYPE: type, Constant.ORDER_ID: orderId},
    ))?.then((value) => controller.updateSelectOrderType(HangOrderController.filterAll));
  }

  closeWidget() {
    return InkWell(
      child: Container(
        color: Colors.white,
        child: pText("取消", ColorConfig.color_333333, 28.w),
        alignment: Alignment.center,
        padding: EdgeInsets.all(25.w),
      ),
      onTap: () => BackUtils.backToNative(),
    );
  }

  orderTypeItem(String title, String image, Function function) {
    return Expanded(
      child: InkWell(
        child: Column(
          children: [
            pSizeBoxH(18.w),
            pImage(image, 78.w, 78.w),
            pSizeBoxH(14.w),
            pText(title, ColorConfig.color_ffffff, 24.w),
            pSizeBoxH(18.w),
          ],
        ),
        onTap: () => function.call(),
      ),
    );
  }

  listItem(int index) {
    var model = controller.dataList[index];
    return Column(
      children: [
        orderTime(model.updateTime!),
        InkWell(
          child: hangOrderItem(model, _context),
          onTap: () => model.type == OfflineGatheringController.TYPE_OFFLINE_GATHERING
              ? toOfflineGatheringPage(orderId: model.id!)
              : toEnterGoodsPage(model.type!, orderId: model.id),
        ),
      ],
    );
  }

  orderTime(String time) {
    return Container(
      // child: pText("更新时间：$time", ColorConfig.color_999999, 24.w),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 30.w),
      color: Color(ColorConfig.color_f5f5f5),
      height: 16.w,
    );
  }

  toOfflineGatheringPage({int? orderId}) {
    Get.toNamed(
      ArgUtils.map2String(
        path: Routes.OFFLINE_GATHERING,
        arguments: {Constant.DEPT_ID: controller.depId, Constant.ORDER_ID: orderId},
      ),
    )?.then(
      (value) => controller.updateSelectOrderType(HangOrderController.filterAll),
    );
  }

  checkDownloadDb() {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        width: 80.w,
        height: 30.w,
      ),
      onLongPress: () => toastMsg(jsonEncode(dbDownload[controller.depId])),
      onDoubleTap: () => toastMsg(jsonEncode(DeptQuery.list)),
    );
  }
}

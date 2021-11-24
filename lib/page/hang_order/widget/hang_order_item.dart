import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/hang_order/controller/hang_order_controller.dart';
import 'package:haidai_flutter_module/page/sale/controller/offline_gathering_controller.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/hang_order_model.dart';
import 'package:haidai_flutter_module/page/sale/model/order_item_model.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/more_dialog.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget hangOrderItem(HangOrderModel model, BuildContext context) {
  if (model.type == OfflineGatheringController.TYPE_OFFLINE_GATHERING) {
    return offlineGatheringItem(model, context);
  }
  return Container(
    child: Stack(
      children: [
        // Positioned(child: orderLabel(model.type!), right: 0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   child: _customer(model),
            //   margin: EdgeInsets.only(left: 30.w, top: 24.w, bottom: 24.w),
            // ),
            pSizeBoxH(24.w),
            Row(
              children: [
                _getOrderLabel(model.type!),
                pSizeBoxW(16.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _customer(model),
                    pText("更新时间：${model.updateTime}", ColorConfig.color_999999, 24.w),
                  ],
                ),
              ],
            ),
            pSizeBoxH(14.w),
            goodsOrderItem(model.orderItemList, 0),
            goodsOrderItem(model.orderItemList, 1),
            goodsOrderItem(model.orderItemList, 2),
            // Visibility(
            //   child: Container(
            //     height: 44.w,
            //     margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.w),
            //     padding: EdgeInsets.only(left: 16.w),
            //     child: pText("备注：${model.orderRemark}", ColorConfig.color_F3AE1F, 24.w),
            //     alignment: Alignment.centerLeft,
            //     decoration: ShapeDecoration(
            //         color: Color(ColorConfig.color_f5f5f5),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10.w),
            //         )),
            //   ),
            //   visible: model.orderRemark != null,
            // ),
            // textItem(
            //   "合计应收",
            //   PriceUtils.getPrice(model.receivableAmount),
            //   true,
            // ),
            // textItem(
            //   "抹零",
            //   PriceUtils.getPrice(model.wipeOffAmount),
            //   true,
            // ),
            // textItem(
            //   "税率",
            //   "${model.tax}%",
            //   model.tax != null && model.tax > 0,
            // ),
            // textItem(
            //   "已核销",
            //   PriceUtils.getPrice(model.receivableAmount),
            //   false,
            // ),
            // pSizeBoxH(30.w),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     pText(
            //         model.balanceAmount >= 0 ? "剩余应收" : "剩余应退",
            //         model.balanceAmount >= 0
            //             ? ColorConfig.color_333333
            //             : ColorConfig.color_FF3715,
            //         24.w),
            //     pSizeBoxW(10.w),
            //     pText(
            //         PriceUtils.getPrice(model.balanceAmount),
            //         model.balanceAmount >= 0
            //             ? ColorConfig.color_333333
            //             : ColorConfig.color_FF3715,
            //         42.w),
            //     pSizeBoxW(30.w),
            //   ],
            // ),
            pSizeBoxH(20.w),
            Container(color: Color(ColorConfig.color_efefef), height: 1.w),
            bottomWidget(model, context),
          ],
        ),
      ],
    ),
    color: Colors.white,
  );
}

Widget offlineGatheringItem(HangOrderModel model, BuildContext context) {
  var count = 0.0;
  model.remitAmountMap?.forEach((key, value) => count += value);
  var methodWidgets = model.remitMethodMap?.values
      .map<Widget>(
        (e) => textItem(
          e.remitMethodName ?? "",
          "¥${model.remitAmountMap?[e.id]}",
          true,
        ),
      )
      .toList();
  var widgetList = <Widget>[
    // Container(
    //   child: _customer(model),
    //   margin: EdgeInsets.only(left: 30.w, top: 24.w),
    // ),
    pSizeBoxH(24.w),
    Row(
      children: [
        _getOrderLabel(model.type!),
        pSizeBoxW(16.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customer(model),
            pText("更新时间：${model.updateTime}", ColorConfig.color_999999, 24.w),
          ],
        ),
      ],
    ),
    pSizeBoxH(30.w),
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        pText("收款", ColorConfig.color_333333, 24.w),
        pSizeBoxW(10.w),
        pText("¥$count", ColorConfig.color_333333, 42.w),
        pSizeBoxW(30.w),
      ],
    ),
    pSizeBoxH(20.w),
    Container(color: Color(ColorConfig.color_efefef), height: 1.w),
    bottomWidget(model, context)
  ];
  widgetList.insertAll(2, methodWidgets ?? []);
  return Container(
    child: Stack(
      children: [
        // Positioned(child: orderLabel(model.type!), right: 0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgetList,
        ),
      ],
    ),
    color: Colors.white,
  );
}

Widget _customer(HangOrderModel model) {
  return GetBuilder<HangOrderController>(
    builder: (ctl) => GestureDetector(
      child: Row(
        children: [
          pText(
            model.customer == null ? "未录入客户" : model.customer!.customerName!,
            model.customer == null ? ColorConfig.color_999999 : ColorConfig.color_333333,
            32.w,
            fontWeight: model.customer == null ? FontWeight.w400 : FontWeight.bold,
          ),
          Visibility(
            child: pText("(断网新增)", ColorConfig.color_999999, 32.w),
            visible: (model.customer?.offline ?? 0) == 1,
          ),
          Visibility(
            child: pImage("images/icon_goto.png", 23.w, 23.w),
            visible: (model.customer?.offline ?? 0) == 1,
          ),
        ],
      ),
      onTap: () {
        if ((model.customer?.offline ?? 0) == 1) {
          Get.toNamed(ArgUtils.map2String(path: Routes.ADD_CUSTOMER, arguments: {
            Constant.ONLINE: false,
            Constant.DEPT_ID: model.deptId,
            Constant.CUSTOMER_ID: model.customerId,
          }))?.then((value) => ctl.updateHangOrderList());
        }
      },
    ),
  );
}

bottomWidget(HangOrderModel model, BuildContext context) {
  var key = GlobalKey();
  return GetBuilder<HangOrderController>(
    builder: (ctl) => Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                key: key,
                child: pText("更多", ColorConfig.color_999999, 24.w),
                alignment: Alignment.center,
                height: 86.w,
              ),
              onTap: () => MoreDialog(
                {"删除": () => ctl.deleteOrder(model.id)},
                adapterFlag: true,
                adapterHeight: 85.w,
                adapterWidth: 125.w,
              ).show(context, key),
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  pImage("images/print_icon.png", 30.w, 30.w),
                  pSizeBoxW(16.w),
                  Container(
                    child: pText("打印", ColorConfig.color_999999, 24.w),
                    alignment: Alignment.center,
                    height: 86.w,
                  ),
                ],
              ),
              onTap: () => orderPrint(model),
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  pImage("images/submit_icon.png", 30.w, 30.w),
                  pSizeBoxW(16.w),
                  Container(
                    child: pText("提交单据", ColorConfig.color_999999, 24.w),
                    alignment: Alignment.center,
                    height: 86.w,
                  ),
                ],
              ),
              onTap: () => model.type == OfflineGatheringController.TYPE_OFFLINE_GATHERING
                  ? toOfflineGathering(ctl, model)
                  : toSaleEnter(ctl, model),
            ),
          ),
        ],
      ),
    ),
  );
}

orderPrint(HangOrderModel model) {
  // print("flutter_tag===========${jsonEncode(model)}");
  // PrintUtils.process(Pa, model, list, printName, printTypeName)
  if (model.customer == null) {
    toastMsg("请选择客户");
    return;
  }
  // var reqEntity = PrintReqEntity();
  // reqEntity.printTypeName = "客户联";
  // reqEntity.customerDeptConfigTypeList = ["CONFIG_PRINT_IMG_1"];
  // reqEntity.pageWidth = 'EIGHTY';
  // reqEntity.orderSaleId = model.id;
  // reqEntity.customerDeptId = model.deptId;
  // reqEntity.deptName = "带带弟弟";
  // reqEntity.userName = "fasdfs";
  // createPrintData(reqEntity);
  switch (model.type) {
    case OfflineGatheringController.TYPE_OFFLINE_GATHERING:
      MethodChannel(ChannelConfig.flutterToNative).invokeMethod(ChannelConfig.methodPrintLocalRemit, model.id);
      break;
    case SaleEnterController.TYPE_QUOTATION:
    case SaleEnterController.TYPE_OFFLINE_SALE:
    case SaleEnterController.TYPE_SALE:
      MethodChannel(ChannelConfig.flutterToNative).invokeMethod(ChannelConfig.methodPrintLocalSale, model.id);
      break;
      break;
  }
}

toOfflineGathering(HangOrderController ctl, HangOrderModel model) {
  Get.toNamed(ArgUtils.map2String(
    path: Routes.OFFLINE_GATHERING,
    arguments: {
      Constant.DEPT_ID: ctl.depId,
      Constant.ORDER_ID: model.id,
      OfflineGatheringController.SUBMIT_ORDER: true,
    },
  ))?.then(
    (value) => ctl.updateSelectOrderType(HangOrderController.filterAll),
  );
}

toSaleEnter(HangOrderController ctl, HangOrderModel model) {
  Get.toNamed(ArgUtils.map2String(
    path: Routes.SALE_ENTER,
    arguments: {
      Constant.DEPT_ID: ctl.depId,
      Constant.TYPE: model.type,
      Constant.ORDER_ID: model.id,
      SaleEnterController.SUBMIT_ORDER: true,
    },
  ))?.then(
    (value) => ctl.updateSelectOrderType(HangOrderController.filterAll),
  );
}

textItem(String title, String value, bool visible) {
  return Visibility(
    child: Container(
      child: Row(
        children: [
          pText(title, ColorConfig.color_333333, 28.w),
          Expanded(child: Container()),
          pText(value, ColorConfig.color_333333, 28.w, fontWeight: FontWeight.bold),
        ],
      ),
      margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.w),
    ),
    visible: visible,
  );
}

goodsOrderItem(List<OrderItemModel> orderItemList, int index) {
  if (index >= orderItemList.length) {
    return Container(height: 0);
  }
  var orderItem = orderItemList[index];
  var textColor;
  switch (orderItem.type) {
    case SaleTypeEnum.CHANGE_BACK_ORDER:
      textColor = ColorConfig.color_FF7314;
      break;
    case SaleTypeEnum.RETURN_GOODS:
      textColor = ColorConfig.color_ff3715;
      break;
    case SaleTypeEnum.NORMAL_SALE:
      textColor = ColorConfig.color_1678FF;
      break;
  }
  return Container(
    height: 104.w,
    margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.w),
    padding: EdgeInsets.only(left: 16.w, right: 16.w),
    child: Row(
      children: [
        goodsCover(orderItem.getCover(0)),
        pSizeBoxW(10.w),
        goodsCover(orderItem.getCover(1)),
        pSizeBoxW(10.w),
        goodsCover(orderItem.getCover(2)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              pText(orderItem.goodsCountText(), textColor, 32.w, fontWeight: FontWeight.bold),
              pText(orderItem.goodsStylePriceText(), ColorConfig.color_999999, 24.w),
            ],
          ),
        )
      ],
    ),
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.w),
      ),
      color: Color(ColorConfig.color_FAFAFA),
    ),
  );
}

goodsCover(String? url) {
  if (url == null) {
    return Container(width: 0);
  }
  return NetImageWidget(
    url,
    width: 72,
    height: 72,
    radius: 4,
    clickEnable: false,
  );
}

orderLabel(int type) {
  var textColor;
  var bgColor;
  var text;
  if (type == SaleEnterController.TYPE_QUOTATION) {
    textColor = ColorConfig.color_C280FF;
    bgColor = ColorConfig.color_1AC280FF;
    text = "报价单";
  } else if (type == SaleEnterController.TYPE_OFFLINE_SALE) {
    textColor = ColorConfig.color_999999;
    bgColor = ColorConfig.color_efefef;
    text = "断网单";
  } else if (type == SaleEnterController.TYPE_SALE) {
    textColor = ColorConfig.color_1678FF;
    bgColor = ColorConfig.color_1A1678FF;
    text = "挂单";
  } else {
    textColor = ColorConfig.color_00CFCF;
    bgColor = ColorConfig.color_1A00CFCF;
    text = "收款单";
  }
  return Container(
    child: pText(text, textColor, 24.w),
    height: 32.w,
    width: 92.w,
    alignment: Alignment.center,
    decoration: ShapeDecoration(
      color: Color(bgColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.w)),
      ),
    ),
  );
}

_getOrderLabel(int type) {
  var bgColor;
  var text;
  if (type == SaleEnterController.TYPE_QUOTATION) {
    bgColor = ColorConfig.color_F783C7;
    text = "报价";
  } else if (type == SaleEnterController.TYPE_OFFLINE_SALE) {
    bgColor = ColorConfig.color_F5C447;
    text = "断网";
  } else if (type == SaleEnterController.TYPE_SALE) {
    bgColor = ColorConfig.color_1678FF;
    text = "挂单";
  } else {
    bgColor = ColorConfig.color_2CE1DC;
    text = "收款";
  }
  return Container(
    child: pText(text, ColorConfig.color_ffffff, 28.w),
    height: 80.w,
    width: 80.w,
    margin: EdgeInsets.only(left: 30.w),
    alignment: Alignment.center,
    decoration: ShapeDecoration(
      shape: CircleBorder(),
      color: Color(bgColor),
    ),
  );
}

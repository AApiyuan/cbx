
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/widget/order_detail_dialog.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/forbid.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget bottomStatistics(BuildContext context, SaleEnterController controller) {
  return Row(
    children: [
      Expanded(
        child: statistics(
          context,
          "images/icon_up.png",
          () => showOrderDetail(
            context,
            controller,
            bottom:
                statistics(context, "images/icon_down.png", () => Get.back()),
          ),
        ),
      ),
      // Expanded(child: Container(color: Colors.white)),
      Visibility(
        child: itemBtn(
          "挂单",
          ColorConfig.color_F7B500,
          true,
          () => controller.hangOrder(),
        ),
        visible: !controller.isEdit,
      ),
      itemBtn(
        controller.type == SaleEnterController.TYPE_OFFLINE_SALE ? "提交" : "完成",
        controller.type == SaleEnterController.TYPE_OFFLINE_SALE
            ? ColorConfig.color_1678FF
            : ColorConfig.color_FF7113,
        true,
        () => showOrderDetail(context, controller),
      ),
    ],
  );
}

quotationOrderConfirm(SaleEnterController controller) {
  return Forbid(
    child: Container(
      margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.w, bottom: 10.w),
      height: 84.w,
      child: pText("确定报价", ColorConfig.color_ffffff, 32.w),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.w),
        ),
        color: Color(ColorConfig.color_1678FF),
      ),
    ),
    onTap: () => _createOrder(controller, null),
  );
}

saleOrderConfirm(SaleEnterController controller) {
  return Row(
    children: [
      Expanded(
        child: Forbid(
          child: Container(
            margin: EdgeInsets.only(
                left: 30.w, right: 11.w, top: 10.w, bottom: 10.w),
            height: 84.w,
            child: pText("只做单，暂不收款", ColorConfig.color_1678FF, 32.w),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(ColorConfig.color_1678FF),
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(10.w),
              ),
              color: Colors.white,
            ),
          ),
          onTap: () => _createOrder(controller, true),
        ),
      ),
      Expanded(
        child: Forbid(
          child: Container(
            margin: EdgeInsets.only(
                left: 11.w, right: 30.w, top: 10.w, bottom: 10.w),
            height: 84.w,
            child: pText("去收款", ColorConfig.color_ffffff, 32.w),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w),
              ),
              color: Color(ColorConfig.color_1678FF),
            ),
          ),
          onTap: () => _createOrder(controller, false),
        ),
      ),
    ],
  );
}

/// toDetail为true就是前往销售单详情，否则前往收款页面
_createOrder(SaleEnterController controller, bool? toDetail) {
  return controller.createOrder().then((value) {
    BackUtils.back();
    if (controller.type == SaleEnterController.TYPE_QUOTATION) {
      BackUtils.back(result: true);
      toastMsg("创建报价单完成");
    } else if (toDetail!) {
      if (controller.isEdit) {
        BackUtils.back(result: "update");
      } else {
        Get.offNamed(ArgUtils.map2String(path: Routes.SALE_DETAIL, arguments: {
          Constant.ORDER_SALE_ID: value.id,
          Constant.DEPT_ID: value.deptId
        }));
      }
    } else {
      Get.offNamed(ArgUtils.map2String(
        path: Routes.SALE_REMIT,
        arguments: {
          Constant.DEPT_ID: controller.deptId,
          Constant.ORDER_SALE_ID: value.id,
          Constant.CUSTOMER_ID: value.customerId,
          Constant.AMOUNT: value.balanceAmount, //结欠金额
        },
      ));
      // MethodChannel(ChannelConfig.flutterToNative)
      //     .invokeMethod(ChannelConfig.methodGatheringOrder, jsonEncode(value));
      // BackUtils.back(result: true);
    }
  }, onError: (t) => print("flutter_tag====onError=====$t"));
}

showOrderDetail(BuildContext context, SaleEnterController controller,
    {Widget? bottom}) {
  if (!controller.hasSale && !controller.hasReturn && !controller.hasOwe) {
    toastMsg("请先录入货品");
    return;
  } else if (controller.goodsLen == 0) {
    toastMsg("请选择货品数量");
    return;
  } else if (controller.customer == null) {
    toastMsg("请先录入客户");
    return;
  }
  var title;
  if (controller.type == SaleEnterController.TYPE_SALE) {
    title = "销售单";
  } else if (controller.type == SaleEnterController.TYPE_QUOTATION) {
    title = "报价单";
  } else {
    title = "断网单";
  }
  if (bottom == null) {
    if (controller.type == SaleEnterController.TYPE_QUOTATION) {
      bottom = quotationOrderConfirm(controller);
    } else {
      bottom = saleOrderConfirm(controller);
    }
  }
  controller.getRelationList().then(
        (value) => showCupertinoModalBottomSheet(
          context: Get.context!,
          animationCurve: Curves.easeIn,
          builder: (context) => BottomSheetWidget(
            title: title,
            showCertain: false,
            height: 1400.w,
            child: OrderDetailDialog(
              title,
              controller.orderItemList,
              controller.saleReq,
              controller.saleBeforeReq,
              controller.type,
              edit: controller.isEdit,
              customer: controller.customer,
              checkAmount: controller.checkAmount,
              bottomWidget: bottom,
              warehouseList: value,
              dismissFunction: () => controller.calculate(
                  updateList: [SaleEnterController.idAmountStatistics]),
              updateFunction: () =>
                  controller.update([SaleEnterController.idAmountStatistics]),
            ),
          ),
        ),
      );
  //showModalBottomSheet(
  //           context: context,
  //           isScrollControlled: true,
  //           enableDrag: false,
  //           backgroundColor: Colors.transparent,
  //           builder: (context) {
  //             return OrderDetailDialog(
  //               title,
  //               controller.orderItemList,
  //               controller.saleReq,
  //               controller.saleBeforeReq,
  //               controller.type,
  //               customer: controller.customer,
  //               bottomWidget: bottom,
  //               warehouseList: value,
  //               dismissFunction: () => controller.calculate(
  //                   updateList: [SaleEnterController.idAmountStatistics]),
  //               updateFunction: () =>
  //                   controller.update([SaleEnterController.idAmountStatistics]),
  //             );
  //           },
  //         )
}

statistics(BuildContext context, String arrowPath, Function detailTap) {
  return GetBuilder<SaleEnterController>(
    builder: (ctl) {
      return GestureDetector(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pSizeBoxH(10.w),
              GetBuilder<SaleEnterController>(
                builder: (ctl) {
                  if (ctl.dataLength == 0) {
                    return Row(
                      children: [
                        pSizeBoxW(24.w),
                        pText("未录入货品", ColorConfig.color_999999, 24.w),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      pSizeBoxW(24.w),
                      statisticsItem(
                          "销售${ctl.saleCount}", ColorConfig.color_1678FF),
                      pSizeBoxW(10.w),
                      Visibility(
                        child: statisticsItem("退欠货${ctl.oweCount.abs()}",
                            ColorConfig.color_FF7314),
                        visible: ctl.type == SaleEnterController.TYPE_SALE,
                      ),
                      Visibility(
                        child: pSizeBoxW(10.w),
                        visible: ctl.type == SaleEnterController.TYPE_SALE,
                      ),
                      Visibility(
                        child: statisticsItem("退实物${ctl.returnCount.abs()}",
                            ColorConfig.color_FF3715),
                        visible: ctl.type != SaleEnterController.TYPE_QUOTATION,
                      ),
                    ],
                  );
                },
                id: SaleEnterController.idGoodsStatistics,
              ),
              GetBuilder<SaleEnterController>(
                id: SaleEnterController.idAmountStatistics,
                builder: (ctl) {
                  int price = ctl.balanceAmount;
                  var text = price >= 0 ? "剩余应收" : "剩余应退";
                  int color = price >= 0
                      ? ColorConfig.color_333333
                      : ColorConfig.color_FF3715;
                  return Row(
                    children: [
                      pSizeBoxW(24.w),
                      pText("$text ${ctl.receivable}", color, 28.w),
                      pSizeBoxW(26.w),
                      Visibility(
                        child: Row(
                          children: [
                            pText("明细", ColorConfig.color_666666, 24.w),
                            pImage(arrowPath, 36.w, 22.w),
                          ],
                        ),
                        visible: ctl.goodsLen > 0,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          height: 96.w,
        ),
        onTap: () {
          if (ctl.goodsLen > 0) detailTap.call();
        },
        behavior: HitTestBehavior.opaque,
      );
    },
  );
}

statisticsItem(String text, int textColor) {
  return pText(text, textColor, 24.w);
}

itemBtn(String text, int bgColor, bool visible, Function function) {
  return Visibility(
    child: InkWell(
      child: Container(
        height: 96.w,
        width: 140.w,
        alignment: Alignment.center,
        child: pText(text, ColorConfig.color_ffffff, 28.w),
        color: Color(bgColor),
      ),
      onTap: () => function.call(),
    ),
    visible: visible,
  );
}

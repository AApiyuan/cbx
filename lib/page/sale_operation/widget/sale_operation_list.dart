import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/sale_operation/controller/sale_operation_controller.dart';
import 'package:haidai_flutter_module/page/sale_operation/models/sale_action_detail_do.dart';
import 'package:haidai_flutter_module/page/sale_operation/models/sale_action_type.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/substandard.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget saleOperationList() {
  return GetBuilder<SaleOperationController>(
      id: "operationList",
      builder: (ctl) {
        return Container(
          padding: EdgeInsets.only(top: 30.w),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return operationItem(ctl.actions[index], index, ctl.deptId!);
            },
            itemCount: ctl.actions.length,
          ),
        );
      });
}

Widget operationItem(SaleActionDetailDo item, int index, int deptId) {
  return GetBuilder<SaleOperationController>(builder: (ctl) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 58.w),
          width: double.infinity,
          padding: EdgeInsets.only(left: 60.w, right: 24.w, bottom: 30.w),
          decoration: BoxDecoration(border: Border(left: BorderSide(width: 1.w, color: Color(ColorConfig.color_CCCCCC)))),
          child: Column(
            children: [
              pText("${item.createdTime} 操作：${item.createdByName}", ColorConfig.color_999999, 24.w,
                  width: double.infinity, alignment: Alignment.topLeft),
              pSizeBoxH(20.w),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.all(Radius.circular(10.w))),
                  padding: EdgeInsets.fromLTRB(20.w, 30.w, 20.w, 30.w),
                  child: Stack(
                    children: [
                      action(item, deptId),
                      Visibility(
                        child: Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          top: 0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(color: Color(ColorConfig.color_ffffff).withAlpha((255 * 0.7).toInt())),
                              pImage("images/icon_canceled.png", 124.w, 124.w),
                            ],
                          ),
                        ),
                        visible: item.canceled == CanceledEnum.CANCELED,
                      ),
                    ],
                  ),
              ),
            ],
          ),
        ),
        Positioned(
            top: 80.w,
            left: 42.w,
            child: Container(
              width: 32.w,
              height: 32.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.all(Radius.circular(32.w))),
              child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(color: Color(ColorConfig.color_44d75c), borderRadius: BorderRadius.all(Radius.circular(20.w)))),
            )),
        Positioned(top: 85.w, left: 95.w, child: pImage("images/home_sell_left.png", 24.w, 24.w)),
        Visibility(
          visible: index == 0,
          child: Positioned(
              top: 0.w,
              left: 48.w,
              child: Container(
                width: 20.w,
                height: 20.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Color(ColorConfig.color_ffb115), borderRadius: BorderRadius.all(Radius.circular(20.w))),
                child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.all(Radius.circular(16.w)))),
              )),
        ),
      ],
    );
  });
}

Widget action(SaleActionDetailDo item, int deptId) {
  //开单
  if (item.type == SaleActionDetailTypeEnum.CREATE) {
    String text = "";
    text += item.normalSaleNum != 0
        ? '销' + item.normalSaleNum!.toString() + '件' + (item.returnGoodsNum != 0 || item.changeBackOrderGoodsNum != 0 ? "/" : '')
        : '';
    text += item.changeBackOrderGoodsNum != 0 ? '退欠' + item.changeBackOrderGoodsNum!.toString() + '件' + (item.returnGoodsNum != 0 ? "/" : '') : '';
    text += item.returnGoodsNum != 0 ? (item.substandard == SubstandardEnum.NO ? '退正品' : '退次品') + item.returnGoodsNum!.toString() + '' : '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pText("开单", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
        pSizeBoxH(30.w),
        pText(text, ColorConfig.color_999999, 24.w),
      ],
    );
  } else if (item.type == SaleActionDetailTypeEnum.CANCELED) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      pText("撤销销售单", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
    ]);
  } else if (item.type == SaleActionDetailTypeEnum.WRITE_OFF) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //跳转到核销单
          Get.toNamed(ArgUtils.map2String(path: Routes.GATHERING_DETAIL, arguments: {Constant.ORDER_ID: item.orderId}));
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pText("核销", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
              Row(
                children: [pText("核销单${item.orderSerial}", ColorConfig.color_333333, 24.w), pImage('images/icon_goto.png', 22.w, 22.w)],
              )
            ],
          ),
          pSizeBoxH(30.w),
          pText("核销-${PriceUtils.getPrice(item.amount,abs: true)}", ColorConfig.color_999999, 24.w),
        ]));
  } else if (item.type == SaleActionDetailTypeEnum.SHIP) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //跳转到发货
          // MethodChannel(ChannelConfig.flutterToNative).invokeMethod(ChannelConfig.methodDeliveryDetail, item.orderId);
          Get.toNamed(ArgUtils.map2String(path: Routes.DELIVERY_DETAIL, arguments: {
            Constant.DEPT_ID: deptId,
            Constant.DELIVERY_ORDER_ID: item.orderId,
          }));
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pText("发货", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
              Row(
                children: [pText("发货单${item.orderSerial}", ColorConfig.color_333333, 24.w), pImage('images/icon_goto.png', 22.w, 22.w)],
              )
            ],
          ),
          pSizeBoxH(30.w),
          pText("发${item.goodsStyleNum}款/${item.goodsNum}件", ColorConfig.color_999999, 24.w),
        ]));
  } else if (item.type == SaleActionDetailTypeEnum.CHANGE_BACK_ORDER) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //跳转到退欠货单
          Get.toNamed(ArgUtils.map2String(path: Routes.SALE_DETAIL, arguments: {
            Constant.ORDER_SALE_ID: item.orderId,
            Constant.DEPT_ID: deptId,
          }));
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pText("退欠货", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
              Row(
                children: [pText("退欠货单${item.orderSerial}", ColorConfig.color_333333, 24.w), pImage('images/icon_goto.png', 22.w, 22.w)],
              )
            ],
          ),
          pSizeBoxH(30.w),
          pText("${item.goodsStyleNum}款/${item.goodsNum}件", ColorConfig.color_999999, 24.w),
        ]));
  } else if (item.type == SaleActionDetailTypeEnum.DISTRIBUTION) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      pText("发出他仓调货任务", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
      pSizeBoxH(30.w),
      pText("${item.warehouseName}", ColorConfig.color_999999, 24.w),
    ]);
  } else {
    return Container();
  }
}

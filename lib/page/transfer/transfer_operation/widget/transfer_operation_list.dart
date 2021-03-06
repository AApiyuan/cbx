import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_action_do.dart';
import 'package:haidai_flutter_module/page/transfer/transfer_operation/controller/transfer_operation_controller.dart';
import 'package:haidai_flutter_module/page/transfer/transfer_operation/models/transfer_action_type.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget transferOperationList() {
  return GetBuilder<TransferOperationController>(
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

Widget operationItem(TransferActionDo item, int index, int deptId) {
  return GetBuilder<TransferOperationController>(builder: (ctl) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 58.w),
          width: double.infinity,
          padding: EdgeInsets.only(left: 60.w, right: 24.w, bottom: 30.w),
          decoration:
              BoxDecoration(border: Border(left: BorderSide(width: 1.w, color: Color(ColorConfig.color_CCCCCC)))),
          child: Column(
            children: [
              pText("${item.createdTime} ?????????${item.createdByName}", ColorConfig.color_999999, 24.w,
                  width: double.infinity, alignment: Alignment.topLeft),
              pSizeBoxH(20.w),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.all(Radius.circular(10.w))),
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
              decoration: BoxDecoration(
                  color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.all(Radius.circular(32.w))),
              child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                      color: Color(ColorConfig.color_44d75c), borderRadius: BorderRadius.all(Radius.circular(20.w)))),
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
                decoration: BoxDecoration(
                    color: Color(ColorConfig.color_ffb115), borderRadius: BorderRadius.all(Radius.circular(20.w))),
                child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                        color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.all(Radius.circular(16.w)))),
              )),
        ),
      ],
    );
  });
}

Widget action(TransferActionDo item, int deptId) {
  //??????
  if (item.type == TransferActionDetailTypeEnum.CREATE) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pText("??????${item.applyStyleNum != 0 ? '??????' : ''}?????????", ColorConfig.color_333333, 28.w,
            fontWeight: FontWeight.w600),
        pSizeBoxH(30.w),
        pText(
            "${item.applyStyleNum != 0 ? item.applyStyleNum : item.stockOutStyleNum}??? ${item.applyNum != 0 ? item.applyNum : item.stockOutNum}???",
            ColorConfig.color_999999,
            24.w),
      ],
    );
  } else if (item.type == TransferActionDetailTypeEnum.MODIFY) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pText("???????????????", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
        pSizeBoxH(30.w),
        pText("${item.applyStyleNum}??? ${item.applyNum}???", ColorConfig.color_999999, 24.w),
      ],
    );
  } else if (item.type == TransferActionDetailTypeEnum.CANCEL) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pText("???????????????", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
        pSizeBoxH(30.w),
        pText("${item.applyStyleNum}??? ${item.applyNum}???", ColorConfig.color_999999, 24.w),
      ],
    );
  } else if (item.type == TransferActionDetailTypeEnum.STOCK_OUT ||
      item.type == TransferActionDetailTypeEnum.STOCK_OUT_MODIFY ||
      item.type == TransferActionDetailTypeEnum.STOCK_OUT_CANCEL) {
    String text = "";
    if (item.type == TransferActionDetailTypeEnum.STOCK_OUT) {
      text = "??????";
    }
    if (item.type == TransferActionDetailTypeEnum.STOCK_OUT_MODIFY) {
      text = "???????????????";
    }
    if (item.type == TransferActionDetailTypeEnum.STOCK_OUT_CANCEL) {
      text = "???????????????";
    }
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //???????????????
          if (item.orderStockDeptId == deptId) {
            Get.toNamed(ArgUtils.map2String(
                path: Routes.STOCK_DETAIL,
                arguments: {Constant.ORDER_STOCK_ID: item.orderStockId, Constant.DEPT_ID: deptId}));
          } else {
            toastMsg("??????????????????????????????");
          }
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pText(text, ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
              Row(
                children: [
                  pText("???????????????${item.orderStockSerial}", ColorConfig.color_333333, 24.w),
                  pImage('images/icon_goto.png', 22.w, 22.w)
                ],
              )
            ],
          ),
          Visibility(
              visible: item.type != TransferActionDetailTypeEnum.STOCK_OUT_CANCEL,
              child: Column(
                children: [
                  pSizeBoxH(30.w),
                  pText("${item.stockOutStyleNum}??? ${item.stockOutNum}???", ColorConfig.color_999999, 24.w),
                ],
              ))
        ]));
  } else if (item.type == TransferActionDetailTypeEnum.STOCK_IN ||
      item.type == TransferActionDetailTypeEnum.STOCK_IN_MODIFY ||
      item.type == TransferActionDetailTypeEnum.STOCK_IN_CANCEL) {
    String text = "";
    if (item.type == TransferActionDetailTypeEnum.STOCK_IN) {
      text = "??????";
    }
    if (item.type == TransferActionDetailTypeEnum.STOCK_IN_MODIFY) {
      text = "???????????????";
    }
    if (item.type == TransferActionDetailTypeEnum.STOCK_IN_CANCEL) {
      text = "???????????????";
    }
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //???????????????
          if (item.orderStockDeptId == deptId) {
            Get.toNamed(ArgUtils.map2String(
                path: Routes.STOCK_DETAIL,
                arguments: {Constant.ORDER_STOCK_ID: item.orderStockId, Constant.DEPT_ID: deptId}));
          } else {
            toastMsg("??????????????????????????????");
          }
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pText(text, ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
              Row(
                children: [
                  pText("???????????????${item.orderStockSerial}", ColorConfig.color_333333, 24.w),
                  pImage('images/icon_goto.png', 22.w, 22.w)
                ],
              )
            ],
          ),
          Visibility(
              visible: item.type != TransferActionDetailTypeEnum.STOCK_IN_CANCEL,
              child: Column(
                children: [
                  pSizeBoxH(30.w),
                  pText("${item.stockInStyleNum}??? ${item.stockInNum}???", ColorConfig.color_999999, 24.w),
                ],
              ))
        ]));
  } else if (item.type == TransferActionDetailTypeEnum.FINISH) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            pText("????????????", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
            GetBuilder<TransferOperationController>(builder: (ctl) {
              return Visibility(
                  visible: item.canceled == CanceledEnum.ENABLE && item.orderStockDeptId == ctl.deptId,
                  child: Container(
                      width: 210.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(ColorConfig.color_dcdcdc)),
                          borderRadius: BorderRadius.all(Radius.circular(20.w))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          pImage("images/undo_icon.png", 20.w, 20.w),
                          pText("??????????????????", ColorConfig.color_333333, 22.w,
                              height: 38.w, margin: EdgeInsets.only(left: 10.w), onTap: () {
                            showDialog(
                                context: Get.context!,
                                barrierDismissible: false,
                                builder: (_) {
                                  return CustomDialog(
                                    title: '??????',
                                    type: 1,
                                    confirmTextColor: ColorConfig.color_1678FF,
                                    content: pText("????????????????????????????????????", ColorConfig.color_333333, 28.w),
                                    confirmCallback: (value) async {
                                      bool isCancelFinish = await TransferApi.finishCancel(item.orderTransferId as int);
                                      if (isCancelFinish) {
                                        ctl.getAction(item.orderTransferId as int);
                                      }
                                    },
                                  );
                                });
                          })
                        ],
                      )));
            })
          ],
        ),
        pSizeBoxH(30.w),
        pText("${item.stockInStyleNum}??? ${item.stockInNum}???", ColorConfig.color_999999, 24.w),
      ],
    );
  } else if (item.type == TransferActionDetailTypeEnum.FINISH_CANCEL) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pText("????????????", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
      ],
    );
  } else if (item.type == TransferActionDetailTypeEnum.DELIVERY) {
    String text = "??????";
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //???????????????
          if (item.orderDeliveryDeptId == deptId) {
            Get.toNamed(ArgUtils.map2String(path: Routes.DELIVERY_DETAIL, arguments: {
              Constant.DEPT_ID: deptId,
              Constant.DELIVERY_ORDER_ID: item.orderDeliveryId,
            }));
          } else {
            toastMsg("??????????????????????????????");
          }
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pText(text, ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
              Row(
                children: [
                  pText("?????????${item.orderDeliverySerial}", ColorConfig.color_333333, 24.w),
                  pImage('images/icon_goto.png', 22.w, 22.w)
                ],
              )
            ],
          ),
          Visibility(
              visible: item.type != TransferActionDetailTypeEnum.STOCK_IN_CANCEL,
              child: Column(
                children: [
                  pSizeBoxH(30.w),
                  pText("???${item.orderDeliveryGoodsStyleNum}??? ${item.orderDeliveryGoodsNum}???", ColorConfig.color_999999,
                      24.w),
                ],
              ))
        ]));
  } else {
    return Container();
  }
}

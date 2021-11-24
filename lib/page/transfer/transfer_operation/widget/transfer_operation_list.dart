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
              pText("${item.createdTime} 操作：${item.createdByName}", ColorConfig.color_999999, 24.w,
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
  //开单
  if (item.type == TransferActionDetailTypeEnum.CREATE) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pText("创建${item.applyStyleNum != 0 ? '申请' : ''}调拨单", ColorConfig.color_333333, 28.w,
            fontWeight: FontWeight.w600),
        pSizeBoxH(30.w),
        pText(
            "${item.applyStyleNum != 0 ? item.applyStyleNum : item.stockOutStyleNum}款 ${item.applyNum != 0 ? item.applyNum : item.stockOutNum}件",
            ColorConfig.color_999999,
            24.w),
      ],
    );
  } else if (item.type == TransferActionDetailTypeEnum.MODIFY) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pText("修改申请单", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
        pSizeBoxH(30.w),
        pText("${item.applyStyleNum}款 ${item.applyNum}件", ColorConfig.color_999999, 24.w),
      ],
    );
  } else if (item.type == TransferActionDetailTypeEnum.CANCEL) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pText("撤销申请单", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
        pSizeBoxH(30.w),
        pText("${item.applyStyleNum}款 ${item.applyNum}件", ColorConfig.color_999999, 24.w),
      ],
    );
  } else if (item.type == TransferActionDetailTypeEnum.STOCK_OUT ||
      item.type == TransferActionDetailTypeEnum.STOCK_OUT_MODIFY ||
      item.type == TransferActionDetailTypeEnum.STOCK_OUT_CANCEL) {
    String text = "";
    if (item.type == TransferActionDetailTypeEnum.STOCK_OUT) {
      text = "出库";
    }
    if (item.type == TransferActionDetailTypeEnum.STOCK_OUT_MODIFY) {
      text = "编辑出库数";
    }
    if (item.type == TransferActionDetailTypeEnum.STOCK_OUT_CANCEL) {
      text = "撤销出库单";
    }
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //跳转库存单
          if (item.orderStockDeptId == deptId) {
            Get.toNamed(ArgUtils.map2String(
                path: Routes.STOCK_DETAIL,
                arguments: {Constant.ORDER_STOCK_ID: item.orderStockId, Constant.DEPT_ID: deptId}));
          } else {
            toastMsg("他店操作记录不可查看");
          }
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pText(text, ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
              Row(
                children: [
                  pText("调拨出库单${item.orderStockSerial}", ColorConfig.color_333333, 24.w),
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
                  pText("${item.stockOutStyleNum}款 ${item.stockOutNum}件", ColorConfig.color_999999, 24.w),
                ],
              ))
        ]));
  } else if (item.type == TransferActionDetailTypeEnum.STOCK_IN ||
      item.type == TransferActionDetailTypeEnum.STOCK_IN_MODIFY ||
      item.type == TransferActionDetailTypeEnum.STOCK_IN_CANCEL) {
    String text = "";
    if (item.type == TransferActionDetailTypeEnum.STOCK_IN) {
      text = "入库";
    }
    if (item.type == TransferActionDetailTypeEnum.STOCK_IN_MODIFY) {
      text = "编辑入库数";
    }
    if (item.type == TransferActionDetailTypeEnum.STOCK_IN_CANCEL) {
      text = "撤销入库单";
    }
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //跳转库存单
          if (item.orderStockDeptId == deptId) {
            Get.toNamed(ArgUtils.map2String(
                path: Routes.STOCK_DETAIL,
                arguments: {Constant.ORDER_STOCK_ID: item.orderStockId, Constant.DEPT_ID: deptId}));
          } else {
            toastMsg("他店操作记录不可查看");
          }
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pText(text, ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
              Row(
                children: [
                  pText("调拨入库单${item.orderStockSerial}", ColorConfig.color_333333, 24.w),
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
                  pText("${item.stockInStyleNum}款 ${item.stockInNum}件", ColorConfig.color_999999, 24.w),
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
            pText("完成调拨", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
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
                          pText("撤销完成状态", ColorConfig.color_333333, 22.w,
                              height: 38.w, margin: EdgeInsets.only(left: 10.w), onTap: () {
                            showDialog(
                                context: Get.context!,
                                barrierDismissible: false,
                                builder: (_) {
                                  return CustomDialog(
                                    title: '提示',
                                    type: 1,
                                    confirmTextColor: ColorConfig.color_1678FF,
                                    content: pText("确定撤销调拨完成状态吗？", ColorConfig.color_333333, 28.w),
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
        pText("${item.stockInStyleNum}款 ${item.stockInNum}件", ColorConfig.color_999999, 24.w),
      ],
    );
  } else if (item.type == TransferActionDetailTypeEnum.FINISH_CANCEL) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pText("撤销完成", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
      ],
    );
  } else if (item.type == TransferActionDetailTypeEnum.DELIVERY) {
    String text = "发货";
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //跳转发货单
          if (item.orderDeliveryDeptId == deptId) {
            Get.toNamed(ArgUtils.map2String(path: Routes.DELIVERY_DETAIL, arguments: {
              Constant.DEPT_ID: deptId,
              Constant.DELIVERY_ORDER_ID: item.orderDeliveryId,
            }));
          } else {
            toastMsg("他店操作记录不可查看");
          }
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pText(text, ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
              Row(
                children: [
                  pText("发货单${item.orderDeliverySerial}", ColorConfig.color_333333, 24.w),
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
                  pText("发${item.orderDeliveryGoodsStyleNum}款 ${item.orderDeliveryGoodsNum}件", ColorConfig.color_999999,
                      24.w),
                ],
              ))
        ]));
  } else {
    return Container();
  }
}

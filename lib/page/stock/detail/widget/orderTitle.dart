import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/page/stock/detail/controller/stock_detail_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/repository/order/stock_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget orderTitle() {
  return GetBuilder<StockDetailController>(builder: (ctl) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 0.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pText("单号 " + ctl.oldStock!.orderSerial.toString(), ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                Row(
                  children: [
                    Visibility(
                        visible: ctl.showCopy,
                        child: pActionText("复制", ColorConfig.color_1678ff, 24.w, 106.w, 62.w, () {
                          showDialog(
                              context: Get.context as BuildContext,
                              builder: (_) {
                                return CustomDialog(
                                  title: '提示',
                                  type: 1,
                                  height: 300,
                                  confirmContent: "去调出",
                                  confirmTextColor: ColorConfig.color_ff3715,
                                  content: pText("确定复制该单货品去调出？", ColorConfig.color_333333, 28.w),
                                  confirmCallback: (value) {
                                    Map<String, dynamic> param = new Map();
                                    param[Constant.DEPT_ID] = ctl.deptId;
                                    param[Constant.ORDER_TRANSFER_TYPE] = TransferOrderTypeEnum.DIRECT;
                                    param[Constant.COPY_STOCK_IDS] = [ctl.oldStock!.id];
                                    Get.toNamed(ArgUtils.map2String(path: Routes.TRANSFER, arguments: param));
                                  },
                                );
                              });
                        }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500)),
                    pSizeBoxW(10.w),
                    GetBuilder<StockDetailController>(
                        id: "cancelButton",
                        builder: (ctl) {
                          return Visibility(
                              visible: !ctl.canceled,
                              child: pActionText("撤销", ColorConfig.color_1678ff, 24.w, 106.w, 62.w, () {
                                if (ctl.oldStock!.orderType == OrderStockTypeEnum.BACK_IN ||
                                    ctl.oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_BACK) {
                                  toBackOrder(ctl.oldStock!.orderSaleId as int, ctl.deptId as int);
                                  return;
                                }
                                if (ctl.oldStock!.orderType == OrderStockTypeEnum.DELIVER_OUT) {
                                  toDeliveryOrder(ctl.deptId, ctl.oldStock!.orderDeliveryId as int);
                                  return;
                                }
                                if (ctl.oldStock!.orderType == OrderStockTypeEnum.TRANSFER_IN ||
                                    ctl.oldStock!.orderType == OrderStockTypeEnum.TRANSFER_OUT ||
                                    ctl.oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_TRANSFER_IN ||
                                    ctl.oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_TRANSFER_OUT) {
                                  toTransferOrder(ctl.oldStock!.orderTransferId as int, ctl);
                                  return;
                                }
                                if (ctl.oldStock!.orderType == OrderStockTypeEnum.DISTRIBUTION_OUT ||
                                    ctl.oldStock!.orderType == OrderStockTypeEnum.DISTRIBUTION_IN) {
                                  toDistributionOrder(ctl.oldStock!.orderTransferId as int, ctl);
                                  return;
                                }
                                //撤销
                                showDialog(
                                    context: Get.context as BuildContext,
                                    builder: (_) {
                                      return CustomDialog(
                                        title: '提示',
                                        type: 1,
                                        height: 300,
                                        confirmTextColor: ColorConfig.color_ff3715,
                                        content: pText("是否撤销单据", ColorConfig.color_333333, 28.w),
                                        confirmCallback: (value) async {
                                          StockApi.cancel(ctl.oldStock!.id as int).then((v) {
                                            //撤销后的操作
                                            ctl.canceled = true;
                                            ctl.update(['cancelButton', 'cancelIcon', 'editButton']);
                                          });
                                        },
                                      );
                                    });
                              }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500));
                        }),
                    pSizeBoxW(10.w),
                    GetBuilder<StockDetailController>(
                        id: "editButton",
                        builder: (ctl) {
                          return Visibility(
                              visible: !ctl.canceled && ctl.oldStock!.orderType != OrderStockTypeEnum.EXCHANGE_ADJUST,
                              child: pActionText("编辑", ColorConfig.color_1678ff, 24.w, 106.w, 62.w, () {
                                if (ctl.oldStock!.orderType == OrderStockTypeEnum.BACK_IN ||
                                    ctl.oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_BACK) {
                                  toBackOrder(ctl.oldStock!.orderSaleId as int, ctl.deptId);
                                  return;
                                }
                                if (ctl.oldStock!.orderType == OrderStockTypeEnum.DELIVER_OUT) {
                                  toDeliveryOrder(ctl.deptId, ctl.oldStock!.orderDeliveryId as int);
                                  return;
                                }
                                if (ctl.oldStock!.orderType == OrderStockTypeEnum.TRANSFER_IN ||
                                    ctl.oldStock!.orderType == OrderStockTypeEnum.TRANSFER_OUT ||
                                    ctl.oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_TRANSFER_IN ||
                                    ctl.oldStock!.orderType == OrderStockTypeEnum.SUBSTANDARD_TRANSFER_OUT) {
                                  toTransferOrder(ctl.oldStock!.orderTransferId as int, ctl);
                                  return;
                                }
                                if (ctl.oldStock!.orderType == OrderStockTypeEnum.DISTRIBUTION_OUT ||
                                    ctl.oldStock!.orderType == OrderStockTypeEnum.DISTRIBUTION_IN) {
                                  toDistributionOrder(ctl.oldStock!.orderTransferId as int, ctl);
                                  return;
                                }
                                //编辑
                                ctl.toEdit();
                              }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500));
                        }),
                  ],
                )
              ],
            ),
            pSizeBoxH(20.w),
            Divider(height: 1.w, color: Color(ColorConfig.color_efefef)),
            Visibility(visible: ctl.oldStock!.customerDo != null || ctl.oldStock!.stockOutDeptId != null, child: pSizeBoxH(40.w)),
            Visibility(
              visible: ctl.oldStock!.customerDo != null,
              child: Row(children: [
                pText("客户", ColorConfig.color_333333, 28.w),
                pSizeBoxW(16.w),
                pText(ctl.oldStock!.customerDo != null ? ctl.oldStock!.customerDo!.customerName.toString() : "", ColorConfig.color_999999, 28.w)
              ]),
            ),
            Visibility(
              visible: ctl.oldStock!.stockOutDeptId != null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      pContainerText("调出", ColorConfig.color_ffffff, 20.w, 56.w, 28.w,
                          radius: 4.w, fontWeight: FontWeight.w500, background: ColorConfig.color_1678ff),
                      pSizeBoxW(6.w),
                      pText(ctl.oldStock!.stockOutDeptName.toString(), ColorConfig.color_333333, 28.w)
                    ],
                  ),
                  pImage("images/to_right.png", 30.w, 30.w),
                  Row(
                    children: [
                      pText(ctl.oldStock!.stockInDeptName.toString(), ColorConfig.color_333333, 28.w),
                      pSizeBoxW(6.w),
                      pContainerText("调入", ColorConfig.color_ffffff, 20.w, 56.w, 28.w,
                          radius: 4.w, fontWeight: FontWeight.w500, background: ColorConfig.color_FF7113)
                    ],
                  ),
                ],
              ),
            ),
            pSizeBoxH(36.w),
            Row(
              children: [
                pText("单据日期", ColorConfig.color_333333, 28.w),
                pSizeBoxW(16.w),
                pText(ctl.oldStock!.customizeTime.toString(), ColorConfig.color_999999, 28.w),
              ],
            ),
            pSizeBoxH(56.w),
            Row(
              children: [
                pText("操作人", ColorConfig.color_333333, 28.w),
                pSizeBoxW(44.w),
                pText(ctl.oldStock!.createdByName.toString(), ColorConfig.color_999999, 28.w),
              ],
            ),
            Visibility(visible: ctl.oldStock!.orderLabel!=null, child: Column(children: [
              pSizeBoxH(56.w),
              Row(
                children: [
                  pText("标签", ColorConfig.color_333333, 28.w),
                  pSizeBoxW(44.w),
                  pText(ctl.oldStock!.orderLabelName.toString(), ColorConfig.color_999999, 28.w,width: 600.w,
                      alignment: Alignment.centerLeft),
                ],
              ),

            ],))
          ],
        ),
      ),
      GetBuilder<StockDetailController>(
          id: "cancelIcon",
          builder: (ctl) {
            return Visibility(
                visible: ctl.canceled, child: Positioned(child: pImage('images/icon_canceled.png', 124.w, 124.w), top: 138.w, right: 24.w));
          })
    ]);
  });
}

toBackOrder(int id, int depId) {
  showDialog(
      context: Get.context as BuildContext,
      builder: (_) {
        return CustomDialog(
          type: 1,
          height: 300,
          confirmContent: "去退货单",
          content: Container(
            padding: EdgeInsets.fromLTRB(50.w, 0, 50.w, 0),
            child: pText("退货入库单不支持直接编辑、撤销，请去调拨单处理", ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w600, softWrap: true, maxLines: 3),
          ),
          confirmCallback: (value) async {
            //跳转原始的退货单
            Get.toNamed(ArgUtils.map2String(path: Routes.SALE_DETAIL, arguments: {Constant.ORDER_SALE_ID: id, Constant.DEPT_ID: depId}));
          },
        );
      });
}

toDeliveryOrder(int deptId, int id) {
  showDialog(
      context: Get.context as BuildContext,
      builder: (_) {
        return CustomDialog(
          type: 1,
          height: 300,
          confirmContent: "去发货单",
          content: Container(
            padding: EdgeInsets.fromLTRB(50.w, 0, 50.w, 0),
            child: pText("发货出库单不支持直接编辑、撤销，请去发货单处理", ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w600, softWrap: true, maxLines: 3),
          ),
          confirmCallback: (value) async {
            //跳转原生的发货单
            // MethodChannel(ChannelConfig.flutterToNative).invokeMethod(ChannelConfig.methodDeliveryDetail, id);
            Get.toNamed(ArgUtils.map2String(path: Routes.DELIVERY_DETAIL, arguments: {
              Constant.DEPT_ID: deptId,
              Constant.DELIVERY_ORDER_ID: id,
            }));
          },
        );
      });
}

toTransferOrder(int id, ctl) {
  showDialog(
      context: Get.context as BuildContext,
      builder: (_) {
        return CustomDialog(
          type: 1,
          height: 265,
          confirmContent: "去调拨单",
          content: Container(
            padding: EdgeInsets.fromLTRB(50.w, 0, 50.w, 0),
            child: pText("调拨单不支持直接编辑、撤销，请去调拨单处理", ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w600, softWrap: true, maxLines: 3),
          ),
          confirmCallback: (value) async {
            //跳转调拨单
            Map<String, dynamic> param = new Map();
            param[Constant.DEPT_ID] = ctl.deptId;
            param[Constant.ORDER_TRANSFER_ID] = id;
            Get.offAndToNamed(ArgUtils.map2String(path: Routes.TRANSFER_DETAIL, arguments: param));
          },
        );
      });
}

toDistributionOrder(int id, ctl) {
  showDialog(
      context: Get.context as BuildContext,
      builder: (_) {
        return CustomDialog(
          type: 1,
          height: 330,
          confirmContent: "去调拨单",
          content: Container(
            padding: EdgeInsets.fromLTRB(50.w, 0, 50.w, 0),
            child: pText("配货单不支持直接编辑、撤销，请去调拨单处理", ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w600, softWrap: true, maxLines: 3),
          ),
          confirmCallback: (value) async {
            //跳转调拨单
            Map<String, dynamic> param = new Map();
            param[Constant.DEPT_ID] = ctl.deptId;
            param[Constant.ORDER_TRANSFER_ID] = id;
            Get.offAndToNamed(ArgUtils.map2String(path: Routes.TRANSFER_DETAIL, arguments: param));
          },
        );
      });
}

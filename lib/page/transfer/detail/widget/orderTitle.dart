import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/transfer/detail/controller/transfer_detail_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_status.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget orderTitle() {
  return GetBuilder<TransferDetailController>(builder: (ctl) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 0.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pText("单号 " + ctl.orderTransfer!.orderSerial.toString(), ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                GetBuilder<TransferDetailController>(
                    id: "cancelButton",
                    builder: (ctl) {
                      return Visibility(
                          visible: !ctl.canceled,
                          child: Row(
                            children: [
                              Visibility(
                                  visible: (ctl.orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_OUT &&
                                          ctl.orderTransfer!.stockInDeptId == ctl.deptId) ||
                                      (ctl.orderTransfer!.orderType == TransferOrderTypeEnum.DIRECT &&
                                          ctl.orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_IN &&
                                          ctl.orderTransfer!.stockOutDeptId == ctl.deptId),
                                  child: pActionText("撤销", ColorConfig.color_1678ff, 24.w, 106.w, 62.w, () {
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
                                              TransferApi.cancelTransfer(ctl.orderTransfer!.id as int).then((v) {
                                                //撤销后的操作
                                                ctl.canceled = true;
                                                ctl.update(['cancelButton', 'cancelIcon']);
                                              });
                                            },
                                          );
                                        });
                                  }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500)),
                              pSizeBoxW(10.w),
                              Visibility(
                                  visible: ctl.showEdit,
                                  child: pActionText("编辑", ColorConfig.color_1678ff, 24.w, 106.w, 62.w, () {
                                    //撤销
                                    ctl.toEdit(showAllSku: true);
                                  }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500)),
                            ],
                          ));
                    })
              ],
            ),
            pSizeBoxH(40.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    pContainerText("调出", ColorConfig.color_ffffff, 20.w, 56.w, 28.w,
                        radius: 4.w, fontWeight: FontWeight.w500, background: ColorConfig.color_1678ff),
                    pSizeBoxW(6.w),
                    pText(ctl.orderTransfer!.stockOutDeptName.toString(), ColorConfig.color_333333, 28.w)
                  ],
                ),
                pImage("images/to_right.png", 30.w, 30.w),
                Row(
                  children: [
                    pText(ctl.orderTransfer!.stockInDeptName.toString(), ColorConfig.color_333333, 28.w),
                    pSizeBoxW(6.w),
                    pContainerText("调入", ColorConfig.color_ffffff, 20.w, 56.w, 28.w,
                        radius: 4.w, fontWeight: FontWeight.w500, background: ColorConfig.color_FF7113)
                  ],
                ),
              ],
            ),
            pSizeBoxH(56.w),
            Visibility(
                visible: ctl.orderTransfer!.orderSaleId != null,
                child: Column(
                  children: [
                    Row(
                      children: [
                        pText("销售单", ColorConfig.color_333333, 28.w),
                        pSizeBoxW(16.w),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: pText(ctl.orderTransfer!.orderSaleId != null ? (ctl.orderTransfer!.storeCustomer!.customerName ?? "") : "",
                                  ColorConfig.color_999999, 28.w),
                            ),
                            pSizeBoxW(5.w),
                            pText(
                                "#" +
                                    (ctl.orderTransfer!.orderSaleId != null
                                        ? int.parse(ctl.orderTransfer!.orderSaleSerial!.substring(ctl.orderTransfer!.orderSaleSerial!.length - 3))
                                            .toString()
                                        : ""),
                                ColorConfig.color_999999,
                                28.w),
                            pSizeBoxW(5.w),
                            pText(ctl.orderTransfer!.orderSaleId != null ? ctl.orderTransfer!.orderSaleCustomizeTime!.substring(0, 10) : "",
                                ColorConfig.color_999999, 28.w)
                          ],
                        )
                      ],
                    ),
                    pSizeBoxH(40.w),
                  ],
                )),
            Row(
              children: [
                pText("单据日期", ColorConfig.color_333333, 28.w),
                pSizeBoxW(16.w),
                pText(ctl.orderTransfer!.customizeTime.toString(), ColorConfig.color_999999, 28.w),
              ],
            ),
            pSizeBoxH(40.w),
            Row(
              children: [
                pText("开单人", ColorConfig.color_333333, 28.w),
                pSizeBoxW(44.w),
                pText(ctl.orderTransfer!.createdByName.toString(), ColorConfig.color_999999, 28.w),
              ],
            ),
          ],
        ),
      ),
      GetBuilder<TransferDetailController>(
          id: "cancelIcon",
          builder: (ctl) {
            return Visibility(
                visible: ctl.canceled, child: Positioned(child: pImage('images/icon_canceled.png', 124.w, 124.w), top: 138.w, right: 24.w));
          })
    ]);
  });
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:haidai_flutter_module/page/transfer/detail/controller/transfer_detail_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/difference.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_status.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget orderStatus() {
  return GetBuilder<TransferDetailController>(builder: (ctl) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 36.w, 24.w, 24.w),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 1.w))),
      child: Column(
        children: [
          Row(
            children: [
              Visibility(
                visible: ctl.orderTransfer!.orderType == TransferOrderTypeEnum.APPLY,
                child: Container(
                    width: 200.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        pImage("images/icon_check_center_02.png", 40.w, 40.w),
                        Container(padding: EdgeInsets.fromLTRB(6.w, 0, 10.w, 0), child: pText('待出库', ColorConfig.color_44D75C, 24.w)),
                        Expanded(
                          child: Container(
                            color: Color(
                                ctl.orderTransfer!.status != TransferStatusEnum.WAIT_STOCK_OUT ? ColorConfig.color_44D75C : ColorConfig.color_dcdcdc),
                            height: 3.w,
                            width: double.infinity,
                          ),
                        )
                      ],
                    )),
              ),
              Container(
                  width: 155.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      pImage(
                          ctl.orderTransfer!.status != TransferStatusEnum.WAIT_STOCK_OUT ? "images/icon_check_center_02.png" : "images/icon_no.png",
                          40.w,
                          40.w),
                      Container(
                          padding: EdgeInsets.fromLTRB(6.w, 0, 10.w, 0),
                          child: pText(
                              '已出待收',
                              ctl.orderTransfer!.status != TransferStatusEnum.WAIT_STOCK_OUT ? ColorConfig.color_44D75C : ColorConfig.color_999999,
                              24.w)),
                    ],
                  )),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: Color((ctl.orderTransfer!.status != TransferStatusEnum.WAIT_STOCK_OUT &&
                              ctl.orderTransfer!.status != TransferStatusEnum.WAIT_STOCK_IN)
                          ? ColorConfig.color_44D75C
                          : ColorConfig.color_dcdcdc),
                      height: 3.w,
                      width: double.infinity,
                    ),
                  ),
                  pImage(
                      (ctl.orderTransfer!.status != TransferStatusEnum.WAIT_STOCK_OUT &&
                              ctl.orderTransfer!.status != TransferStatusEnum.WAIT_STOCK_IN)
                          ? "images/icon_check_center_02.png"
                          : "images/icon_no.png",
                      40.w,
                      40.w),
                  Container(
                      padding: EdgeInsets.fromLTRB(6.w, 0, 10.w, 0),
                      child: pText(
                          '已收货',
                          (ctl.orderTransfer!.status != TransferStatusEnum.WAIT_STOCK_OUT &&
                                  ctl.orderTransfer!.status != TransferStatusEnum.WAIT_STOCK_IN)
                              ? ColorConfig.color_44D75C
                              : ColorConfig.color_999999,
                          24.w)),
                ],
              )),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: Color(ctl.orderTransfer!.status == TransferStatusEnum.FINISH ? ColorConfig.color_44D75C : ColorConfig.color_dcdcdc),
                      height: 3.w,
                      width: double.infinity,
                    ),
                  ),
                  pImage(
                      ctl.orderTransfer!.status == TransferStatusEnum.FINISH ? "images/icon_check_center_02.png" : "images/icon_no.png", 40.w, 40.w),
                  Container(
                      padding: EdgeInsets.fromLTRB(6.w, 0, 10.w, 0),
                      child: pText(
                          '完成', ctl.orderTransfer!.status == TransferStatusEnum.FINISH ? ColorConfig.color_44D75C : ColorConfig.color_999999, 24.w)),
                ],
              ))
            ],
          ),
          pSizeBoxH(35.w),
          GetBuilder<TransferDetailController>(builder: (ctl) {
            if (ctl.deptId == ctl.orderTransfer!.stockInDeptId) {
              //当前店铺是申请方也是 入库方
              if (ctl.orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_OUT) {
                //状态为等待对方出库，可以修改申请数
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    pActionText("修改申请数", ColorConfig.color_333333, 24.w, 150.w, 64.w, () {
                      ctl.toEdit(showAllSku: true);
                    }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500),
                  ],
                );
              } else if (ctl.orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_IN) {
                //对方 已出库等待入库
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    pActionText("入库", ColorConfig.color_333333, 24.w, 150.w, 64.w, () {
                      ctl.toEdit();
                    }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500),
                  ],
                );
              } else if (ctl.orderTransfer!.status == TransferStatusEnum.STOCK_IN) {
                //对方 已出库等待入库
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    pActionText("修改入库数", ColorConfig.color_333333, 24.w, 150.w, 64.w, () {
                      ctl.toEdit();
                    }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500),
                    Visibility(
                        visible: ctl.orderTransfer!.difference == DifferenceEnum.NO_DIFFERENCE,
                        child: Row(
                          children: [
                            pSizeBoxW(16.w),
                            pActionText("完成", ColorConfig.color_333333, 24.w, 150.w, 64.w, () {
                              ctl.toFinish(isDelivery: false);
                            }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500),
                            pSizeBoxW(16.w),
                            Visibility(
                                visible: ctl.orderTransfer!.orderSaleId != null,
                                child: pActionText("完成并发货", ColorConfig.color_333333, 24.w, 150.w, 64.w, () {
                                  TransferApi.checkStock(ctl.orderTransfer!.id as int).then((v) {
                                    if (v) {
                                      ctl.toFinish(isDelivery: true);
                                    } else {
                                      showDialog(
                                          context: Get.context as BuildContext,
                                          builder: (_) {
                                            return CustomDialog(
                                              type: 1,
                                              confirmTextColor: ColorConfig.color_ff3715,
                                              content: pText(
                                                "确定发货吗?发货数超库存，会导致负库存",
                                                ColorConfig.color_333333,
                                                32.w,
                                                fontWeight: FontWeight.w600,
                                                maxLines: 2,
                                                width: double.infinity,
                                                padding: EdgeInsets.only(top: 0.w, left: 80.w, bottom: 0.w, right: 80.w),
                                              ),
                                              confirmCallback: (value) async {
                                                ctl.toFinish(isDelivery: true);
                                              },
                                            );
                                          });
                                    }
                                  });
                                }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500)),
                          ],
                        ))
                  ],
                );
              } else {
                //已完成
                return Container();
              }
            } else {
              //当前店铺是出库方
              if (ctl.orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_OUT) {
                //状态为等待对方出库，可以修改申请数
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    pActionText("出库", ColorConfig.color_333333, 24.w, 150.w, 64.w, () {
                      ctl.toEdit();
                    }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500)
                  ],
                );
              } else if (ctl.orderTransfer!.status == TransferStatusEnum.WAIT_STOCK_IN ||
                  ctl.orderTransfer!.status == TransferStatusEnum.STOCK_IN ||
                  ctl.orderTransfer!.difference == DifferenceEnum.DIFFERENCE) {
                //状态为等待对方出库，可以修改申请数
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    pActionText("修改出库数", ColorConfig.color_333333, 24.w, 150.w, 64.w, () {
                      if (ctl.orderTransfer!.orderType == TransferOrderTypeEnum.DIRECT) {
                        ctl.toEdit(showAllSku: true);
                      } else {
                        ctl.toEdit();
                      }
                    }, borderColor: ColorConfig.color_dcdcdc, radius: 32.w, fontWeight: FontWeight.w500),
                  ],
                );
              } else {
                return Container();
              }
            }
          })
        ],
      ),
    );
  });
}

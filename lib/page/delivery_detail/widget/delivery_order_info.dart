
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/dept_config_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/delivery_detail/controller/delivery_detail_controller.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget DeliveryorderInfo(context) {
  return GetBuilder<DeliveryDetailController>(
      id: 'deliveryorderInfo',
      builder: (ctl) {
    var logisticsCompanyName = ctl.saleOrder!.logisticsCompanyName != null ? ctl.saleOrder!.logisticsCompanyName : '';
    var logisticsNo = ctl.saleOrder!.logisticsNo != null ? ctl.saleOrder!.logisticsNo : '';
    var logisticstext = logisticsCompanyName! + logisticsNo!;
    var consigneeImg = ctl.saleOrder!.consigneeImg != null ? ctl.saleOrder!.consigneeImg : '';

    var orderSerial = ctl.saleOrder?.orderStock?.orderSerial != null ? ctl.saleOrder!.orderStock!.orderSerial! : '';


    return Container(
        decoration: BoxDecoration(
          border: Border(
              // top: BorderSide(width: 16.w, color: Color(ColorConfig.color_f5f5f5)),
              ),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(11.0),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    Row(
                      children: [
                        pSizeBoxW(24.w),
                        pText('单据单号', ColorConfig.color_333333, 28.w,
                            width: 115.w,
                            alignment: Alignment.centerLeft,
                            fontWeight: FontWeight.bold),
                        pSizeBoxW(16.w),
                        pText(
                            ctl.saleOrder!.orderSerial!, ColorConfig.color_333333, 28.w,
                            width: 155.w, alignment: Alignment.centerLeft),
                        Expanded(child: Container()),
                        pActionText('撤销', ColorConfig.color_666666, 28.w, 156.w, 72.w, () => cancel(ctl),
                                  background: ColorConfig.color_f5f5f5, radius: 36.w),
                        pSizeBoxW(10.w),
                        pActionText('编辑', ColorConfig.color_1678FF, 28.w, 156.w, 72.w, () => edit(ctl),
                                  background: ColorConfig.color_E8F2FF, radius: 36.w,),
                        pSizeBoxW(24.w),
                      ],
                    ),
                    pSizeBoxH(24.w),
                    Visibility(
                      visible: ctl.saleOrder!.logisticsNo != null || ctl.saleOrder!.consigneeImg != null,
                      child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            updateRemark(context, ctl);
                          },
                          child: Row(
                            children: [
                              pSizeBoxW(24.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pText('物流信息', ColorConfig.color_333333, 28.w,
                                      width: 115.w, alignment: Alignment.topLeft)
                                ],
                              ),
                              pSizeBoxW(16.w),
                              pText(logisticstext.length == 0 ? '未填写信息' : logisticstext,
                                  ColorConfig.color_999999, 28.w,
                                  alignment: Alignment.topLeft,
                                  textAlign: TextAlign.left),
                              pSizeBoxW(24.w),
                            ],
                          )),
                    ),
                    pSizeBoxH(24.w),
                    Visibility(
                      visible: ctl.saleOrder!.consigneeImg != null,
                      child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            updateRemark(context, ctl);
                          },
                          child: Row(
                            children: [
                              pSizeBoxW(155.w),
                              NetImageWidget(
                                consigneeImg!,
                                height: 68,
                                width: 68,
                              ),
                            ],
                          )),
                    ),
                    pSizeBoxH(24.w),
                    Row(
                      children: [
                        pSizeBoxW(24.w),
                        pText('单据日期', ColorConfig.color_333333, 28.w,
                            width: 115.w, alignment: Alignment.centerLeft),
                        pSizeBoxW(16.w),
                        pText(ctl.saleOrder!.customizeTime!, ColorConfig.color_999999,
                            28.w,
                            width: 385.w, alignment: Alignment.centerLeft),
                        Expanded(child: Container()),
                      ],
                    ),
                    pSizeBoxH(24.w),
                    Row(
                      children: [
                        pSizeBoxW(24.w),
                        pText('开单人', ColorConfig.color_333333, 28.w,
                            width: 115.w, alignment: Alignment.centerLeft),
                        pSizeBoxW(16.w),
                        pText(ctl.saleOrder!.createdByName!, ColorConfig.color_999999,
                            28.w,
                            width: 385.w, alignment: Alignment.centerLeft),
                        Expanded(child: Container()),
                      ],
                    ),
                    pSizeBoxH(24.w),
                    Visibility(
                      visible: true,
                      child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            updateRemark(context, ctl);
                          },
                          child: Row(
                            children: [
                              pSizeBoxW(24.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pText('备注', ColorConfig.color_333333, 28.w,
                                      width: 115.w, alignment: Alignment.topLeft)
                                ],
                              ),
                              pSizeBoxW(16.w),
                              Expanded(
                                  child: GetBuilder<DeliveryDetailController>(
                                      id: "deliveryOrderRemark",
                                      builder: (ctl) {
                                        return pText(ctl.saleOrder?.remark != null?ctl.saleOrder!.remark!:"",
                                            ColorConfig.color_999999, 28.w,
                                            width: 532.w,
                                            alignment: Alignment.topLeft,
                                            maxLines: 3,
                                            textAlign: TextAlign.left);
                                      })),
                              pSizeBoxW(19.w),
                              pImage("images/icon_goto.png", 23.w, 23.w),
                              pSizeBoxW(24.w),
                            ],
                          )),
                    ),
                    pSizeBoxH(24.w),
                    Container(
                      height: 20.w,
                      color: Color(ColorConfig.color_f5f5f5),
                    ),

                    pSizeBoxH(24.w),
                  ],),
                ),
                Visibility(
                    visible:
                    ctl.saleOrder!.canceled == "CANCELED",
                    child: Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      top: 0,
                      child: Stack(
                        alignment:
                        Alignment.centerRight,
                        children: [
                          Container(
                              color: Color(ColorConfig
                                  .color_99ffffff)),
                          Container(
                            padding: EdgeInsets.only(
                                right: 24.w),
                            child: pImage(
                                "images/icon_canceled.png",
                                124.w,
                                124.w),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),



            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Map<String, dynamic> param = new Map();
                param[Constant.DEPT_ID] = ctl.deptId;
                param[Constant.ORDER_STOCK_ID] = ctl.saleOrder!.orderStock!.id;
                Get.toNamed(ArgUtils.map2String(
                    path: Routes.STOCK_DETAIL, arguments: param));
              },
              child: Row(
                children: [
                  pSizeBoxW(24.w),
                  pText('发货汇总', ColorConfig.color_333333, 28.w,
                      width: 115.w, alignment: Alignment.topLeft),
                  Expanded(
                    child: pText(
                        '发货出库单' +  orderSerial ,
                        ColorConfig.color_999999,
                        28.w,
                        width: 281.w,
                        alignment: Alignment.centerRight,
                        maxLines: 3,
                        textAlign: TextAlign.left),
                  ),
                  pSizeBoxW(19.w),
                  pImage("images/icon_goto.png", 23.w, 23.w),
                  pSizeBoxW(24.w),
                ],
              ),
            ),

            pSizeBoxH(24.w),
            Container(
              height: 20.w,
              color: Color(ColorConfig.color_f5f5f5),
            ),
            pSizeBoxH(24.w),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (ctl.saleAllOpenStatus.value) {
                  //收起
                  eventBus.fire(
                    new AddGoodsEvent(-1, tag: "deliveryList"),
                  );
                } else {
                  //全部展开
                  eventBus.fire(new AddGoodsEvent(-2, tag: "deliveryList"));
                }
                ctl.saleAllOpenStatus.toggle();
              },
              child: Row(
                children: [
                  pSizeBoxW(24.w),
                  pText('${ctl.saleOrder!.goodsNum!}件/${ctl.saleOrder!.goodsStyleNum!}款/¥${(ctl.saleOrder!.taxReceivableAmount!.toDouble()*0.01).toStringAsFixed(2)}', ColorConfig.color_333333, 28.w,
                      alignment: Alignment.topLeft,
                      fontWeight: FontWeight.bold),
                  Expanded(
                    child: Container(),
                  ),
                  pText('全部展开', ColorConfig.color_999999, 28.w),
                  pSizeBoxW(19.w),
                  pImage("images/icon_down_fulll.png", 23.w, 23.w),
                  pSizeBoxW(24.w),
                ],
              ),
            ),
            pSizeBoxH(24.w),
            Container(
              height: 1.w,
              color: Color(ColorConfig.color_efefef),
            ),
          ],
        ));
  });
}

updateRemark(_context, DeliveryDetailController ctl) {
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_) {
        return CustomDialog(
          title: '备注',
          type: 0,
          value: ctl.saleOrder!.remark ?? "",
          confirmCallback: (value) {
            SaleApi.updateDeliveryOrderRemark(ctl.saleOrder!.id!, value)
                .then((v) {
              ctl.saleOrder!.remark = value;
              ctl.update(["deliveryOrderRemark"]);
            });
          },
        );
      });
}

//编辑
edit(DeliveryDetailController ctl) async {
  if (!await DeptConfigUtils.checkOrderTime(DeptConfigUtils.ORDER_DELIVERY_EDIT_1, ctl.saleOrder!.customizeTime!)) {
    toastMsg("不能编辑\n已超店铺设置的可编辑天数");
    return;
  }
  Get.offAndToNamed(ArgUtils.map2String(path: Routes.DELIVER_DIRECT, arguments: {
    Constant.ORDER_ID: ctl.deliveryOrderId,
    Constant.DEPT_ID: ctl.deptId,
    Constant.CUSTOMER_ID: ctl.saleOrder?.customerId,
  }));
}

//撤销
cancel(DeliveryDetailController ctl) async {
  if (!await DeptConfigUtils.checkOrderTime(DeptConfigUtils.ORDER_DELIVERY_EDIT_1, ctl.saleOrder!.customizeTime!)) {
    toastMsg("不能撤销\n已超店铺设置的可编辑天数");
    return;
  }
  if (ctl.saleOrder!.canceled == CanceledEnum.CANCELED) {
    toastMsg("单据已撤销");
    return;
  }
  showDialog(
      context: Get.context as BuildContext,
      builder: (_) {
        return CustomDialog(
          type: 1,
          confirmContent: "确定撤销",
          confirmTextColor: ColorConfig.color_1678ff,
          content: pText("确定撤销吗？", ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w600),
          confirmCallback: (value) {
            SaleApi.canceledDelivery(ctl.saleOrder!.id as int, showLoading: true).then((v) {
              if (v) {
                ctl.saleOrder!.canceled = CanceledEnum.CANCELED;
                ctl.update(["cancelIcon","deliveryorderInfo"]);
              }
            });
          },
        );
      });

}
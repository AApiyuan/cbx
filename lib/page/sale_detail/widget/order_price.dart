
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/sale/widget/discount_widget.dart';
import 'package:haidai_flutter_module/page/sale_detail/controller/sale_detail_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget orderPrice() {
  return GetBuilder<SaleDetailController>(builder: (ctl) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 16.w, color: Color(ColorConfig.color_f5f5f5)),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 30.w, 24.w, 30.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.w, color: Color(ColorConfig.color_efefef)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          pText('本单总额', ColorConfig.color_333333, 24.w, width: 106.w, alignment: Alignment.centerLeft),
                          pText(PriceUtils.getPrice(ctl.saleOrder!.taxReceivableAmount), ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w500)
                        ],
                      ),
                      pSizeBoxH(16.w),
                      Row(
                        children: [
                          pText('已抹零', ColorConfig.color_999999, 24.w, width: 106.w, alignment: Alignment.centerLeft),
                          pText(
                            PriceUtils.getPrice(ctl.saleOrder!.wipeOffAmount),
                            ColorConfig.color_999999,
                            28.w,
                          ),
                          pSizeBoxW(24.w),
                          pText(
                            '抹零',
                            ColorConfig.color_333333,
                            24.w,
                            width: 68.w,
                            height: 36.w,
                            borderColor: ColorConfig.color_333333,
                            radius: 4.w,
                            onTap: () => showWipeZero(Get.context!, ctl.saleOrder?.wipeOffAmount ?? 0,
                                (zero) => ctl.updateOrderBase(wipeOffAmount: zero).then((value) => ctl.updateDetail())),
                          )
                        ],
                      ),
                      pSizeBoxH(16.w),
                      Row(
                        children: [
                          pText('已核销', ColorConfig.color_999999, 24.w, width: 106.w, alignment: Alignment.centerLeft),
                          pText(
                            PriceUtils.getPrice(ctl.saleOrder!.checkAmount),
                            ColorConfig.color_999999,
                            28.w,
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Row(children: [
                      Row(
                        children: [
                          pText('本单结欠', ColorConfig.color_999999, 24.w, width: 106.w, alignment: Alignment.centerLeft),
                          pText(PriceUtils.getPrice(ctl.saleOrder!.balanceAmount), ColorConfig.color_ff7f00, 28.w, fontWeight: FontWeight.w500),
                        ],
                      ),
                    ]),
                    pSizeBoxH(30.w),
                    Visibility(
                        visible: ctl.saleOrder!.balanceAmount != 0,
                        child: pText("收款核销", ColorConfig.color_1678ff, 24.w,
                            height: 56.w, width: 130.w, borderColor: ColorConfig.color_1678ff, radius: 4.w, onTap: () {
                          Get.offNamed(ArgUtils.map2String(
                            path: Routes.SALE_REMIT,
                            arguments: {
                              Constant.DEPT_ID: ctl.deptId,
                              Constant.ORDER_SALE_ID: ctl.saleOrder!.id,
                              Constant.CUSTOMER_ID: ctl.saleOrder!.customerId,
                              Constant.AMOUNT: ctl.saleOrder!.balanceAmount, //结欠金额
                              Constant.SALE_ORDER_TO: true,
                            },
                          ))?.then((value) {
                            if (value == "update") {
                              ctl.updateDetail();
                            }
                          });
                          // MethodChannel(ChannelConfig.flutterToNative).invokeMethod(ChannelConfig.methodGatheringOrder, jsonEncode(ctl.saleOrder));
                        })),

                  ])
                ],
              ),
            )
          ],
        ));
  });
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/model/enum/CustomerUserStatusEnum.dart';
import 'package:haidai_flutter_module/page/sale_detail/controller/sale_detail_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/merchandiser_select.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget orderCheck() {
  return GetBuilder<SaleDetailController>(builder: (ctl) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 0.w, 24.w, 0.w),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.w, color: Color(ColorConfig.color_f5f5f5)))),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0.w, 30.w, 0.w, 30.w),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.w, color: Color(ColorConfig.color_efefef)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pText("开单：${ctl.saleOrder!.createUserName}", ColorConfig.color_333333, 28.w),
                    pSizeBoxH(18.w),
                    pText(
                        "#${int.parse(ctl.saleOrder!.orderSaleSerial!.substring(6, ctl.saleOrder!.orderSaleSerial!.length))} ${ctl.saleOrder!.customizeTime!.substring(5, ctl.saleOrder!.customizeTime!.length)}",
                        ColorConfig.color_999999,
                        28.w),
                  ],
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showCupertinoModalBottomSheet(
                        context: Get.context!,
                        animationCurve: Curves.easeIn,
                        builder: (context) => MerchandiserSelect(
                              deptId: ctl.saleOrder!.deptId as int,
                              statusEnum: CustomerUserStatusEnum.ENABLE,
                              selectMerchandiserId: ctl.saleOrder!.merchandiserId,
                              callBack: (int selectMerchandiserId, String selectedMerchandiserName) {
                                ctl.updateOrderBase(merchandiserId: selectMerchandiserId).then((value) {
                                  ctl.saleOrder!.merchandiserId = selectMerchandiserId;
                                  ctl.saleOrder!.merchandiserName = selectedMerchandiserName;
                                  ctl.update(['merchandiserName']);
                                });
                              },
                            ));
                  },
                  child: Row(
                    children: [
                      GetBuilder<SaleDetailController>(
                          id: "merchandiserName",
                          builder: (ctl) {
                            return pText("跟单：${ctl.saleOrder!.merchandiserName}", ColorConfig.color_999999, 24.w);
                          }),
                      pImage('images/icon_goto.png', 22.w, 22.w)
                    ],
                  ),
                )
              ],
            ),
          ),
          GetBuilder<SaleDetailController>(
              id: "orderCheck",
              builder: (ctl) {
                return Column(children: [
                  ListView.builder(
                      itemCount: ctl.checks.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Visibility(
                            visible: index == 0 || (index > 0 && !ctl.openCheck.value),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0.w, 30.w, 0.w, 15.w),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.w, color: Color(ColorConfig.color_efefef)))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: ctl.checks[index].remitDetailDo!.remitRecordMethodList == null
                                    ? CrossAxisAlignment.center
                                    : (ctl.checks[index].remitDetailDo!.remitRecordMethodList!.length == 1
                                        ? CrossAxisAlignment.center
                                        : CrossAxisAlignment.start),
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          pText("核销本单", ColorConfig.color_333333, 28.w),
                                          pSizeBoxW(10.w),
                                          pText("-${PriceUtils.getPrice(ctl.checks[index].amount)}", ColorConfig.color_999999, 28.w),
                                        ],
                                      ),
                                      pSizeBoxH(18.w),
                                      pText(
                                          "#${int.parse(ctl.checks[index].orderRemitSerial!.substring(6, ctl.checks[index].orderRemitSerial!.length))} ${ctl.checks[index].remitDetailDo!.customizeTime!.substring(5, ctl.checks[index].remitDetailDo!.customizeTime!.length)}",
                                          ColorConfig.color_999999,
                                          28.w),
                                    ],
                                  ),
                                  Visibility(
                                    visible: ctl.checks[index].remitDetailDo!.remitRecordMethodList != null,
                                    child: Expanded(
                                        child: ctl.checks[index].remitDetailDo!.remitRecordMethodList != null
                                            ? ListView.builder(
                                                itemCount: ctl.checks[index].remitDetailDo!.remitRecordMethodList!.length,
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, i) {
                                                  var item = ctl.checks[index].remitDetailDo!.remitRecordMethodList![i];
                                                  return Container(
                                                      margin: EdgeInsets.only(bottom: 15.w),
                                                      alignment: Alignment.centerRight,
                                                      child: pText("${item.remitMethodName} ${PriceUtils.getPrice(item.amount)}",
                                                          ColorConfig.color_333333, 24.w));
                                                })
                                            : Container()),
                                  ),
                                ],
                              ),
                            ));
                      }),
                  Visibility(
                      visible: ctl.checks.length > 1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          ctl.openCheck.toggle();
                          ctl.update(['orderCheck']);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 85.w,
                          child: Obx(() => Container(
                              width: 180.w,
                              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                pText(ctl.openCheck.value ? '查看更多(${ctl.checks.length - 1})' : "收起", ColorConfig.color_999999, 24.w,
                                    fontWeight: FontWeight.w500),
                                pSizeBoxW(8.w),
                                pImage(ctl.openCheck.value ? "images/down_more.png" : "images/up_more.png", 30.w, 30.w)
                              ]))),
                        ),
                      ))
                ]);
              })
        ],
      ),
    );
  });
}

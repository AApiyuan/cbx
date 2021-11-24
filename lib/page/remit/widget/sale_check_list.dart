import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/remit/controller/remit_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget saleCheckList() {
  return GetBuilder<RemitController>(
      id: "saleCheckList",
      builder: (ctl) {
        return !ctl.isRefund.value
            ? SliverList(
                delegate: new SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Visibility(
                      visible: ctl.curMode.value != 2 || (ctl.curMode.value == 2 && ctl.selectIdMap[ctl.saleList[index].id] == true),
                      child: Container(
                        padding: EdgeInsets.only(left: 20.w, top: 30.w, right: 20.w, bottom: 30.w),
                        margin: EdgeInsets.only(left: 24.w, right: 24.w),
                        decoration: BoxDecoration(
                            color: Color(ColorConfig.color_ffffff),
                            border: Border(
                                bottom: BorderSide(color: Color(ColorConfig.color_efefef), width: (index != ctl.saleList.length - 1) ? 1.w : 0))),
                        height: 150.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Visibility(
                                      visible: ctl.saleList[index].id == ctl.curSaleOrderId,
                                      child: pImage("images/self.png", 56.w, 28.w),
                                    ),
                                    pText("销售单${ctl.saleList[index].orderSaleSerial}", ColorConfig.color_999999, 28.w),
                                  ],
                                ),
                                pText('${ctl.saleList[index].customizeTime}', ColorConfig.color_999999, 28.w),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GetBuilder<RemitController>(
                                    id: "amount" + ctl.saleList[index].id.toString(),
                                    builder: (ctl) {
                                      return pText(
                                          "核销￥${ctl.saleList[index].check != '' ? ctl.saleList[index].check : 0}", ColorConfig.color_FA6400, 28.w,
                                          fontWeight: FontWeight.w600);
                                    }),
                                Row(
                                  children: [
                                    pText('结欠', ColorConfig.color_999999, 28.w),
                                    pText('${PriceUtils.getPrice(ctl.saleList[index].balanceAmount)}', ColorConfig.color_999999, 28.w,
                                        fontWeight: FontWeight.w600),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ));
                }, childCount: ctl.saleList.length),
              )
            : SliverToBoxAdapter();
      });
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/sliver_app_bar_delegate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/sale_detail/controller/sale_detail_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget saleGoodsStatistic() {
  return GetBuilder<SaleDetailController>(builder: (ctl) {
    if (ctl.saleList.length > 0) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          minHeight: 170.w,
          maxHeight: 170.w,
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          backgroundColor: ColorConfig.color_ffffff,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (ctl.saleAllOpenStatus.value) {
                //收起
                eventBus.fire(
                  new AddGoodsEvent(-1, tag: "saleList"),
                );
              } else {
                //全部展开
                eventBus.fire(new AddGoodsEvent(-2, tag: "saleList"));
              }
              ctl.saleAllOpenStatus.toggle();
            },
            child: Container(
                height: 170.w,
                padding: EdgeInsets.fromLTRB(24.w, 30.w, 24.w, 30.w),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 16.w, color: Color(ColorConfig.color_f5f5f5)),
                        bottom: BorderSide(width: 1.w, color: Color(ColorConfig.color_efefef)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        pImage('images/sale_statistic.png', 82.w, 82.w),
                        pSizeBoxW(12.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            pText("${ctl.saleOrder!.normalSaleStyleNum}款${ctl.saleOrder!.normalSaleNum}件", ColorConfig.color_333333, 34.w,
                                fontWeight: FontWeight.w500),
                            Row(
                              children: [
                                pText(PriceUtils.getPrice(ctl.saleOrder!.normalSaleTaxAmount).toString(), ColorConfig.color_999999, 28.w),
                                pSizeBoxW(8.w),
                                Visibility(
                                    visible: ctl.saleOrder!.tax != 0,
                                    child: pText("税率${ctl.saleOrder!.tax!/100}", ColorConfig.color_999999, 20.w,
                                        height: 28.w,
                                        padding: EdgeInsets.only(left: 8.w, right: 8.w),
                                        radius: 4.w,
                                        borderColor: ColorConfig.color_999999))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Visibility(
                            visible: ctl.saleOrder!.shortageNum != 0,
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Color(ColorConfig.color_ff6146),
                                          borderRadius: BorderRadiusDirectional.only(
                                            bottomStart: Radius.circular(4.w),
                                            topStart: Radius.circular(4.w),
                                          )),
                                      alignment: Alignment.center,
                                      width: 28.w,
                                      height: 28.w,
                                      child: pText("欠", ColorConfig.color_ffffff, 20.w)),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Color(ColorConfig.color_ffebe7),
                                          borderRadius: BorderRadiusDirectional.only(
                                            bottomEnd: Radius.circular(4.w),
                                            topEnd: Radius.circular(4.w),
                                          )),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                                      height: 28.w,
                                      child:
                                          pText(ctl.saleOrder!.shortageNum.toString(), ColorConfig.color_ff3715, 20.w, fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Obx(() => Row(
                              children: [
                                pText(ctl.saleAllOpenStatus.value ? "全部收起" : "全部展开", ColorConfig.color_999999, 28.w),
                                pImage(ctl.saleAllOpenStatus.value ? "images/icon_up.png" : "images/icon_down.png", 32.w, 32.w)
                              ],
                            ))
                      ],
                    )
                  ],
                )),
          ),
        ),
      );
    } else {
      return SliverToBoxAdapter();
    }
  });
}

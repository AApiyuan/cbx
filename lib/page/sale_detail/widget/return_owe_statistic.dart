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

Widget returnOweStatistic() {
  return GetBuilder<SaleDetailController>(builder: (ctl) {
    if(ctl.oweList.length > 0){
      return  SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          minHeight: 170.w,
          maxHeight: 170.w,
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          backgroundColor: ColorConfig.color_ffffff,
          child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (ctl.oweAllOpenStatus.value) {
                  //收起
                  eventBus.fire(
                    new AddGoodsEvent(-1, tag: "returnOweList"),
                  );
                } else {
                  //全部展开
                  eventBus.fire(new AddGoodsEvent(-2, tag: "returnOweList"));
                }
                ctl.oweAllOpenStatus.toggle();
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          pImage('images/return_owe_statistic.png', 82.w, 82.w),
                          pSizeBoxW(12.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              pText("${ctl.saleOrder!.changeBackOrderGoodsStyleNum}款${ctl.saleOrder!.changeBackOrderGoodsNum!.abs()}件",
                                  ColorConfig.color_333333, 34.w,
                                  fontWeight: FontWeight.w500),
                              pText(PriceUtils.getPrice(ctl.saleOrder!.changeBackOrderGoodsTaxAmount).toString(), ColorConfig.color_999999, 28.w),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Obx(() => Row(
                            children: [
                              pText(ctl.oweAllOpenStatus.value ? "全部收起" : "全部展开", ColorConfig.color_999999, 28.w),
                              pImage(ctl.oweAllOpenStatus.value ? "images/icon_up.png" : "images/icon_down.png", 32.w, 32.w)
                            ],
                          ))
                        ],
                      )
                    ],
                  ))),
        ),
      );
    }else{
      return  SliverToBoxAdapter();
    }
  });
}

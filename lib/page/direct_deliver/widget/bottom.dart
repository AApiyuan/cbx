import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/direct_deliver/controller/direct_deliver_controller.dart';
import 'package:haidai_flutter_module/page/direct_deliver/widget/order_info.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget bottomWidget() {
  return Container(
    child: Row(
      children: [
        pSizeBoxW(24.w),
        GetBuilder<DirectDeliverController>(
          builder: (ctl) => pText(
            "${ctl.goodsStyleNum}款 ${ctl.goodsNumTotal}件",
            ColorConfig.color_1678FF,
            28.w,
            fontWeight: FontWeight.bold,
          ),
          id: DirectDeliverController.idStatement,
        ),
        pSizeBoxW(36.w),
        GestureDetector(
          child: pText("全部收起", ColorConfig.color_666666, 24.w),
          onTap: () => eventBus.fire(AddGoodsEvent(-1)),
          behavior: HitTestBehavior.opaque,
        ),
        pSizeBoxW(6.w),
        pImage("images/icon_down.png", 28.w, 22.w),
        Expanded(child: Container()),
        GetBuilder<DirectDeliverController>(
          builder: (ctl) => GestureDetector(
            child: Container(
              child: pText("一键全发", ColorConfig.color_1678FF, 32.w),
              alignment: Alignment.center,
              width: 194.w,
              color: Color(ColorConfig.color_efefef),
            ),
            onTap: () => ctl.fillAllGoods(),
          ),
        ),
        GestureDetector(
          child: Container(
            child: pText("发货", ColorConfig.color_ffffff, 32.w),
            alignment: Alignment.center,
            width: 194.w,
            color: Color(ColorConfig.color_1678FF),
          ),
          onTap: () => _showOrderInfo(),
        ),
      ],
    ),
    height: 96.w,
  );
}

_showOrderInfo() {
  if (Get.find<DirectDeliverController>().goodsNumTotal <= 0)
    return toastMsg("请选择货品");
  showCupertinoModalBottomSheet(
    context: Get.context!,
    animationCurve: Curves.easeIn,
    builder: (context) => BottomSheetWidget(
      title: "单据信息",
      showCertain: false,
      height: 1400.w,
      child: orderInfoWidget(),
    ),
  );
}

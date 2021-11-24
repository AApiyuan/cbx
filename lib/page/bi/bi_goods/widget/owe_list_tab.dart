import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_owe_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

oweListTab(Function update) {
  return Container(
    margin: EdgeInsets.only(top: 20.w),
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
      ),
      color: Color(ColorConfig.color_393a58),
    ),
    child: Column(
      children: [
        pSizeBoxH(50.w),
        _tab(update),
        pSizeBoxH(30.w),
      ],
    ),
  );
}

_tab(Function update) {
  return GetBuilder<BiGoodsOweController>(
    builder: (ctl) => CustomerTab(
      tabs: ["欠货货品", "有库存货品"],
      change: (index) {
        update.call();
        ctl.updateListType(index);
      },
      margin: EdgeInsets.only(left: 26.w, right: 26.w),
      height: 56.w,
      radius: 8.w,
      labelStyle: TextStyle(fontSize: 26.w),
      labelColor: ColorConfig.color_ffffff,
      unselectedLabelStyle: TextStyle(fontSize: 26.w),
      contentBackgroundColor: Color(ColorConfig.color_333551),
    ),
  );
}

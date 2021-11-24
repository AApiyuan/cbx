import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

saleListTab(Function update, TabController tabController) {
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
        _tab(update, tabController),
        pSizeBoxH(30.w),
      ],
    ),
  );
}

_tab(Function update, TabController tabController) {
  return GetBuilder<BiGoodsController>(
    builder: (ctl) => CustomerTab(
      tabs: ["销售分析", "退欠货", "退实物", "总交易"],
      change: (index) {
        update.call();
        ctl.updateListType(index);
      },
      margin: EdgeInsets.only(left: 26.w, right: 26.w),
      height: 56.w,
      radius: 8.w,
      tabController: tabController,
      labelStyle: TextStyle(fontSize: 26.w),
      labelColor: ColorConfig.color_ffffff,
      unselectedLabelStyle: TextStyle(fontSize: 26.w),
      contentBackgroundColor: Color(ColorConfig.color_333551),
    ),
  );
}

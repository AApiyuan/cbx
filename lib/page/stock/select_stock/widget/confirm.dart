import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/controller/select_stock_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget confirm() {
  return GetBuilder<SelectStockController>(
      id: "confirm",
      builder: (ctl) {
        return Container(
          decoration: new BoxDecoration(
              color: Color(ColorConfig.color_ffffff), border: Border(top: BorderSide(color: Color(ColorConfig.color_efefef), width: 2.w))),
          height: 152.w,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 16.w, bottom: 40.w),
          child: pActionText(ctl.selectedIds.length == 0 ? '复制入库单去调拨' : '复制入库单去调拨  (' + ctl.selectedIds.length.toString() + ")",
              ColorConfig.color_ffffff, 28.w, 700.w, 96.w, () {
            ctl.returnSelect();
          }, background: ColorConfig.color_1678ff, radius: 50.w),
        );
      });
}

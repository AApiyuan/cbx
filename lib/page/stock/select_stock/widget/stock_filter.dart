import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/controller/select_stock_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/widget/order_status_select.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/date_range_pick.dart';
import 'package:haidai_flutter_module/widget/drawer_dialog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import 'order_type_select.dart';

Widget stockFilter(Function change) {
  return GetBuilder<SelectStockController>(
      id: "filter",
      builder: (ctl) {
        return Container(
          height: 94.w,
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  orderTypeSelect(() {
                    change.call();
                  }),
                  pSizeBoxW(57.w),
                  orderStatusSelect(() {
                    change.call();
                  })
                ],
              ),
              DateRangePick(
                defaultRange: 30,
                onCertain: (String start, String end) {
                  ctl.startTime = start;
                  ctl.endTime = end;
                  change.call();
                },
              ),
            ],
          ),
        );
      });
}

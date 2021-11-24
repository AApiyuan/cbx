import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/sliver_app_bar_delegate.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/controller/bi_dept_user_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/bi/widget/date_select.dart';


Widget deptUserSaleStaticTitle() {
  return GetBuilder<BiDeptUserController>(builder: (ctl) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            minHeight: 56.w,
            maxHeight: 56.w,
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            backgroundColor: 0x00ffffff,
            child: DateSelect(callback: (String startTime, String endTime) {
              ctl.statisticStartTime = startTime;
              ctl.statisticEndTime = endTime;
              ctl.updateStatistic();
            }, startTime: ctl.statisticStartTime, endTime: ctl.statisticEndTime,)));
  });
}
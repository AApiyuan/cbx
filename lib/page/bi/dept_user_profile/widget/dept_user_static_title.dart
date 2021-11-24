import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/sliver_app_bar_delegate.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/controller/dept_user_profile_controller.dart';
import 'package:haidai_flutter_module/page/bi/widget/date_select.dart';

Widget deptUserStaticTitle() {
  return GetBuilder<DeptUserProfileController>(builder: (ctl) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            minHeight: 56.w,
            maxHeight: 56.w,
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            backgroundColor: 0x00ffffff,
            child: DateSelect(
                startTime: ctl.statisticStartTime,
                endTime: ctl.statisticEndTime,
                callback: (String startTime, String endTime) {
                  ctl.statisticStartTime = startTime;
                  ctl.statisticEndTime = endTime;
                  ctl.pageNo = 1;
                  ctl.updateStatistic();
                })));
  });
}

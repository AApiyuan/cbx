import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/controller/dept_user_profile_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget deptUserInfo() {
  return GetBuilder<DeptUserProfileController>(
      id: "deptUserInfo",
      builder: (ctl) {
        return Container(
          width: double.infinity,
          child: Row(
            children: [
              Container(
                  width: 92.w,
                  height: 92.w,
                  margin: EdgeInsets.only(top: 16.w, bottom: 16.w, left: 24.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.all(Radius.circular(46.w))),
                  child: Container(
                    width: 90.w,
                    height: 90.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Color(ColorConfig.color_282940), borderRadius: BorderRadius.all(Radius.circular(45.w))),
                    child: pText(ctl.userInfo != null ? ctl.userInfo!.customerUserDo!.name.toString() : '--', ColorConfig.color_ffffff, 28.w,
                        fontWeight: FontWeight.bold),
                  )),
              pSizeBoxW(12.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pText(
                      "${ctl.userInfo != null ? ctl.userInfo!.customerUserDo!.name.toString() : '--'}${ctl.userInfo != null ? ctl.userInfo!.customerUserDo!.bindPhone.toString() : '--'}(${ctl.userInfo != null ? (ctl.userInfo!.status == CanceledEnum.ENABLE ? '在职' : '离职') : '--'})",
                      ColorConfig.color_ffffff,
                      32.w),
                  pSizeBoxH(22.w),
                  pText("${ctl.userInfo != null ? ctl.userInfo!.deptName.toString() : '--'}", 0xb3ffffff, 24.w),
                ],
              )
            ],
          ),
        );
      });
}

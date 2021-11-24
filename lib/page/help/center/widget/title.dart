import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/help/center/controller/help_center_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget title() {
  return GetBuilder<HelpCenterController>(
      id: "title",
      builder: (ctl) {
        return Container(
          height: 484.w,
          decoration: new BoxDecoration(
              image: new DecorationImage(image: AssetImage("images/help_center_banner.png"), fit: BoxFit.cover),
              border: Border(bottom: BorderSide(color: Color(ColorConfig.color_ffffff), width: 0.w))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 80.w, left: 24.w),
                  child: IconButton(
                      iconSize: 34.w,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Color(ColorConfig.color_ffffff),
                      ),
                      onPressed: () {
                        BackUtils.back();
                      })),
              Container(
                decoration: BoxDecoration(
                    color: Color(ColorConfig.color_ffffff),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30.w), topLeft: Radius.circular(30.w))),
                height: 106.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        pSizeBoxW(28.w),
                        pImage("images/crown_img.png", 58.w, 58.w),
                        pSizeBoxW(28.w),
                        Visibility(
                          visible: ctl.deptId == null,
                          child: pText("八大模块灵活选配", ColorConfig.color_333333, 24.w, fontWeight: FontWeight.w600),
                        ),
                        Visibility(
                          visible: ctl.deptId != null && ctl.deptDetail != null && ctl.deptDetail!.baseExpiryDate == null,
                          child: pText("未激活专业版", ColorConfig.color_666666, 24.w),
                        ),
                        Visibility(
                            visible: ctl.deptId != null && ctl.deptDetail != null && ctl.deptDetail!.baseExpiryDate != null,
                            child: pImage("images/profession.png", 114.w, 38.w)),

                      ],
                    ),
                    Container(
                        width: 400.w,
                        height: 106.w,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 24.w),
                        decoration: new BoxDecoration(image: new DecorationImage(image: AssetImage("images/help_center_bg1.png"), fit: BoxFit.cover)),
                        child:
                        Visibility(
                            visible: ctl.deptId != null ,
                            child: pText('${ctl.deptName}',ColorConfig.color_666666,28.w))
                        // Visibility(
                        //     visible: ctl.deptId != null && ctl.deptDetail != null && ctl.deptDetail!.firstActivatedTime != null,
                        //     child: pText("${ctl.deptDetail != null ? ctl.deptDetail!.firstActivatedTime : ''}", ColorConfig.color_333333, 24.w,
                        //         fontWeight: FontWeight.w600)),
                        )
                  ],
                ),
              )
            ],
          ),
        );
      });
}

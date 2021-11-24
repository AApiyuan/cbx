
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/controller/dept_user_profile_controller.dart';
import 'package:haidai_flutter_module/page/bi/model/enum/bi_select_type_enum.dart';
import 'package:haidai_flutter_module/page/bi/widget/colum_chart.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget deptUserChart() {
  return GetBuilder<DeptUserProfileController>(
      id: "deptUserChart",
      builder: (ctl) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(0.w, 50.w, 0.w, 24.w),
          margin: EdgeInsets.only(top: 20.w,bottom: 20.w),
          decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
          child: Container(
            child: Column(
              children: [
                CustomerTab(
                    type: 1,
                    tabs: ["每日", "每周", "每月"],
                    height: 50.w,
                    width: 400.w,
                    radius: 8.w,
                    labelStyle: TextStyle(fontSize: 32.w, color: Color(ColorConfig.color_ffffff), fontWeight: FontWeight.w600),
                    unselectedLabelStyle: TextStyle(fontSize: 32.w, color: Color.fromRGBO(255, 255, 255, 0.7)),
                    contentBackgroundColor: Color.fromRGBO(57, 58, 88, 0.5),
                    change: (index) {
                      if (index == 0) {
                        if (ctl.selectType != BiSelectTypeEnum.DAY) {
                          ctl.selectType = BiSelectTypeEnum.DAY;
                          ctl.customizeStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(15)); //默认开始时间
                          ctl.xRotation = 0;
                          ctl.updateDeptUserChart();
                        }
                      }
                      if (index == 1) {
                        if (ctl.selectType != BiSelectTypeEnum.WEEK) {
                          ctl.selectType = BiSelectTypeEnum.WEEK;
                          ctl.customizeStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(12 * 7)); //默认开始时间
                          ctl.xRotation = 60;
                          ctl.updateDeptUserChart();
                        }
                      }
                      if (index == 2) {
                        if (ctl.selectType != BiSelectTypeEnum.MOUTH) {
                          ctl.customizeStartTime = TimeUtils.getStartOfDay(TimeUtils.getDateBefore(12 * 30)); //默认开始时间
                          ctl.selectType = BiSelectTypeEnum.MOUTH;
                          ctl.xRotation = 0;
                          ctl.updateDeptUserChart();
                        }
                      }
                    }),
                pSizeBoxH(50.w),
                GetBuilder<DeptUserProfileController>(
                    id: "deptChart",
                    builder: (ctl) {
                      return ColumnChart(
                        chartData: ctl.deptUserChartData,
                        xName: 'timeTitleShorthand',
                        yName: ctl.viewSale,
                        height: 500.w,
                        xRotation: ctl.xRotation,
                        yTitle: ctl.yTitle,
                      );
                    }),
                pSizeBoxH(24.w),
                CustomerTab(
                    tabs: ["销售数", "销售金额", "销售单数"],
                    height: 56.w,
                    width: 540.w,
                    radius: 8.w,
                    labelColor: ColorConfig.color_ffffff,
                    labelStyle: TextStyle(fontSize: 26.w),
                    unselectedLabelStyle: TextStyle(fontSize: 26.w),
                    contentBackgroundColor: Color(ColorConfig.color_333551),
                    change: (index) {
                      if (index == 0) {
                        //交易数
                        if (ctl.viewSale != "normalSaleGoodsNum") {
                          ctl.viewSale = "normalSaleGoodsNum";
                          if (ctl.numShowWan) {
                            ctl.yTitle = "万件";
                          } else {
                            ctl.yTitle = "件 ";
                          }
                          ctl.update(['deptUserChart']);
                        }
                      }
                      if (index == 1) {
                        //交易额
                        if (ctl.viewSale != "normalSaleTaxAmount") {
                          ctl.viewSale = "normalSaleTaxAmount";
                          if (ctl.showWan) {
                            ctl.yTitle = "万元";
                          } else {
                            ctl.yTitle = "元";
                          }
                          ctl.update(['deptUserChart']);
                        }
                      }
                      if (index == 2) {
                        //交易额
                        if (ctl.viewSale != "orderSaleNum") {
                          ctl.viewSale = "orderSaleNum";
                          ctl.yTitle = "单";
                          ctl.update(['deptUserChart']);
                        }
                      }
                    })
              ],
            ),
          ),
        );
      });
}

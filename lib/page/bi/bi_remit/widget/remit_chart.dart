import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/controller/bi_remit_controller.dart';
import 'package:haidai_flutter_module/page/bi/model/enum/bi_select_type_enum.dart';
import 'package:haidai_flutter_module/page/bi/widget/colum_chart.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget remitChart() {
  return GetBuilder<BiRemitController>( builder: (ctl) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(0.w, 50.w, 0.w, 24.w),
      margin: EdgeInsets.only(bottom: 45.w),
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
                      ctl.xRotation = 0;
                      ctl.updateRemitChart();
                    }
                  }
                  if (index == 1) {
                    if (ctl.selectType != BiSelectTypeEnum.WEEK) {
                      ctl.selectType = BiSelectTypeEnum.WEEK;
                      ctl.xRotation = 60;
                      ctl.updateRemitChart();
                    }
                  }
                  if (index == 2) {
                    if (ctl.selectType != BiSelectTypeEnum.MOUTH) {
                      ctl.selectType = BiSelectTypeEnum.MOUTH;
                      ctl.xRotation = 0;
                      ctl.updateRemitChart();
                    }
                  }
                }),
            pSizeBoxH(50.w),
            GetBuilder<BiRemitController>(
                id: "remitChart",
                builder: (ctl) {
                  return ColumnChart(
                    chartData: ctl.deptRemitChartData,
                    xName: 'timeTitleShorthand',
                    yName: ctl.viewSale,
                    height: 500.w,
                    xRotation: ctl.xRotation,
                    yTitle: ctl.yTitle,
                  );
                }),
            pSizeBoxH(24.w),
            CustomerTab(
                tabs: ["收款", "退款"],
                height: 56.w,
                width: 280.w,
                radius: 8.w,
                labelColor: ColorConfig.color_ffffff,
                labelStyle: TextStyle(fontSize: 26.w),
                unselectedLabelStyle: TextStyle(fontSize: 26.w),
                contentBackgroundColor: Color(ColorConfig.color_333551),
                change: (index) {
                  if (index == 0) {
                    //交易数
                    if (ctl.viewSale != "receivedAmount") {
                      ctl.viewSale = "receivedAmount";
                      ctl.update(['deptChart']);
                      if (ctl.receiveShowWan) {
                        ctl.yTitle = "万元";
                      } else {
                        ctl.yTitle = "元";
                      }
                    }
                  }
                  if (index == 1) {
                    //交易额
                    if (ctl.viewSale != "refundAmount") {
                      ctl.viewSale = "refundAmount";
                      ctl.update(['deptChart']);
                      if (ctl.refundShowWan) {
                        ctl.yTitle = "万元";
                      } else {
                        ctl.yTitle = "元";
                      }
                    }
                  }
                  // ctl.updateRemitChart();
                  ctl.update(["remitChart"]);
                })
          ],
        ),
      ),
    );
  });
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/controller/bi_dept_user_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/controller/bi_remit_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/bi/widget/ChartData.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget deptUserChart() {
  return GetBuilder<BiDeptUserController>(
      id: "deptUserChart",
      builder: (ctl) {
        return Visibility(
            visible: ctl.deptId != null,
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0.w, 50.w, 0.w, 24.w),
                margin: EdgeInsets.only(bottom: 20.w, top: 20.w),
                decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 0.w),
                      child: Row(
                        children: [
                          Container(
                              width: 350.w,
                              height: 350.w,
                              child: SfCircularChart(margin: EdgeInsets.zero, annotations: <CircularChartAnnotation>[
                                CircularChartAnnotation(widget: Container(child: pText(ctl.totalStr, ColorConfig.color_ffffff, 28.w)))
                              ], series: <CircularSeries>[
                                DoughnutSeries<CircleChartData, String>(
                                    dataSource: ctl.deptUserChartData,
                                    strokeWidth: 4.w,
                                    xValueMapper: (CircleChartData data, _) => data.x,
                                    yValueMapper: (CircleChartData data, _) => data.y,
                                    pointColorMapper: (CircleChartData data, _) => data.color,
                                    innerRadius: '80%'
                                    // Radius of doughnut
                                    )
                              ])),
                          Expanded(
                              child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                //解决无限高度问题
                                physics: new NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 15.w),
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 12.w,
                                            height: 12.w,
                                            decoration: BoxDecoration(
                                                color: ctl.deptUserChartData[index].color, borderRadius: BorderRadius.all(Radius.circular(12.w)))),
                                        pText(ctl.deptUserChartData[index].x, ColorConfig.color_ffffff, 24.w,
                                            width: 140.w, margin: EdgeInsets.only(left: 10.w), alignment: Alignment.centerLeft),
                                        pText(ctl.deptUserChartData[index].info.toString(), ColorConfig.color_ffffff, 24.w,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: ctl.deptUserChartData.length,
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    pSizeBoxH(20.w),
                    CustomerTab(
                        tabs: ["销售数", "销售金额", "销售单数"],
                        height: 56.w,
                        width: 450.w,
                        radius: 8.w,
                        labelColor: ColorConfig.color_ffffff,
                        labelStyle: TextStyle(fontSize: 26.w),
                        unselectedLabelStyle: TextStyle(fontSize: 26.w),
                        contentBackgroundColor: Color(ColorConfig.color_333551),
                        change: (index) {
                          if (index == 0) {
                            //销售数
                            if (ctl.viewMethod != "normalSaleGoodsNum") {
                              ctl.viewMethod = "normalSaleGoodsNum";
                              ctl.changeToSaleNum();
                            }
                          }
                          if (index == 1) {
                            //销售额
                            if (ctl.viewMethod != "normalSaleTaxAmount") {
                              ctl.viewMethod = "normalSaleTaxAmount";
                              ctl.changeToSaleAmount();
                            }
                          }
                          if (index == 2) {
                            //销售单数
                            if (ctl.viewMethod != "orderSaleNum") {
                              ctl.viewMethod = "orderSaleNum";
                              ctl.changeOrderNum();
                            }
                          }
                        })
                  ],
                )));
      });
}

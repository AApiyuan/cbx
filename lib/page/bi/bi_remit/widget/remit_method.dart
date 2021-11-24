import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/controller/bi_remit_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/bi/widget/ChartData.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget remitMethod() {
  return GetBuilder<BiRemitController>(
      id: "remitMethod",
      builder: (ctl) {
        return Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(0.w, 50.w, 0.w, 24.w),
            margin: EdgeInsets.only(bottom: 20.w),
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
                                dataSource: ctl.remitMethodChartData,
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
                                            color: ctl.remitMethodChartData[index].color, borderRadius: BorderRadius.all(Radius.circular(12.w)))),
                                    pText(ctl.remitMethodChartData[index].x, ColorConfig.color_ffffff, 24.w,
                                        width: 140.w, margin: EdgeInsets.only(left: 10.w),alignment: Alignment.centerLeft),
                                    pText(ctl.remitMethodChartData[index].info.toString(), ColorConfig.color_ffffff, 24.w, fontWeight: FontWeight.w500),
                                  ],
                                ),
                              );
                            },
                            itemCount: ctl.remitMethodChartData.length,
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                pSizeBoxH(20.w),
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
                        if (ctl.viewMethod != "remit") {
                          ctl.viewMethod = "remit";
                          ctl.changeToRemit();
                        }
                      }
                      if (index == 1) {
                        //交易额
                        if (ctl.viewMethod != "Refund") {
                          ctl.viewMethod = "Refund";
                          ctl.changeToRefund();
                        }
                      }
                      // ctl.updateRemitChart();
                      ctl.update(["remitMethod"]);
                    })
              ],
            ));
      });
}

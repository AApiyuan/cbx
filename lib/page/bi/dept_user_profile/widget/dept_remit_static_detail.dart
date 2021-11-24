import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/controller/dept_user_profile_controller.dart';
import 'package:haidai_flutter_module/page/bi/widget/ChartData.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget deptRemitStaticDetail() {
  return GetBuilder<DeptUserProfileController>(
      id: "deptRemitStaticDetail",
      builder: (ctl) {
        return Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20.w,bottom: 20.w),
            padding: EdgeInsets.fromLTRB(30.w, 30.w, 30.w, 30.w),
            decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pText("收款总金额", 0xb3ffffff, 24.w),
                        pSizeBoxH(10.w),
                        pText(ctl.biRemitSumDo == null ? "--" : PriceUtils.getPrice(ctl.biRemitSumDo!.receivedAmount).toString(),
                            ColorConfig.color_1678ff, 36.w),
                        pSizeBoxH(35.w),
                        pText("退款总金额", 0xb3ffffff, 24.w),
                        pSizeBoxH(10.w),
                        pText(ctl.biRemitSumDo == null ? "--" : PriceUtils.getPrice(ctl.biRemitSumDo!.refundAmount).toString(),
                            ColorConfig.color_ff1a43, 36.w),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 120.w,
                                  height: 120.w,
                                  child: SfCircularChart(margin: EdgeInsets.zero, annotations: <CircularChartAnnotation>[
                                    CircularChartAnnotation(widget: Container(child: pText(ctl.rateStr, ColorConfig.color_ffffff, 28.w)))
                                  ], series: <CircularSeries>[
                                    DoughnutSeries<CircleChartData, String>(
                                        dataSource: ctl.remitChartData,
                                        strokeWidth: 4.w,
                                        xValueMapper: (CircleChartData data, _) => data.x,
                                        yValueMapper: (CircleChartData data, _) => data.y,
                                        pointColorMapper: (CircleChartData data, _) => data.color,
                                        innerRadius: '80%'
                                        // Radius of doughnut
                                        )
                                  ])),
                              pSizeBoxH(45.w),
                              pText(
                                  "合计收支：${ctl.biRemitSumDo == null ? '--' : PriceUtils.getPrice(ctl.biRemitSumDo!.receivedAmount! - ctl.biRemitSumDo!.refundAmount!)}",
                                  0xb3ffffff,
                                  24.w),
                            ],
                          ),
                        ],
                      )),
                )
              ],
            ));
      });
}

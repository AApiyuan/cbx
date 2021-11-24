import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/sliver_app_bar_delegate.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/controller/bi_sale_controller.dart';
import 'package:haidai_flutter_module/page/bi/widget/ChartData.dart';
import 'package:haidai_flutter_module/page/bi/widget/date_select.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget deptSaleStaticTitle() {
  return GetBuilder<BiSaleController>(builder: (ctl) {
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
              ctl.updateSaleStatistic();
            }, startTime: ctl.statisticStartTime, endTime: ctl.statisticEndTime,)));
  });
}

Widget deptSaleStaticDetail() {
  return GetBuilder<BiSaleController>(
      id: "deptSaleStaticDetail",
      builder: (ctl) {
        return Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20.w),
            padding: EdgeInsets.fromLTRB(30.w, 0.w, 30.w, 0.w),
            decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(0.w, 30.w, 0.w, 30.w),
                      decoration: BoxDecoration(
                          color: Color(ColorConfig.color_393a58), border: Border(bottom: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.1)))),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                pText("销售数量", 0xb3ffffff, 24.w),
                                pSizeBoxH(10.w),
                                pText(ctl.biSaleSumDo == null ? "--" : ctl.biSaleSumDo!.normalSaleGoodsNum.toString(), ColorConfig.color_1678ff, 36.w),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      pText("销售金额", 0xb3ffffff, 24.w),
                                      pSizeBoxH(10.w),
                                      pText(ctl.biSaleSumDo == null ? "--" : PriceUtils.getPrice(ctl.biSaleSumDo!.normalSaleTaxAmount).toString(),
                                          ColorConfig.color_1678ff, 36.w),
                                    ],
                                  ),
                                  pImage("images/circle_right.png", 38.w, 38.w)
                                ],
                              ))
                        ],
                      )),
                  onTap: () => toBiGoodsPage(ctl, BiGoodsController.SALE_LIST_TYPE_SALE),
                ),
                GestureDetector(
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(0.w, 30.w, 0.w, 30.w),
                      decoration: BoxDecoration(
                          color: Color(ColorConfig.color_393a58), border: Border(bottom: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.1)))),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                pText("退实物数量", 0xb3ffffff, 24.w),
                                pSizeBoxH(10.w),
                                Row(children: [
                                  pText(ctl.biSaleSumDo == null ? "--" : ctl.biSaleSumDo!.returnGoodsNum.toString(), ColorConfig.color_ff1a43, 36.w),
                                  pText("(次品${ctl.biSaleSumDo == null ? "--" : ctl.biSaleSumDo!.returnSubStandardGoodsNum})", ColorConfig.color_ffffff, 20.w),
                                ],)
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      pText("退实物金额", 0xb3ffffff, 24.w),
                                      pSizeBoxH(10.w),
                                      pText(ctl.biSaleSumDo == null ? "--" : PriceUtils.getPrice(ctl.biSaleSumDo!.returnAmount).toString(),
                                          ColorConfig.color_ff1a43, 36.w),
                                    ],
                                  ),
                                  pImage("images/circle_right.png", 38.w, 38.w)
                                ],
                              ))
                        ],
                      )),
                  onTap: () => toBiGoodsPage(ctl, BiGoodsController.SALE_LIST_TYPE_RETURN),
                ),
                GestureDetector(
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(0.w, 30.w, 0.w, 30.w),
                      decoration: BoxDecoration(
                          color: Color(ColorConfig.color_393a58), border: Border(bottom: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.1)))),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                pText("退欠货数量", 0xb3ffffff, 24.w),
                                pSizeBoxH(10.w),
                                pText(ctl.biSaleSumDo == null ? "--" : ctl.biSaleSumDo!.changeBackOrderGoodsNum.toString(), ColorConfig.color_ff7532,
                                    36.w),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      pText("退欠货金额", 0xb3ffffff, 24.w),
                                      pSizeBoxH(10.w),
                                      pText(ctl.biSaleSumDo == null ? "--" : PriceUtils.getPrice(ctl.biSaleSumDo!.changeBackOrderAmount).toString(),
                                          ColorConfig.color_ff7532, 36.w),
                                    ],
                                  ),
                                  pImage("images/circle_right.png", 38.w, 38.w)
                                ],
                              ))
                        ],
                      )),
                  onTap: () => toBiGoodsPage(ctl, BiGoodsController.SALE_LIST_TYPE_OWE),
                ),
                GestureDetector(
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(0.w, 30.w, 0.w, 30.w),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                pText("总交易数量", 0xb3ffffff, 24.w),
                                pSizeBoxH(10.w),
                                pText(
                                    "=" + (ctl.biSaleSumDo == null ? "--" : ctl.biSaleSumDo!.saleGoodsNum.toString()), ColorConfig.color_ffffff, 36.w),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      pText("总交易金额", 0xb3ffffff, 24.w),
                                      pSizeBoxH(10.w),
                                      pText("=" + (ctl.biSaleSumDo == null ? "--" : PriceUtils.getPrice(ctl.biSaleSumDo!.saleTaxAmount).toString()),
                                          ColorConfig.color_ffffff, 36.w),
                                    ],
                                  ),
                                  pImage("images/circle_right.png", 38.w, 38.w)
                                ],
                              ))
                        ],
                      )),
                  behavior: HitTestBehavior.opaque,
                  onTap: () => toBiGoodsPage(ctl, BiGoodsController.SALE_LIST_TYPE_TOTAL),
                ),
              ],
            ));
      });
}

toBiGoodsPage(BiSaleController ctl, int listType) {
  Get.toNamed(ArgUtils.map2String(path: Routes.BI_GOODS, arguments: {
    Constant.DEPT_ID: ctl.deptId,
    Constant.TOP_DEPT_ID: ctl.topDeptId,
    Constant.LIST_TYPE: listType,
    Constant.END_TIME: ctl.statisticEndTime,
    Constant.START_TIME: ctl.statisticStartTime,
  }));
}

Widget deptRemitStaticDetail() {
  return GetBuilder<BiSaleController>(
      id: "deptRemitStaticDetail",
      builder: (ctl) {
        return Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20.w),
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
                      onTap: () {
                        //跳转 收支详情
                        if(ctl.deptId!=null){
                          Get.toNamed(ArgUtils.map2String(
                            path: Routes.BI_DEPT_REMIT,
                            arguments: {
                              Constant.TOP_DEPT_ID: ctl.topDeptId,
                              Constant.DEPT_ID:ctl.deptId,
                              Constant.START_TIME:ctl.statisticStartTime,
                              Constant.END_TIME:ctl.statisticEndTime,
                            },
                          ));
                        }else{
                          Get.toNamed(ArgUtils.map2String(
                            path: Routes.BI_REMIT,
                            arguments: {
                              Constant.TOP_DEPT_ID: ctl.topDeptId,
                              Constant.START_TIME:ctl.statisticStartTime,
                              Constant.END_TIME:ctl.statisticEndTime,
                            },
                          ));
                        }

                      },
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
                          pImage("images/circle_right.png", 38.w, 38.w)
                        ],
                      )),
                )
              ],
            ));
      });
}

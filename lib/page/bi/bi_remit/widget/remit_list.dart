import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/controller/bi_remit_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget remitList() {
  return GetBuilder<BiRemitController>(
      id: "remitList",
      builder: (ctl) {
        return Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(0.w, 50.w, 0.w, 24.w),
            margin: EdgeInsets.only(bottom: 20.w),
            decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
            child: Column(
              children: [
                CustomerTab(
                    tabs: ["按收款账户", "按店铺"],
                    height: 56.w,
                    width: 340.w,
                    radius: 8.w,
                    labelColor: ColorConfig.color_ffffff,
                    labelStyle: TextStyle(fontSize: 26.w),
                    unselectedLabelStyle: TextStyle(fontSize: 26.w),
                    contentBackgroundColor: Color(ColorConfig.color_333551),
                    change: (index) {
                      if (index == 0) {
                        //交易数
                        if (ctl.viewList != "method") {
                          ctl.viewList = "method";
                          ctl.update(["remitList"]);
                        }
                      }
                      if (index == 1) {
                        //交易额
                        if (ctl.viewList != "dept") {
                          ctl.viewList = "dept";
                          ctl.update(["remitList"]);
                        }
                      }
                      // ctl.updateRemitChart();
                    }),
                Container(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  margin: EdgeInsets.only(top: 34.w),
                  height: 44.w,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Row(
                    children: [
                      Container(
                        width: 180.w,
                        alignment: Alignment.centerLeft,
                        child: pText(ctl.viewList == "method" ? "收款账户" : "店铺", 0xb3ffffff, 24.w),
                      ),
                      GestureDetector(
                          onTap: () {
                            if (ctl.orderByField == "receivedAmount") {
                              if (ctl.orderBy == "DESC") {
                                ctl.orderBy = "ASC";
                              } else if (ctl.orderBy == "ASC") {
                                ctl.orderBy = "DESC";
                              }
                            } else {
                              ctl.orderByField = "receivedAmount";
                              ctl.orderBy = "DESC";
                            }
                            ctl.sort();
                            ctl.update(['remitMethodList']);
                          },
                          child: Container(
                            width: 150.w,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                pText("收款", ctl.orderByField == "receivedAmount" ? ColorConfig.color_ffffff : 0xbbffffff, 24.w),
                                pImage(
                                    ctl.orderByField == "receivedAmount"
                                        ? (ctl.orderBy == "DESC" ? "images/down_sort.png" : "images/up_sort.png")
                                        : "images/no_sort.png",
                                    24.w,
                                    24.w)
                              ],
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            if (ctl.orderByField == "refundAmount") {
                              if (ctl.orderBy == "DESC") {
                                ctl.orderBy = "ASC";
                              } else if (ctl.orderBy == "ASC") {
                                ctl.orderBy = "DESC";
                              }
                            } else {
                              ctl.orderByField = "refundAmount";
                              ctl.orderBy = "DESC";
                            }
                            ctl.sort();
                            ctl.update(['remitMethodList']);
                          },
                          child: Container(
                            width: 150.w,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                pText("退款", ctl.orderByField == "refundAmount" ? ColorConfig.color_ffffff : 0xbbffffff, 24.w),
                                pImage(
                                    ctl.orderByField == "refundAmount"
                                        ? (ctl.orderBy == "DESC" ? "images/down_sort.png" : "images/up_sort.png")
                                        : "images/no_sort.png",
                                    24.w,
                                    24.w)
                              ],
                            ),
                          )),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              if (ctl.orderByField == "totalAmount") {
                                if (ctl.orderBy == "DESC") {
                                  ctl.orderBy = "ASC";
                                } else if (ctl.orderBy == "ASC") {
                                  ctl.orderBy = "DESC";
                                }
                              } else {
                                ctl.orderByField = "totalAmount";
                                ctl.orderBy = "DESC";
                              }
                              ctl.sort();
                              ctl.update(['remitMethodList']);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  pText("合计", ctl.orderByField == "totalAmount" ? ColorConfig.color_ffffff : 0xbbffffff, 24.w),
                                  pImage(
                                      ctl.orderByField == "totalAmount"
                                          ? (ctl.orderBy == "DESC" ? "images/down_sort.png" : "images/up_sort.png")
                                          : "images/no_sort.png",
                                      24.w,
                                      24.w)
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                GetBuilder<BiRemitController>(
                    id: "remitMethodList",
                    builder: (ctl) {
                      return Visibility(
                          visible: ctl.viewList == "method",
                          child: Container(
                              child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            //解决无限高度问题
                            physics: new NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Container(
                                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                                margin: EdgeInsets.only(top: 40.w),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 180.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText(ctl.methodsList[index].remitMethodName.toString(), ColorConfig.color_ffffff, 24.w),
                                    ),
                                    Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText((ctl.methodsList[index].receivedAmount / 100).toString(), ColorConfig.color_1678ff, 24.w),
                                    ),
                                    Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText((ctl.methodsList[index].refundAmount / 100).toString(), ColorConfig.color_ff1a43, 24.w),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: pText(((ctl.methodsList[index].totalAmount) / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: ctl.methodsList.length,
                          )));
                    }),
                GetBuilder<BiRemitController>(
                    id: "remitDeptList",
                    builder: (ctl) {
                      return Visibility(
                          visible: ctl.viewList == "dept",
                          child: Container(
                              child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            //解决无限高度问题
                            physics: new NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Container(
                                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                                margin: EdgeInsets.only(top: 40.w),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 180.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText(ctl.deptRemitData[index].deptName.toString(), ColorConfig.color_ffffff, 24.w),
                                    ),
                                    Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText((ctl.deptRemitData[index].receivedAmount / 100).toString(), ColorConfig.color_1678ff, 24.w),
                                    ),
                                    Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText((ctl.deptRemitData[index].refundAmount / 100).toString(), ColorConfig.color_ff1a43, 24.w),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: pText((ctl.deptRemitData[index].totalAmount / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: ctl.deptRemitData.length,
                          )));
                    })
              ],
            ));
      });
}

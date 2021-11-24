import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/controller/bi_sale_detail_controller.dart';
import 'package:haidai_flutter_module/page/bi/widget/date_select.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget deptSaleDetailTile() {
  return GetBuilder<BiSaleDetailController>(
      id: "deptSaleDetailTile",
      builder: (ctl) {
        return Container(
          width: double.infinity,
          height: 127.w,
          margin: EdgeInsets.only(top: 20.w),
          decoration: BoxDecoration(color: Color.fromRGBO(57, 58, 88, 0.5), borderRadius: BorderRadius.all(Radius.circular(16.w))),
          child: Column(
            children: [
              DateSelect(callback: (String startTime, String endTime) {
                ctl.statisticStartTime = startTime;
                ctl.statisticEndTime = endTime;
                ctl.init();
              }, startTime: ctl.statisticStartTime, endTime: ctl.statisticEndTime,),
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            if (ctl.orderByField == "saleTaxAmount") {
                              if (ctl.orderBy == "DESC") {
                                ctl.orderBy = "ASC";
                              } else if (ctl.orderBy == "ASC") {
                                ctl.orderBy = "DESC";
                              }
                            } else {
                              ctl.orderByField = "saleTaxAmount";
                              ctl.orderBy = "DESC";
                            }
                            ctl.sort();
                            ctl.update(['deptSaleDetailTile']);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 65.w,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                pText("交易额", ctl.orderByField == "saleTaxAmount" ? ColorConfig.color_ffffff : 0xbbffffff, 24.w),
                                pImage(
                                    ctl.orderByField == "saleTaxAmount"
                                        ? (ctl.orderBy == "DESC" ? "images/down_sort.png" : "images/up_sort.png")
                                        : "images/no_sort.png",
                                    24.w,
                                    24.w)
                              ],
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
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
                            ctl.update(['deptSaleDetailTile']);
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                pText("收支额", ctl.orderByField == "receivedAmount" ? ColorConfig.color_ffffff : 0xbbffffff, 24.w),
                                pImage(
                                    ctl.orderByField == "receivedAmount"
                                        ? (ctl.orderBy == "DESC" ? "images/down_sort.png" : "images/up_sort.png")
                                        : "images/no_sort.png",
                                    24.w,
                                    24.w)
                              ],
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            if (ctl.orderByField == "shortageNum") {
                              if (ctl.orderBy == "DESC") {
                                ctl.orderBy = "ASC";
                              } else if (ctl.orderBy == "ASC") {
                                ctl.orderBy = "DESC";
                              }
                            } else {
                              ctl.orderByField = "shortageNum";
                              ctl.orderBy = "DESC";
                            }
                            ctl.sort();
                            ctl.update(['deptSaleDetailTile']);
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                pText("欠货数", ctl.orderByField == "shortageNum" ? ColorConfig.color_ffffff : 0xbbffffff, 24.w),
                                pImage(
                                    ctl.orderByField == "shortageNum"
                                        ? (ctl.orderBy == "DESC" ? "images/down_sort.png" : "images/up_sort.png")
                                        : "images/no_sort.png",
                                    24.w,
                                    24.w)
                              ],
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            if (ctl.orderByField == "oweAmount") {
                              if (ctl.orderBy == "DESC") {
                                ctl.orderBy = "ASC";
                              } else if (ctl.orderBy == "ASC") {
                                ctl.orderBy = "DESC";
                              }
                            } else {
                              ctl.orderByField = "oweAmount";
                              ctl.orderBy = "DESC";
                            }
                            ctl.sort();
                            ctl.update(['deptSaleDetailTile']);
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                pText("欠款额", ctl.orderByField == "oweAmount" ? ColorConfig.color_ffffff : 0xbbffffff, 24.w),
                                pImage(
                                    ctl.orderByField == "oweAmount"
                                        ? (ctl.orderBy == "DESC" ? "images/down_sort.png" : "images/up_sort.png")
                                        : "images/no_sort.png",
                                    24.w,
                                    24.w)
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/controller/bi_dept_user_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget deptUserSaleList() {
  return GetBuilder<BiDeptUserController>(builder: (ctl) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(0.w, 50.w, 0.w, 24.w),
        margin: EdgeInsets.only(bottom: 20.w, top: 20.w),
        decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
        child: Column(
          children: [
            CustomerTab(
                tabs: ["销量", "退欠货", "退实物", "总交易", "总收支"],
                height: 56.w,
                width: 650.w,
                radius: 8.w,
                labelColor: ColorConfig.color_ffffff,
                labelStyle: TextStyle(fontSize: 26.w),
                unselectedLabelStyle: TextStyle(fontSize: 26.w),
                contentBackgroundColor: Color(ColorConfig.color_333551),
                change: (index) {
                  if (index == 0) {
                    //销售
                    if (ctl.viewList != "sale") {
                      ctl.viewList = "sale";
                      ctl.orderBy = "DESC";
                      ctl.orderByField = "normalSaleGoodsNum";
                      ctl.changeView();
                    }
                  }
                  if (index == 1) {
                    //退欠货
                    if (ctl.viewList != "returnOwe") {
                      ctl.viewList = "returnOwe";
                      ctl.orderBy = "DESC";
                      ctl.orderByField = "changeBackOrderGoodsNum";
                      ctl.changeView();
                    }
                  }
                  if (index == 2) {
                    //退实物
                    if (ctl.viewList != "returnGoods") {
                      ctl.viewList = "returnGoods";
                      ctl.orderBy = "DESC";
                      ctl.orderByField = "returnGoodsNum";

                      ctl.changeView();
                    }
                  }
                  if (index == 3) {
                    //总交易
                    if (ctl.viewList != "saleTotal") {
                      ctl.viewList = "saleTotal";
                      ctl.orderBy = "DESC";
                      ctl.orderByField = "saleGoodsNum";
                      ctl.changeView();
                    }
                  }
                  if (index == 4) {
                    //总收支
                    if (ctl.viewList != "remit") {
                      ctl.viewList = "remit";
                      ctl.orderBy = "DESC";
                      ctl.orderByField = "receivedAmount";
                      ctl.changeView();
                    }
                  }
                }),
            GetBuilder<BiDeptUserController>(
                id: "deptUserSaleListTitle",
                builder: (ctl) {
                  return Container(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    margin: EdgeInsets.only(top: 34.w),
                    height: 44.w,
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    child: Row(
                      children: [
                        Container(
                          width: 70.w,
                          alignment: Alignment.centerLeft,
                          child: pText("序号", 0xb3ffffff, 24.w),
                        ),
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: pText("店员", 0xb3ffffff, 24.w),
                        )),
                        Visibility(visible: ctl.viewList == "sale", child: sortTitleButton(ctl, "销量", "normalSaleGoodsNum")),
                        Visibility(visible: ctl.viewList == "sale", child: sortTitleButton(ctl, "销售额", "normalSaleTaxAmount")),
                        Visibility(visible: ctl.viewList == "returnOwe", child: sortTitleButton(ctl, "退欠货", "changeBackOrderGoodsNum")),
                        Visibility(visible: ctl.viewList == "returnOwe", child: sortTitleButton(ctl, "退欠货额", "changeBackOrderAmount")),
                        Visibility(visible: ctl.viewList == "returnGoods", child: sortTitleButton(ctl, "退实物", "returnGoodsNum")),
                        Visibility(visible: ctl.viewList == "returnGoods", child: sortTitleButton(ctl, "退实物额", "returnAmount")),
                        Visibility(visible: ctl.viewList == "saleTotal", child: sortTitleButton(ctl, "交易数", "saleGoodsNum")),
                        Visibility(visible: ctl.viewList == "saleTotal", child: sortTitleButton(ctl, "交易额", "saleTaxAmount")),
                        Visibility(visible: ctl.viewList == "remit", child: sortTitleButton(ctl, "收入", "receivedAmount")),
                        Visibility(visible: ctl.viewList == "remit", child: sortTitleButton(ctl, "支出", "refundAmount")),
                        pSizeBoxW(16.w)
                      ],
                    ),
                  );
                }),
            GetBuilder<BiDeptUserController>(
                id: "deptUserSaleList",
                builder: (ctl) {
                  return Container(
                      child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    //解决无限高度问题
                    physics: new NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Get.toNamed(ArgUtils.map2String(
                              path: Routes.DEPT_USER_PROFILE,
                              arguments: {
                                Constant.DEPT_USER_ID: ctl.deptUserSaleDataFilter[index].merchandiserId,
                                Constant.DEPT_ID: ctl.deptUserSaleDataFilter[index].deptId,
                                Constant.TOP_DEPT_ID: ctl.topDeptId,
                                Constant.START_TIME:ctl.statisticStartTime,
                                Constant.END_TIME:ctl.statisticEndTime
                              },
                            ));
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
                            margin: EdgeInsets.only(left: 30.w, right: 30.w),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1.w,
                                        color: index != ctl.deptUserSaleDataFilter.length - 1
                                            ? Color.fromRGBO(255, 255, 255, 0.1)
                                            : Colors.transparent))),
                            child: Row(
                              children: [
                                Container(
                                  width: 70.w,
                                  alignment: Alignment.centerLeft,
                                  child: pText(
                                      (index + 1).toString(),
                                      index == 0 ? 0xFFFF521F : (index == 1 ? 0xFFFF9228 : (index == 2 ? 0xFFFFD02E : ColorConfig.color_ffffff)),
                                      28.w,
                                      fontFamily: "Roboto"),
                                ),
                                Expanded(
                                    child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      pText(ctl.deptUserSaleDataFilter[index].merchandiserName.toString(), ColorConfig.color_ffffff, 24.w),
                                      Visibility(
                                        visible: ctl.deptId == null,
                                        child: pSizeBoxH(5.w),
                                      ),
                                      Visibility(
                                        visible: ctl.deptId == null,
                                        child: pText(ctl.deptUserSaleDataFilter[index].deptName.toString(), 0xb3ffffff, 24.w),
                                      )
                                    ],
                                  ),
                                )),
                                Visibility(
                                    visible: ctl.viewList == "sale",
                                    child: Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText((ctl.deptUserSaleDataFilter[index].normalSaleGoodsNum).toString(), ColorConfig.color_ffffff, 24.w),
                                    )),
                                Visibility(
                                    visible: ctl.viewList == "sale",
                                    child: Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText(
                                          (ctl.deptUserSaleDataFilter[index].normalSaleTaxAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                    )),
                                Visibility(
                                    visible: ctl.viewList == "returnOwe",
                                    child: Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText(
                                          (ctl.deptUserSaleDataFilter[index].changeBackOrderGoodsNum).toString(), ColorConfig.color_ffffff, 24.w),
                                    )),
                                Visibility(
                                    visible: ctl.viewList == "returnOwe",
                                    child: Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText((ctl.deptUserSaleDataFilter[index].changeBackOrderAmount! / 100).toString(),
                                          ColorConfig.color_ffffff, 24.w),
                                    )),
                                Visibility(
                                    visible: ctl.viewList == "returnGoods",
                                    child: Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText((ctl.deptUserSaleDataFilter[index].returnGoodsNum).toString(), ColorConfig.color_ffffff, 24.w),
                                    )),
                                Visibility(
                                    visible: ctl.viewList == "returnGoods",
                                    child: Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child:
                                          pText((ctl.deptUserSaleDataFilter[index].returnAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                    )),
                                Visibility(
                                    visible: ctl.viewList == "saleTotal",
                                    child: Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText((ctl.deptUserSaleDataFilter[index].saleGoodsNum).toString(), ColorConfig.color_ffffff, 24.w),
                                    )),
                                Visibility(
                                    visible: ctl.viewList == "saleTotal",
                                    child: Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child:
                                          pText((ctl.deptUserSaleDataFilter[index].saleTaxAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                    )),
                                Visibility(
                                    visible: ctl.viewList == "remit",
                                    child: Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child:
                                          pText((ctl.deptUserSaleDataFilter[index].receivedAmount / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                    )),
                                Visibility(
                                    visible: ctl.viewList == "remit",
                                    child: Container(
                                      width: 150.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText((ctl.deptUserSaleDataFilter[index].refundAmount / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                    )),
                                pImage("images/right.png", 16.w, 16.w)
                              ],
                            ),
                          ));
                    },
                    itemCount: ctl.deptUserSaleDataFilter.length,
                  ));
                }),
          ],
        ));
  });
}

Widget sortTitleButton(BiDeptUserController ctl, String name, String filed) {
  return GestureDetector(
      onTap: () {
        if (ctl.orderByField == filed) {
          if (ctl.orderBy == "DESC") {
            ctl.orderBy = "ASC";
          } else if (ctl.orderBy == "ASC") {
            ctl.orderBy = "DESC";
          }
        } else {
          ctl.orderByField = filed;
          ctl.orderBy = "DESC";
        }
        ctl.sort();
      },
      child: Container(
        width: 150.w,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            pText(name, ctl.orderByField == filed ? ColorConfig.color_ffffff : 0xbbffffff, 24.w),
            pImage(ctl.orderByField == filed ? (ctl.orderBy == "DESC" ? "images/down_sort.png" : "images/up_sort.png") : "images/no_sort.png", 24.w,
                24.w)
          ],
        ),
      ));
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/sliver_app_bar_delegate.dart';
import 'package:haidai_flutter_module/page/bi/customer_profile/controller/customer_profile_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget customerSortTitle() {
  return GetBuilder<CustomerProfileController>(builder: (ctl) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            minHeight: 210.w,
            maxHeight: 210.w,
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            backgroundColor: 0x00ffffff,
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0.w, 50.w, 0.w, 24.w),
                decoration: BoxDecoration(
                    color: Color(ColorConfig.color_393a58),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20.w), topLeft: Radius.circular(20.w))),
                child: Column(
                  children: [
                    CustomerTab(
                        tabs: ["货品喜好", "分类喜好", "欠货货品"],
                        height: 56.w,
                        width: 640.w,
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
                              ctl.pageNo = 1; //页码

                              ctl.updateRecord();
                            }
                          }
                          if (index == 1) {
                            //欠款客户
                            if (ctl.viewList != "classify") {
                              ctl.viewList = "classify";
                              ctl.orderBy = "DESC";
                              ctl.pageNo = 1; //页码

                              ctl.orderByField = "normalSaleGoodsNum";
                              ctl.updateRecord();
                            }
                          }
                          if (index == 2) {
                            //欠货货品
                            if (ctl.viewList != "oweGoods") {
                              ctl.viewList = "oweGoods";
                              ctl.orderBy = "DESC";
                              ctl.orderByField = "shortageNum";
                              ctl.pageNo = 1; //页码
                              ctl.updateRecord();
                            }
                          }
                        }),
                    GetBuilder<CustomerProfileController>(
                        id: "customerSortTitle",
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
                                  child: pText((ctl.viewList == "sale" || ctl.viewList == "oweGoods") ? "货品" : "分类", 0xb3ffffff, 24.w),
                                )),
                                Visibility(visible: ctl.viewList == "sale", child: sortTitleButton(ctl, "销量", "normalSaleGoodsNum")),
                                Visibility(visible: ctl.viewList == "sale", child: sortTitleButton(ctl, "销售额", "normalSaleTaxAmount")),
                                Visibility(visible: ctl.viewList == "classify", child: sortTitleButton(ctl, "销量", "normalSaleGoodsNum")),
                                Visibility(visible: ctl.viewList == "classify", child: sortTitleButton(ctl, "销售额", "normalSaleTaxAmount")),
                                Visibility(visible: ctl.viewList == "oweGoods", child: sortTitleButton(ctl, "欠货数", "shortageNum")),
                                Visibility(visible: ctl.viewList == "oweGoods", child: sortTitleButton(ctl, "欠货额", "shortageAmount")),
                              ],
                            ),
                          );
                        }),
                  ],
                ))));
  });
}

Widget sortTitleButton(CustomerProfileController ctl, String name, String filed) {
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
        ctl.pageNo = 1; //页码
        ctl.updateRecord();
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

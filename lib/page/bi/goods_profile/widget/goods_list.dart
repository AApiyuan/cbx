import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/controller/goods_profile_controller.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/widget/dept_sale_static_detail.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/widget/goods_chart.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/widget/goods_info.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/widget/goods_sort_title.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/widget/goods_stock_statistic.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_customer_do_entity.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import 'goods_static_title.dart';

Widget goodsList() {
  return GetBuilder<GoodsProfileController>(builder: (ctl) {
    return EasyRefresh.custom(
        enableControlFinishLoad: false,
        controller: ctl.refreshController,
        footer: RefreshUtils.defaultFooter(),
        onLoad: () async {
          await Future.delayed(Duration(seconds: 1), () {
            ctl.pageNo++;
            ctl.updateRecord();
          });
        },
        slivers: <Widget>[
          //信息
          SliverToBoxAdapter(child: goodsInfo()),
          //欠货
          SliverToBoxAdapter(child: goodsStockStatistic()),
          // 柱状图
          SliverToBoxAdapter(child: goodsChart()),
          goodsStaticTitle(),
          //各种销售统计
          SliverToBoxAdapter(child: deptSaleStaticDetail()),
          goodsSortTitle(),
          GetBuilder<GoodsProfileController>(
              id: "goodsList",
              builder: (ctl) {
                if (ctl.viewList == "sale" || ctl.viewList == "oweNumCustomer") {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          padding: EdgeInsets.only(top: 20.w, bottom: 0.w, left: 30.w, right: 30.w),
                          decoration: BoxDecoration(
                              color: Color(ColorConfig.color_393a58),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(index != ctl.goodsRecords.length - 1 ? 0.w : 20.w),
                                  bottomLeft: Radius.circular(index != ctl.goodsRecords.length - 1 ? 0.w : 20.w))),
                          child: Container(
                              padding: EdgeInsets.only(bottom: 20.w),
                              decoration: BoxDecoration(
                                  color: Color(ColorConfig.color_393a58),
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.w,
                                          color: index != ctl.goodsRecords.length - 1 ? Color.fromRGBO(255, 255, 255, 0.1) : Colors.transparent))),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      width: 70.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText(
                                          (index + 1).toString(),
                                          index == 0 ? 0xFFFF521F : (index == 1 ? 0xFFFF9228 : (index == 2 ? 0xFFFFD02E : ColorConfig.color_ffffff)),
                                          28.w,
                                          fontFamily: "Roboto"),
                                    ),
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => toCustomerProfile(ctl.goodsRecords[index], ctl),
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: pText((ctl.goodsRecords[index].customerName).toString(), ColorConfig.color_ffffff, 24.w),
                                        ),
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () => toCustomerProfile(ctl.goodsRecords[index], ctl),
                                      )),
                                  Visibility(
                                      visible: ctl.viewList == "sale",
                                      child: GestureDetector(
                                        child: Container(
                                          width: 150.w,
                                          alignment: Alignment.centerLeft,
                                          child: pText((ctl.goodsRecords[index].normalSaleGoodsNum).toString(), ColorConfig.color_ffffff, 24.w),
                                        ),
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () => toSkuDetail(ctl.goodsRecords[index], ctl),
                                      )),
                                  Visibility(
                                      visible: ctl.viewList == "sale",
                                      child: GestureDetector(
                                        child: Container(
                                          width: 150.w,
                                          alignment: Alignment.centerLeft,
                                          child: pText((ctl.goodsRecords[index].normalSaleTaxAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                        ),
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () => toSkuDetail(ctl.goodsRecords[index], ctl),
                                      )),
                                  Visibility(
                                      visible: ctl.viewList == "oweNumCustomer",
                                      child: GestureDetector(
                                        child: Container(
                                          width: 150.w,
                                          alignment: Alignment.centerLeft,
                                          child: pText((ctl.goodsRecords[index].shortageNum).toString(), ColorConfig.color_ffffff, 24.w),
                                        ),
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () => toSkuDetail(ctl.goodsRecords[index], ctl),
                                      )),
                                  Visibility(
                                      visible: ctl.viewList == "oweNumCustomer",
                                      child: GestureDetector(
                                        child: Container(
                                          width: 150.w,
                                          alignment: Alignment.centerLeft,
                                          child: pText((ctl.goodsRecords[index].shortageAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                        ),
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () => toSkuDetail(ctl.goodsRecords[index], ctl),
                                      ))
                                ],
                              )),
                        );
                      },
                      childCount: ctl.goodsRecords.length,
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          padding: EdgeInsets.only(top: 20.w, bottom: 0.w, left: 30.w, right: 30.w),
                          decoration: BoxDecoration(
                              color: Color(ColorConfig.color_393a58),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(index != ctl.deptRecords.length - 1 ? 0.w : 20.w),
                                  bottomLeft: Radius.circular(index != ctl.deptRecords.length - 1 ? 0.w : 20.w))),
                          child: Container(
                              padding: EdgeInsets.only(bottom: 20.w),
                              decoration: BoxDecoration(
                                  color: Color(ColorConfig.color_393a58),
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.w,
                                          color: index != ctl.deptRecords.length - 1 ? Color.fromRGBO(255, 255, 255, 0.1) : Colors.transparent))),
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
                                    child: pText((ctl.deptRecords[index].deptName).toString(), ColorConfig.color_ffffff, 24.w),
                                  )),
                                  Visibility(
                                      visible: ctl.viewList == "deptSale",
                                      child: Container(
                                        width: 150.w,
                                        alignment: Alignment.centerLeft,
                                        child: pText((ctl.goodsRecords[index].normalSaleGoodsNum).toString(), ColorConfig.color_ffffff, 24.w),
                                      )),
                                  Visibility(
                                      visible: ctl.viewList == "deptSale",
                                      child: Container(
                                        width: 150.w,
                                        alignment: Alignment.centerLeft,
                                        child: pText((ctl.goodsRecords[index].normalSaleTaxAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                      )),
                                ],
                              )),
                        );
                      },
                      childCount: ctl.deptRecords.length,
                    ),
                  );
                }
              })
        ]);
  });
}

toCustomerProfile(BiSaleGoodsGroupCustomerDoEntity data, GoodsProfileController controller) {
  return Get.toNamed(ArgUtils.map2String(path: Routes.CUSTOMER_PROFILE, arguments: {
    Constant.TOP_DEPT_ID: controller.topDeptId,
    Constant.CUSTOMER_ID: data.customerId,
    Constant.DEPT_ID: data.deptId,
    Constant.START_TIME: controller.statisticStartTime,
    Constant.END_TIME: controller.statisticEndTime,
  }));
}

toSkuDetail(BiSaleGoodsGroupCustomerDoEntity data, GoodsProfileController controller) {
  return Get.toNamed(ArgUtils.map2String(path: Routes.BI_SKU, arguments: {
    Constant.TOP_DEPT_ID: controller.topDeptId,
    Constant.GOODS_ID: controller.goodsId,
    Constant.DEPT_ID: data.deptId,
  }));
}
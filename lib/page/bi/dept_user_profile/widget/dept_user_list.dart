import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/controller/dept_user_profile_controller.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/widget/dept_user_sort_title.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/widget/dept_remit_static_detail.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/widget/dept_sale_static_detail.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/widget/dept_user_chart.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/widget/dept_user_info.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/widget/dept_user_owe_statistic.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import 'dept_user_static_title.dart';

Widget deptUserList() {
  return GetBuilder<DeptUserProfileController>(builder: (ctl) {
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
          SliverToBoxAdapter(child: deptUserInfo()),
          //欠货
          SliverToBoxAdapter(child: deptUserOweStatistic()),
          // 柱状图
          SliverToBoxAdapter(child: deptUserChart()),
          deptUserStaticTitle(),
          //各种销售统计
          SliverToBoxAdapter(child: deptSaleStaticDetail()),
          //收款统计
          SliverToBoxAdapter(child: deptRemitStaticDetail()),
          deptUserSortTitle(),
          GetBuilder<DeptUserProfileController>(
              id: "deptUserList",
              builder: (ctl) {
                if (ctl.viewList == "sale" || ctl.viewList == "oweGoods") {
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
                                    alignment: Alignment.centerLeft,
                                    child: Row(children: [
                                      NetImageWidget(
                                        (ctl.goodsRecords[index].imgPath ?? "") + "/" + (ctl.goodsRecords[index].cover ?? ""),
                                        height: 64,
                                        width: 64,
                                      ),
                                      pSizeBoxW(12.w),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          Get.toNamed(ArgUtils.map2String(
                                            path: Routes.GOODS_PROFILE,
                                            arguments: {
                                              Constant.TOP_DEPT_ID: ctl.topDeptId,
                                              Constant.GOODS_ID: ctl.goodsRecords[index].goodsId,
                                              Constant.DEPT_ID: ctl.deptId,
                                              Constant.START_TIME: ctl.statisticStartTime,
                                              Constant.END_TIME: ctl.statisticEndTime,
                                            },
                                          ));
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            pText(ctl.goodsRecords[index].goodsSerial.toString(), ColorConfig.color_ffffff, 24.w,
                                                width: 190.w, alignment: Alignment.centerLeft),
                                            pSizeBoxH(5.w),
                                            pText(ctl.goodsRecords[index].goodsName.toString(), 0xb3ffffff, 24.w,
                                                width: 190.w, alignment: Alignment.centerLeft),
                                          ],
                                        ),
                                      )
                                    ]),
                                  )),
                                  GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        Get.toNamed(ArgUtils.map2String(
                                          path: Routes.BI_SKU,
                                          arguments: {
                                            Constant.TOP_DEPT_ID: ctl.topDeptId,
                                            Constant.GOODS_ID: ctl.goodsRecords[index].goodsId,
                                            Constant.DEPT_ID: ctl.deptId,
                                          },
                                        ));
                                      },
                                      child: Row(
                                        children: [
                                          Visibility(
                                              visible: ctl.viewList == "sale",
                                              child: Container(
                                                width: 150.w,
                                                alignment: Alignment.centerLeft,
                                                child: pText((ctl.goodsRecords[index].normalSaleGoodsNum).toString(), ColorConfig.color_ffffff, 24.w),
                                              )),
                                          Visibility(
                                              visible: ctl.viewList == "sale",
                                              child: Container(
                                                width: 150.w,
                                                alignment: Alignment.centerLeft,
                                                child: pText(
                                                    (ctl.goodsRecords[index].normalSaleTaxAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                              )),
                                          Visibility(
                                              visible: ctl.viewList == "oweGoods",
                                              child: Container(
                                                width: 150.w,
                                                alignment: Alignment.centerLeft,
                                                child: pText((ctl.goodsRecords[index].shortageNum).toString(), ColorConfig.color_ffffff, 24.w),
                                              )),
                                          Visibility(
                                              visible: ctl.viewList == "oweGoods",
                                              child: Container(
                                                width: 150.w,
                                                alignment: Alignment.centerLeft,
                                                child:
                                                    pText((ctl.goodsRecords[index].shortageAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                              ))
                                        ],
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
                                  bottomRight: Radius.circular(index != ctl.customerRecords.length - 1 ? 0.w : 20.w),
                                  bottomLeft: Radius.circular(index != ctl.customerRecords.length - 1 ? 0.w : 20.w))),
                          child: Container(
                              padding: EdgeInsets.only(bottom: 20.w),
                              decoration: BoxDecoration(
                                  color: Color(ColorConfig.color_393a58),
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.w,
                                          color: index != ctl.customerRecords.length - 1 ? Color.fromRGBO(255, 255, 255, 0.1) : Colors.transparent))),
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
                                    child: pText((ctl.customerRecords[index].customerName).toString(), ColorConfig.color_ffffff, 24.w),
                                  )),
                                  Visibility(
                                      visible: ctl.viewList == "oweAmountCustomer",
                                      child: Container(
                                        width: 150.w,
                                        alignment: Alignment.centerLeft,
                                        child: pText((ctl.customerRecords[index].orderOweAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                      )),
                                  Visibility(
                                      visible: ctl.viewList == "oweAmountCustomer",
                                      child: Container(
                                        width: 150.w,
                                        alignment: Alignment.centerLeft,
                                        child: pText((ctl.customerRecords[index].balance! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                      )),
                                  Visibility(
                                      visible: ctl.viewList == "oweAmountCustomer",
                                      child: Container(
                                        width: 150.w,
                                        alignment: Alignment.centerLeft,
                                        child: pText((ctl.customerRecords[index].oweAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                      )),
                                  Visibility(
                                      visible: ctl.viewList == "oweNumCustomer",
                                      child: Container(
                                        width: 150.w,
                                        alignment: Alignment.centerLeft,
                                        child: pText((ctl.customerRecords[index].shortageNum).toString(), ColorConfig.color_ffffff, 24.w),
                                      )),
                                  Visibility(
                                      visible: ctl.viewList == "oweNumCustomer",
                                      child: Container(
                                        width: 150.w,
                                        alignment: Alignment.centerLeft,
                                        child: pText((ctl.customerRecords[index].shortageAmount! / 100).toString(), ColorConfig.color_ffffff, 24.w),
                                      ))
                                ],
                              )),
                        );
                      },
                      childCount: ctl.customerRecords.length,
                    ),
                  );
                }
              })
        ]);
  });
}

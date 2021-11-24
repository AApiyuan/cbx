import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/controller/bi_sale_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget deptUserSaleTop10() {
  return GetBuilder<BiSaleController>(
      id: "deptUserSaleTop10",
      builder: (ctl) {
        return Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20.w),
            padding: EdgeInsets.fromLTRB(0.w, 30.w, 0.w, 30.w),
            decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
            child: Column(
              children: [
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Get.toNamed(ArgUtils.map2String(
                        path: Routes.BI_DEPT_USER,
                        arguments: {
                          Constant.TOP_DEPT_ID: ctl.topDeptId,
                          Constant.START_TIME: ctl.statisticStartTime,
                          Constant.END_TIME: ctl.statisticEndTime,
                        },
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [pText("店员销售业绩（TOP10）", ColorConfig.color_ffffff, 32.w), pImage("images/circle_right.png", 38.w, 38.w)],
                      ),
                    )),
                Container(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  height: 44.w,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  child: Row(
                    children: [
                      Container(
                        width: 70.w,
                        alignment: Alignment.centerLeft,
                        child: pText("序号", 0xb3ffffff, 24.w),
                      ),
                      Container(
                        width: 260.w,
                        alignment: Alignment.centerLeft,
                        child: pText("店员", 0xb3ffffff, 24.w),
                      ),
                      Container(
                        width: 128.w,
                        alignment: Alignment.centerLeft,
                        child: pText("交易数", 0xb3ffffff, 24.w),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: pText("交易额", 0xb3ffffff, 24.w),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Column(
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        //解决无限高度问题
                        physics: new NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return Container(
                              height: 124.w,
                              padding: EdgeInsets.only(bottom: 20.w, top: 20.w),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.w, color:index != ctl.userSales.length - 1? Color.fromRGBO(255, 255, 255, 0.1):Colors.transparent))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                  Container(
                                    width: 260.w,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        pText(ctl.userSales[index].merchandiserName.toString(), ColorConfig.color_ffffff, 24.w),
                                        pText(ctl.userSales[index].deptName.toString(), 0xb3ffffff, 24.w),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 128.w,
                                    alignment: Alignment.centerLeft,
                                    child: pText(ctl.userSales[index].saleGoodsNum.toString(), ColorConfig.color_ffffff, 24.w),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: pText(
                                          PriceUtils.getPrice(ctl.userSales[index].saleTaxAmount).toString(), ColorConfig.color_ffffff, 24.w),
                                    ),
                                  )
                                ],
                              ));
                        },
                        itemCount: ctl.userSales.length,
                      )
                    ],
                  ),
                )
              ],
            ));
      });
}

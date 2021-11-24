import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/controller/goods_profile_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget deptSaleStaticDetail() {
  return GetBuilder<GoodsProfileController>(
      id: "deptSaleStaticDetail",
      builder: (ctl) {
        return Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20.w, bottom: 20.w),
            decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(30.w, 30.w, 30.w, 30.w),
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
                              pText(ctl.biSaleGoodsSumDo == null ? "--" : ctl.biSaleGoodsSumDo!.normalSaleGoodsNum.toString(),
                                  ColorConfig.color_1678ff, 36.w),
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
                                    pText(
                                        ctl.biSaleGoodsSumDo == null
                                            ? "--"
                                            : PriceUtils.getPrice(ctl.biSaleGoodsSumDo!.normalSaleTaxAmount).toString(),
                                        ColorConfig.color_1678ff,
                                        36.w),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    )),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(30.w, 30.w, 30.w, 30.w),
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
                              Row(
                                children: [
                                  pText(ctl.biSaleGoodsSumDo == null ? "--" : ctl.biSaleGoodsSumDo!.returnGoodsNum.toString(),
                                      ColorConfig.color_ff1a43, 36.w),
                                  pText("(次品${ctl.biSaleGoodsSumDo == null ? "--" : ctl.biSaleGoodsSumDo!.returnSubStandardGoodsNum})",
                                      ColorConfig.color_ffffff, 20.w),
                                ],
                              )
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
                                    pText(ctl.biSaleGoodsSumDo == null ? "--" : PriceUtils.getPrice(ctl.biSaleGoodsSumDo!.returnAmount).toString(),
                                        ColorConfig.color_ff1a43, 36.w),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    )),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(30.w, 30.w, 30.w, 30.w),
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
                              pText(ctl.biSaleGoodsSumDo == null ? "--" : ctl.biSaleGoodsSumDo!.changeBackOrderGoodsNum.toString(),
                                  ColorConfig.color_ff7532, 36.w),
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
                                    pText(
                                        ctl.biSaleGoodsSumDo == null
                                            ? "--"
                                            : PriceUtils.getPrice(ctl.biSaleGoodsSumDo!.changeBackOrderAmount).toString(),
                                        ColorConfig.color_ff7532,
                                        36.w),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    )),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(30.w, 30.w, 30.w, 30.w),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              pText("总交易数量", 0xb3ffffff, 24.w),
                              pSizeBoxH(10.w),
                              pText("=" + (ctl.biSaleGoodsSumDo == null ? "--" : ctl.biSaleGoodsSumDo!.saleGoodsNum.toString()),
                                  ColorConfig.color_ffffff, 36.w),
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
                                    pText(
                                        "=" +
                                            (ctl.biSaleGoodsSumDo == null
                                                ? "--"
                                                : PriceUtils.getPrice(ctl.biSaleGoodsSumDo!.saleTaxAmount).toString()),
                                        ColorConfig.color_ffffff,
                                        36.w),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    )),
                GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Get.toNamed(
                        ArgUtils.map2String(
                          path: Routes.BI_SKU,
                          arguments: {
                            Constant.TOP_DEPT_ID: ctl.topDeptId,
                            Constant.GOODS_ID: ctl.goodsId,
                            Constant.DEPT_ID:
                            ctl.deptId != null ? ctl.deptId : null,
                          },
                        ),
                      );
                    },
                    child:
                    Container(
                      height: 60.w,
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      decoration: BoxDecoration(color: Color(ColorConfig.color_3f4064), borderRadius: BorderRadius.all(Radius.circular(20.w))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [pText("颜色SKU销售明细", 0xb3ffffff, 24.w), pImage("images/right.png", 16.w, 16.w)],
                      ),
                    ))
              ],
            ));
      });
}

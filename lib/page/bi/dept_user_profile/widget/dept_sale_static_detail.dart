import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/controller/dept_user_profile_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget deptSaleStaticDetail() {
  return GetBuilder<DeptUserProfileController>(
      id: "deptSaleStaticDetail",
      builder: (ctl) {
        return Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 20.w),
            padding: EdgeInsets.fromLTRB(30.w, 0.w, 30.w, 0.w),
            decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
            child: Column(
              children: [
                Container(
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
                              ],
                            ))
                      ],
                    )),
                Container(
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
                              ],)                            ],
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
                              ],
                            ))
                      ],
                    )),
                Container(
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
                              ],
                            ))
                      ],
                    )),
                Container(
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
                              pText("="+(ctl.biSaleSumDo == null ? "--" : ctl.biSaleSumDo!.saleGoodsNum.toString()), ColorConfig.color_ffffff, 36.w),
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
                                    pText("="+(ctl.biSaleSumDo == null ? "--" : PriceUtils.getPrice(ctl.biSaleSumDo!.saleTaxAmount).toString()),
                                        ColorConfig.color_ffffff, 36.w),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    )),
              ],
            ));
      });
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/customer/widget/customer_widget.dart';
import 'package:haidai_flutter_module/page/remit/controller/remit_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget customer() {
  return GetBuilder<RemitController>(
      id: "customer",
      builder: (ctl) {
        return Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: new DecorationImage(
              image: AssetImage("images/back1.png"),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                FutureBuilder(
                    future: ctl.initCustomer(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          height: 92.w,
                          width: double.infinity,
                          color: Colors.transparent,
                        );
                      } else {
                        return Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              customerLogo(ctl.customer!.customerName, ctl.customer!.levelTag,
                                  backgroundColor: ColorConfig.color_646582,
                                  borderColor: ColorConfig.color_ffffff,
                                  margin: EdgeInsets.only(right: 12.w, left: 44.w)),
                              pSizeBoxW(12.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pText("${ctl.customer!.customerName}${ctl.customer!.customerPhone ?? ""}", ColorConfig.color_ffffff, 32.w,
                                      fontWeight: FontWeight.w600),
                                  pSizeBoxH(22.w),
                                  Container(
                                      height: 36.w,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.fromLTRB(12.w, 0.w, 12.w, 0.w),
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(255, 255, 255, 0.25), borderRadius: BorderRadius.all(Radius.circular(20.w))),
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                        pText("总欠款", ColorConfig.color_ffffff, 24.w),
                                        pText("${PriceUtils.getPrice(ctl.customer!.oweAmount)}", ColorConfig.color_ffffff, 26.w,
                                            fontWeight: FontWeight.w600),
                                      ]))
                                ],
                              )
                            ],
                          ),
                        );
                      }
                    }),
                pSizeBoxH(40.w),
                GetBuilder<RemitController>(
                    id: "customer_balance",
                    builder: (ctl) {
                      return Container(
                        width: double.infinity,
                        height: 146.w,
                        margin: EdgeInsets.only(left: 24.w, right: 24.w),
                        padding: EdgeInsets.only(top: 28.w, bottom: 28.w),
                        decoration: BoxDecoration(color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.all(Radius.circular(20.w))),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  pText("${PriceUtils.getPrice(ctl.customer != null ? ctl.customer!.balance : 0)}", ColorConfig.color_333333, 36.w,
                                      fontWeight: FontWeight.w600),
                                  pText("账户余额", ColorConfig.color_999999, 24.w),
                                ],
                              ),
                            )),
                            VerticalDivider(
                              width: 4.w,
                              color: Color(ColorConfig.color_dcdcdc),
                            ),
                            Expanded(
                                child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  pText("${PriceUtils.getPrice(ctl.customer != null ? ctl.customer!.orderOweAmount : 0)}", ColorConfig.color_333333,
                                      36.w,
                                      fontWeight: FontWeight.w600),
                                  pText("历史单据结欠", ColorConfig.color_999999, 24.w),
                                ],
                              ),
                            ))
                          ],
                        ),
                      );
                    })
              ],
            ));
      });
}

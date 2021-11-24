import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../verification_logic.dart';


Widget userInfoCard(){
  return Column(
    children: [
      GetBuilder<VerificationLogic>(
          id: "first",
          builder: (ctl) {
            return Container(
              // margin: EdgeInsets.all(20.w),
              child: ListTile(
                leading: Stack(
                  alignment: AlignmentDirectional
                      .bottomEnd,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Color(ColorConfig
                              .color_595a77),
                          shape: BoxShape.circle,
                          border: new Border.all(
                              width: 1,
                              color:
                              Colors.white),
                        ),
                        height: 90.w,
                        width: 90.w,
                        child: Center(
                          child: pText(
                              "${ctl.avatarName}",
                              ColorConfig
                                  .color_ffffff,
                              28.w),
                        )),
                    Container(
                      height: 30.w,
                      width: 30.w,
                      child: Center(
                        child: pText(
                          "${ctl.levelTag}",
                          ColorConfig
                              .color_ffffff,
                          17.w,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(
                            ctl.levelTagColor),
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                ),
                title: pText(
                    "${ctl.customerName}",
                    ColorConfig.color_ffffff,
                    28.w,
                    textAlign: TextAlign.left),
                subtitle: pText(
                    "${ctl.oweAmount}",
                    ColorConfig.color_ffffff,
                    28.w,
                    textAlign: TextAlign.left),
              ),
              height: 100.w,
            );
          }),
      GetBuilder<VerificationLogic>(
          id: "second",
          builder: (ctl) {
            return Container(
                child: Card(
                    margin: EdgeInsets.all(20.w),
                    child: Row(
                      children: [
                        Container(
                            width: 350.w,
                            child: Column(
                              children: [
                                pText(
                                  "${ctl.balance}",
                                  ColorConfig
                                      .color_333333,
                                  32.w,
                                ),
                                pText(
                                  "账户余额",
                                  ColorConfig
                                      .color_999999,
                                  24.w,
                                ),
                              ],
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                            )),
                        VerticalDivider(
                          width: 9.w,
                        ),
                        Container(
                            width: 350.w,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                              children: [
                                pText(
                                  "${ctl.orderOweAmount}",
                                  ColorConfig
                                      .color_333333,
                                  32.w,
                                ),
                                pText(
                                  "历史合计单据结欠",
                                  ColorConfig
                                      .color_999999,
                                  24.w,
                                ),
                              ],
                            )),
                      ],
                    )),
                height: 150.w,
                width: 750.w);
          }),
    ],
  );
}


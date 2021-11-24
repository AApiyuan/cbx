import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'verification_mode_logic.dart';

class VerificationModePage extends StatefulWidget {
  @override
  _VerificationModePageState createState() => _VerificationModePageState();
}

class _VerificationModePageState extends State<VerificationModePage> {
  final logic = Get.find<VerificationModeLogic>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(ColorConfig.color_f5f5f5),
            appBar: pAppBar("核销模式", backFunc: () {
              BackUtils.back();
            }),
            body: GetBuilder<VerificationModeLogic>(builder: (ctl) {
              if (ctl.isOrderSaleId == true) {
                if (ctl.isPriority == true) {
                  return Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Column(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      pText(' 选择模式', ColorConfig.color_333333,
                                          28.w,
                                          textAlign: TextAlign.left),
                                      GestureDetector(
                                        child: Icon(Icons.check_circle),
                                        onTap: () {
                                          ctl.isPriority = !ctl.isPriority;
                                          ctl.update();
                                        },
                                      )
                                    ],
                                  ),
                                  Center(
                                    child: pActionText(
                                        "${ctl.orderTitleMap["CONFIG_NUCLEAR_1_0"]}",
                                        ctl.getItemColor("CONFIG_NUCLEAR_1_0"),
                                        32.w,
                                        700.w,
                                        100.w, () {
                                      ctl.changeSelectedItem(
                                          "CONFIG_NUCLEAR_1_0");
                                    },
                                        background: ctl.getItemBackgroundColor(
                                            "CONFIG_NUCLEAR_1_0")),
                                  ),
                                  pSizeBoxH(10.w),
                                  Center(
                                    child: pActionText(
                                        "${ctl.orderTitleMap["CONFIG_NUCLEAR_1_1"]}",
                                        ctl.getItemColor("CONFIG_NUCLEAR_1_1"),
                                        32.w,
                                        700.w,
                                        100.w, () {
                                      ctl.changeSelectedItem(
                                          "CONFIG_NUCLEAR_1_1");
                                    },
                                        background: ctl.getItemBackgroundColor(
                                            "CONFIG_NUCLEAR_1_1")),
                                  ),
                                  pSizeBoxH(10.w),
                                  Center(
                                    child: pActionText(
                                        "${ctl.orderTitleMap["CONFIG_NUCLEAR_1_2"]}",
                                        ctl.getItemColor("CONFIG_NUCLEAR_1_2"),
                                        32.w,
                                        700.w,
                                        100.w, () {
                                      ctl.changeSelectedItem(
                                          "CONFIG_NUCLEAR_1_2");
                                    },
                                        radius: 10.w,
                                        background: ctl.getItemBackgroundColor(
                                            "CONFIG_NUCLEAR_1_2")),
                                  ),
                                ],
                              ),
                            ],
                          )),
                          Container(
                              child: Center(
                                  child: pActionText(
                                    "确定",
                                    ColorConfig.color_ffffff,
                                    32.w,
                                    700.w,
                                    100.w,
                                        () {
                                      ctl.confirmBack();
                                    },
                                    radius: 50.w,
                                    background: ColorConfig.color_1678ff,
                                  )))
                        ],
                      ));
                } else {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    pText(
                                        ' 选择模式', ColorConfig.color_333333, 26.w,
                                        textAlign: TextAlign.left),
                                    GestureDetector(
                                      child: Icon(Icons.check_circle_outline),
                                      onTap: () {
                                        ctl.isPriority = !ctl.isPriority;
                                        ctl.update();
                                      },
                                    )
                                  ],
                                ),
                                pSizeBoxH(10.w),
                                Center(
                                  child: pActionText(
                                      "${ctl.orderTitleMap["CONFIG_NUCLEAR_1_3"]}",
                                      ctl.getItemColor("CONFIG_NUCLEAR_1_3"),
                                      32.w,
                                      700.w,
                                      100.w, () {
                                    ctl.changeSelectedItem(
                                        "CONFIG_NUCLEAR_1_3");
                                  },
                                      radius: 10.w,
                                      background: ctl.getItemBackgroundColor(
                                          "CONFIG_NUCLEAR_1_3")),
                                ),
                                pSizeBoxH(10.w),
                                Center(
                                  child: pActionText(
                                      "${ctl.orderTitleMap["CONFIG_NUCLEAR_1_4"]}",
                                      ctl.getItemColor("CONFIG_NUCLEAR_1_4"),
                                      32.w,
                                      700.w,
                                      100.w, () {
                                    ctl.changeSelectedItem(
                                        "CONFIG_NUCLEAR_1_4");
                                  },
                                      radius: 10.w,
                                      background: ctl.getItemBackgroundColor(
                                          "CONFIG_NUCLEAR_1_4")),
                                ),
                                pSizeBoxH(10.w),
                                Center(
                                  child: pActionText(
                                      "${ctl.orderTitleMap["CONFIG_NUCLEAR_1_5"]}",
                                      ctl.getItemColor("CONFIG_NUCLEAR_1_5"),
                                      32.w,
                                      700.w,
                                      100.w, () {
                                    ctl.changeSelectedItem(
                                        "CONFIG_NUCLEAR_1_5");
                                  },
                                      radius: 10.w,
                                      background: ctl.getItemBackgroundColor(
                                          "CONFIG_NUCLEAR_1_5")),
                                ),
                              ],
                            ),
                          ],
                        )),
                        Container(
                            child: Center(
                                child: pActionText(
                                  "确定",
                                  ColorConfig.color_ffffff,
                                  32.w,
                                  700.w,
                                  100.w,
                                      () {
                                    ctl.confirmBack();
                                  },
                                  radius: 50.w,
                                  background: ColorConfig.color_1678ff,
                                )))
                      ],
                    ),
                  );
                }
              } else {
                return Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    pText(
                                        ' 选择模式', ColorConfig.color_333333, 26.w,
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                                Center(
                                  child: pActionText(
                                      "${ctl.orderTitleMap["CONFIG_NUCLEAR_3_3"]}",
                                      ctl.getItemColor("CONFIG_NUCLEAR_3_3"),
                                      32.w,
                                      700.w,
                                      100.w, () {
                                    ctl.changeSelectedItem(
                                        "CONFIG_NUCLEAR_3_3");
                                  },
                                      radius: 10.w,
                                      background: ctl.getItemBackgroundColor(
                                          "CONFIG_NUCLEAR_3_3")),
                                ),
                                pSizeBoxH(10.w),
                                Center(
                                  child: pActionText(
                                      "${ctl.orderTitleMap["CONFIG_NUCLEAR_3_4"]}",
                                      ctl.getItemColor("CONFIG_NUCLEAR_3_4"),
                                      32.w,
                                      700.w,
                                      100.w, () {
                                    ctl.changeSelectedItem(
                                        "CONFIG_NUCLEAR_3_4");
                                  },
                                      radius: 10.w,
                                      background: ctl.getItemBackgroundColor(
                                          "CONFIG_NUCLEAR_3_4")),
                                ),
                                pSizeBoxH(10.w),
                                Center(
                                  child: pActionText(
                                      "${ctl.orderTitleMap["CONFIG_NUCLEAR_3_5"]}",
                                      ctl.getItemColor("CONFIG_NUCLEAR_3_5"),
                                      32.w,
                                      700.w,
                                      100.w, () {
                                    ctl.changeSelectedItem(
                                        "CONFIG_NUCLEAR_3_5");
                                  },
                                      radius: 10.w,
                                      background: ctl.getItemBackgroundColor(
                                          "CONFIG_NUCLEAR_3_5")),
                                ),
                              ],
                            ),
                          ],
                        )),
                        Container(
                            child: Center(
                                child: pActionText(
                          "确定",
                          ColorConfig.color_ffffff,
                          32.w,
                          700.w,
                          100.w,
                          () {
                            ctl.confirmBack();
                          },
                          radius: 50.w,
                          background: ColorConfig.color_1678ff,
                        )))
                      ],
                    ));
              }
            })));
  }

  @override
  void dispose() {
    Get.delete<VerificationModeLogic>();
    super.dispose();
  }
}

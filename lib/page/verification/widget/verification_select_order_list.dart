import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/formatter/num_text_input_formatter.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/verification/model/order_sale_item_entity.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../verification_logic.dart';

Widget selectOrderList() {
  return Container(
      color: Colors.grey.shade100,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegateX(),
          ),
          GetBuilder<VerificationLogic>(
              id: "listX",
              builder: (ctl) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      OrderSaleItemEntity entity = ctl.orderSaleList[index];
                      // entity.tempWriteOffAmount = entity.writeOffAmount;

                      var _textEditingController = TextEditingController(
                          text: (entity.tempWriteOffAmount / 100).toString());

                      // print('我想知道的1');
                      // print("金额-${entity.writeOffAmount}");
                      // print('我想知道的2');
                      // print("list${index.toString()}");
                      // print('我想知道的3');

                      return GetBuilder<VerificationLogic>(
                          id: "list${index.toString()}",
                          builder: (ctl) {
                            return Container(
                                margin: EdgeInsets.all(20.w),
                                alignment: Alignment(0, 0),
                                // height: 1000.w,
                                width: 750.w,
                                height: 158.w,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  //设置四周圆角 角度
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  //设置四周边框
                                  border: new Border.all(
                                      width: 1, color: Colors.white),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        child: entity.isCheck == true
                                            ? Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                                color: Color(
                                                    ColorConfig.color_1678ff),
                                              )
                                            : Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                                color: Colors.grey.shade500),
                                        width: 50.w,
                                      ),
                                      onTap: () {
                                        // print('---');

                                        if (entity.isCheck) {
                                          ctl.remainingWrittenOffAmount =
                                              ctl.remainingWrittenOffAmount +
                                                  entity.tempWriteOffAmount;
                                          entity.tempWriteOffAmount = 0.0;
                                        } else {
                                          // 打勾前判断
                                          if (ctl.remainingWrittenOffAmount ==
                                              0.0) {
                                            toastMsg('剩余核销金额为0');
                                            return;
                                          }
                                          if (ctl.remainingWrittenOffAmount >=
                                              entity.balanceAmount!) {
                                            entity.tempWriteOffAmount =
                                                entity.balanceAmount!;
                                            ctl.remainingWrittenOffAmount =
                                                ctl.remainingWrittenOffAmount -
                                                    entity.balanceAmount!;
                                          } else {
                                            entity.tempWriteOffAmount =
                                                ctl.remainingWrittenOffAmount;
                                            ctl.remainingWrittenOffAmount = 0.0;
                                          }
                                        }
                                        ctl.update(['salesTitle']);

                                        entity.isCheck = !entity.isCheck;

                                        _textEditingController.text =
                                            (entity.tempWriteOffAmount / 100)
                                                .toString();

                                        ctl.changeSalesValue(
                                            "list${index.toString()}");

                                        // print(entity.balanceAmount);
                                        //
                                        // print(entity.tempWriteOffAmount);
                                        //
                                        // print('-看看-');
                                        // print(ctl.remainingWrittenOffAmount);
                                        //
                                        // print('-看看-');
                                      },
                                      behavior: HitTestBehavior.opaque,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(children: [
                                          pText("销售单${entity.orderSaleSerial}",
                                              ColorConfig.color_333333, 28.w),
                                          pSizeBoxW(70.w),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,

                                            children: [
                                              pText(
                                                  "核销¥ ",
                                                  ColorConfig.color_333333,
                                                  24.w),
                                              Container(
                                                child: TextField(
                                                  inputFormatters: [
                                                    NumTextInputFormatter(
                                                        max: ctl.remainingWrittenOffAmount <
                                                            entity
                                                                .balanceAmount!
                                                            ? ctl.remainingWrittenOffAmount *
                                                            100
                                                            : entity.balanceAmount! *
                                                            100)
                                                  ],
                                                  keyboardType: TextInputType
                                                      .numberWithOptions(
                                                      decimal: true),
                                                  onChanged: (value) {
                                                    double dValue =
                                                    double.parse(value);
                                                    if (dValue > 1000) {
                                                      _textEditingController
                                                          .text = "0";
                                                    }

                                                    entity.tempWriteOffAmount =
                                                        dValue * 100;
                                                    // ctl.changeSalesValue();
                                                  },
                                                  controller:
                                                  _textEditingController,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: '0.0',
                                                  ),
                                                ),
                                                width: 100.w,
                                                // height: 25.w,
                                              )
                                            ],
                                          ),
                                        ],),
                                        Row(children: [
                                          pText("${entity.customizeTime}",
                                              ColorConfig.color_999999, 24.w),
                                          pSizeBoxW(70.w),
                                          pText(
                                              "结欠¥ ${(entity.balanceAmount ?? 0.0) / 100}",
                                              ColorConfig.color_999999,
                                              24.w),
                                        ],)
                                      ],
                                    ),

                                    // Container(
                                    //   child: Column(
                                    //     children: [
                                    //       pText("销售单${entity.orderSaleSerial}",
                                    //           ColorConfig.color_333333, 28.w),
                                    //       pText("${entity.customizeTime}",
                                    //           ColorConfig.color_999999, 24.w),
                                    //     ],
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceAround,
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //   ),
                                    //   width: 300.w,
                                    // ),
                                    // Container(
                                    //   child: Column(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceAround,
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.end,
                                    //     children: [
                                    //       Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.end,
                                    //
                                    //         children: [
                                    //           pText(
                                    //               "核销¥ ",
                                    //               ColorConfig.color_333333,
                                    //               24.w),
                                    //           Container(
                                    //             child: TextField(
                                    //               inputFormatters: [
                                    //                 NumTextInputFormatter(
                                    //                     max: ctl.remainingWrittenOffAmount <
                                    //                             entity
                                    //                                 .balanceAmount!
                                    //                         ? ctl.remainingWrittenOffAmount *
                                    //                             100
                                    //                         : entity.balanceAmount! *
                                    //                             100)
                                    //               ],
                                    //               keyboardType: TextInputType
                                    //                   .numberWithOptions(
                                    //                       decimal: true),
                                    //               onChanged: (value) {
                                    //                 double dValue =
                                    //                     double.parse(value);
                                    //                 if (dValue > 1000) {
                                    //                   _textEditingController
                                    //                       .text = "0";
                                    //                 }
                                    //
                                    //                 entity.tempWriteOffAmount =
                                    //                     dValue * 100;
                                    //                 // ctl.changeSalesValue();
                                    //               },
                                    //               controller:
                                    //                   _textEditingController,
                                    //               decoration: InputDecoration(
                                    //                 border: InputBorder.none,
                                    //                 hintText: '0.0',
                                    //               ),
                                    //             ),
                                    //             width: 100.w,
                                    //             // height: 25.w,
                                    //           )
                                    //         ],
                                    //       ),
                                    //       pText(
                                    //           "结欠¥ ${(entity.balanceAmount ?? 0.0) / 100}",
                                    //           ColorConfig.color_333333,
                                    //           24.w),
                                    //     ],
                                    //   ),
                                    //   width: 300.w,
                                    // ),
                                  ],
                                ));
                          });
                    },
                    childCount: ctl.orderSaleList.length,
                  ),
                );
              }),
        ],
      ));
}

class MySliverPersistentHeaderDelegateX extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.white,
        width: 750.w,
        child: GetBuilder<VerificationLogic>(
            id: "salesTitle",
            builder: (ctl) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  pText("¥ ${ctl.remainingWrittenOffAmount / 100}",
                      ColorConfig.color_FA6400, 64.w),
                  pText("剩余可核销金额", ColorConfig.color_333333, 24.w),
                  pText(
                      "选择后，自动根据最大值填充，也支持手动编辑金额", ColorConfig.color_ffac71, 22.w,
                      height: 56.w,
                      width: 702.w,
                      background: ColorConfig.color_fff5e3,
                      radius: 5.w),
                ],
              );
            }));
  }

  @override
  double get maxExtent => 250.w;

  @override
  double get minExtent => 250.w;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      false; // 如果内容需要更新，设置为true
}

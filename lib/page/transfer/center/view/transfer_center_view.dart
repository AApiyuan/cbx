import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/transfer/center/controller/transfer_center_controller.dart';
import 'package:haidai_flutter_module/page/transfer/center/widget/sliding_segment.dart';
import 'package:haidai_flutter_module/page/transfer/center/widget/transfer_center_list.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/substandard.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class TransferCenterView extends GetView<TransferCenterController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<TransferCenterController>(
            id: "TransferPage",
            builder: (ctl) {
              return Scaffold(
                backgroundColor: Color(ColorConfig.color_ffffff),
                appBar: pAppBar('', backFunc: () {
                  BackUtils.backToNative();
                },
                    actions: [
                      pImageButton("images/icon_transfers_bar_add.png", 42.w, 42.w, () {
                        if (controller.groupValue == 0) {
                          showMenu(
                            context: context,
                            items: <PopupMenuEntry>[
                              //items 子项
                              PopupMenuItem(
                                  value: '1',
                                  padding: EdgeInsets.only(left: 30.w),
                                  height: 100.w,
                                  child: pText('申请调拨', ColorConfig.color_ffffff, 32.w)),
                            ],
                            color: Color(ColorConfig.color_333333),
                            position: RelativeRect.fromLTRB(200.w, 180.w, 24.w, 200.w),
                          ).then((value) {
                            if (value == '1') {
                              //申请调拨
                              controller.toTransferCreateOrUpdate(
                                  substandard: SubstandardEnum.NO,
                                  orderTransferType: TransferOrderTypeEnum.APPLY,
                                  showAllSku: true);
                            }
                          });
                        } else {
                          showMenu(
                            context: context,
                            items: <PopupMenuEntry>[
                              PopupMenuItem(
                                padding: EdgeInsets.only(left: 30.w),
                                value: '2',
                                height: 100.w,
                                child: pText('复制入库单调拨', ColorConfig.color_ffffff, 32.w),
                              ),
                              PopupMenuItem(
                                value: '3',
                                padding: EdgeInsets.only(left: 30.w),
                                height: 100.w,
                                child: pText('正品直接调出', ColorConfig.color_ffffff, 32.w),
                              ),
                              PopupMenuItem(
                                value: '4',
                                padding: EdgeInsets.only(left: 30.w),
                                height: 100.w,
                                child: pText('次品直接调出', ColorConfig.color_ffffff, 32.w),
                              ),
                            ],
                            color: Color(ColorConfig.color_333333),
                            position: RelativeRect.fromLTRB(200.w, 180.w, 24.w, 200.w),
                          ).then((value) {
                            if (value == '2') {
                              //复制入库单
                              controller.toSelectStock();
                            } else if (value == '3') {
                              //正品直接
                              controller.toTransferCreateOrUpdate(
                                  substandard: SubstandardEnum.NO,
                                  orderTransferType: TransferOrderTypeEnum.DIRECT,
                                  showAllSku: true);
                            } else if (value == '4') {
                              //次品直接
                              controller.toTransferCreateOrUpdate(
                                  substandard: SubstandardEnum.YES,
                                  orderTransferType: TransferOrderTypeEnum.DIRECT,
                                  showAllSku: true);
                            }
                          });
                        }
                      }),
                      pSizeBoxW(24.w),
                    ],
                    title: Center(
                      child: Container(
                          height: 78.w,
                          padding: EdgeInsets.only(left: 3.w, right: 3.w),
                          decoration: new BoxDecoration(
                            color: Color(ColorConfig.color_f5f5f5),
                            //设置四周圆角 角度
                            borderRadius: BorderRadius.all(Radius.circular(35.w)),
                            //设置四周边框
                            // border: new Border.all(width: 1, color: Colors.red),
                          ),
                          child: GetBuilder<TransferCenterController>(
                              id: "TransferCenterTop",
                              builder: (ctl) {
                                return SlidingSegment(
                                    badgeitems: [
                                      ctl.countEntity.stockInNum.toString(),
                                      ctl.countEntity.stockOutNum.toString()
                                    ],
                                    items: [
                                      '调入单',
                                      '调出单'
                                    ],
                                    currentIndex: ctl.groupValue,
                                    onSelectedItem: (index) {
                                      ctl.groupValue = index;
                                      ctl.update(["TransferCenterPageTitle"]);
                                      ctl.tabController.animateTo(0);
                                      ctl.loadListData("DISTRIBUTION", ctl.distributionCtr, 1);
                                    });
                              })),
                    )),
                body: GetBuilder<TransferCenterController>(
                    id: "TransferCenterContent",
                    builder: (ctl) {
                      return TransferCenterList();
                    }),
              );
            }),
        onWillPop: () {
          BackUtils.back();
          return new Future.value(false);
        });

    throw UnimplementedError();
  }
}

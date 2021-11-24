import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/common_utils.dart';
import 'package:haidai_flutter_module/page/distribution/controller/confirm_controller.dart';
import 'package:haidai_flutter_module/page/distribution/controller/distribution_controller.dart';
import 'package:haidai_flutter_module/repository/order/remark_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/date_pick.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget distributionConfirmWidget() {
  return GetBuilder<DistributionController>(builder: (ctl) {
    return Container(
      height: 96.w,
      width: double.infinity,
      padding: EdgeInsets.only(left: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GetBuilder<DistributionController>(
                  id: "transferTotal",
                  builder: (ctl) {
                    if (ctl.handleTag == "stockOutNum") {
                      return Container(
                          alignment: Alignment.centerLeft,
                          height: 85.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              pText(
                                  '待配' +
                                      ctl.orderTransfer!.notDistributionStyleNum.toString() +
                                      '款  ' +
                                      ctl.orderTransfer!.notDistributionNum.toString() +
                                      '件',
                                  ColorConfig.color_999999,
                                  24.w),
                              Row(children: [
                                pText("配货" + ctl.styleTotal.toString() + '款 ' + ctl.numTotal.toString() + '件', ColorConfig.color_1678FF, 28.w,
                                    fontWeight: FontWeight.w600),
                                pSizeBoxW(26.w),
                                InkWell(
                                  onTap: () => {eventBus.fire(new AddGoodsEvent(-1))},
                                  child: Row(
                                    children: [pText("全部收起", ColorConfig.color_666666, 24.w), pImage("images/icon_down.png", 32.w, 32.w)],
                                  ),
                                )
                              ])
                            ],
                          ));
                    } else {
                      return Container(
                          alignment: Alignment.centerLeft,
                          height: 85.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  pText(
                                      '欠货' + ctl.orderTransfer!.shortageStyleNum.toString() + '款 ' + ctl.orderTransfer!.shortageNum.toString() + '件',
                                      ColorConfig.color_999999,
                                      24.w),
                                  pSizeBoxW(16.w),
                                  SizedBox(
                                    width: 1.w,
                                    height: 24.w,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(color: Color(ColorConfig.color_CCCCCC)),
                                    ),
                                  ),
                                  pSizeBoxW(16.w),
                                  pText(
                                      '配出' + ctl.orderTransfer!.stockOutStyleNum.toString() + '款 ' + ctl.orderTransfer!.stockOutNum.toString() + '件',
                                      ColorConfig.color_999999,
                                      24.w),
                                ],
                              ),
                              Row(children: [
                                pText("入库" + ctl.styleTotal.toString() + '款 ' + ctl.numTotal.toString() + '件', ColorConfig.color_1678FF, 28.w,
                                    fontWeight: FontWeight.w600),
                                pSizeBoxW(26.w),
                                InkWell(
                                  onTap: () => {eventBus.fire(new AddGoodsEvent(-1))},
                                  child: Row(
                                    children: [pText("全部收起", ColorConfig.color_666666, 24.w), pImage("images/icon_down.png", 32.w, 32.w)],
                                  ),
                                )
                              ])
                            ],
                          ));
                    }
                  }),
            ],
          ),
          Row(
            children: [
              pButton(150.w, 96.w, "一键填充", ColorConfig.color_1678ff, 32.w, () {
                ctl.fillData();
              }, background: ColorConfig.color_f5f5f5),
              Builder(builder: (buttonContext) {
                return pButton(160.w, 96.w, ctl.confirmButtonText, ColorConfig.color_ffffff, 32.w, () {
                  //配货
                  showCupertinoModalBottomSheet(
                      context: Get.context!,
                      animationCurve: Curves.easeIn,
                      builder: (context) => orderInfo(ctl.confirmButtonText, () {
                            if (ctl.handleTag == "stockInNum") {
                              if (ctl.numTotal != ctl.orderTransfer!.stockOutNum) {
                                //存在差异要弹框提示
                                showDialog(
                                    context: buttonContext,
                                    builder: (_) {
                                      return CustomDialog(
                                        title: '提示',
                                        type: 1,
                                        height: 380,
                                        confirmContent: "确认入库",
                                        confirmTextColor: ColorConfig.color_ff3715,
                                        content: Container(
                                          padding: EdgeInsets.only(top: 0.w, left: 80.w, bottom: 0.w, right: 80.w),
                                          child: pText("当前入库数和出库数有差异，确认入库吗?", ColorConfig.color_333333, 32.w, maxLines: 2),
                                        ),
                                        confirmCallback: (value) async {
                                          Navigator.of(context).pop();
                                          ctl.confirm();
                                        },
                                      );
                                    });
                              }else{
                                Navigator.of(context).pop();
                                ctl.confirm();
                              }
                            } else {
                              ctl.confirm();
                            }
                          }));
                });
              })
            ],
          )
        ],
      ),
    );
  });
}

Widget orderInfo(String buttonTitle, Function callback) {
  return GetBuilder<ConfirmController>(builder: (ctl) {
    return BottomSheetWidget(
        title: "单据信息",
        buttonText: buttonTitle,
        height: 1400.w,
        autoClose: ctl.handleTag == "stockInNum" ? false : true,
        child:SingleChildScrollView(child:Container(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pText('录入备注', ColorConfig.color_333333, 28.w, textAlign: TextAlign.left),
              pSizeBoxH(24.w),
              Container(
                  width: double.infinity,
                  height: 300.w,
                  padding: EdgeInsets.all(20.w),
                  margin: EdgeInsets.only(bottom: 10.w),
                  decoration: BoxDecoration(color: const Color(ColorConfig.color_f5f5f5), borderRadius: BorderRadius.all(Radius.circular(10.w))),
                  child: TextField(
                    controller: ctl.orderRemarkController,
                    maxLines: 5,
                    inputFormatters: CommonUtils.getTextInputFormatter(50),
                    decoration: InputDecoration(
                      hintText: '请输入',
                      counterText: "",
                      hintStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_999999)),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_F3AE1F)),
                  )),
              GetBuilder<ConfirmController>(
                  id: "remarkList",
                  builder: (ctl) {
                    return ListView.builder(
                        itemCount: ctl.remarks.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                decoration:
                                    new BoxDecoration(color: Color(ColorConfig.color_f5f5f5), borderRadius: new BorderRadius.circular((10.w))),
                                padding: EdgeInsets.only(left: 10.w, right: 40.w, top: 10.w, bottom: 10.w),
                                margin: EdgeInsets.only(top: 16.w),
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                child: pText(ctl.remarks[index].createdByName.toString() + ": " + ctl.remarks[index].remark.toString(),
                                    ColorConfig.color_F3AE1F, 24.w,
                                    softWrap: true, maxLines: 3, textAlign: TextAlign.left),
                              ),
                              Visibility(
                                  visible: ctl.customerUserDo == null
                                      ? true
                                      : ((ctl.customerUserDo!.id == ctl.orderTransfer!.remarks![index].createdBy) ? true : false),
                                  child: new Positioned(
                                      top: 20.w,
                                      right: 10.w,
                                      child: pImageButton("images/del_pic.png", 40.w, 40.w, () {
                                        //删除单据备注
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) {
                                              return CustomDialog(
                                                title: '提示',
                                                type: 1,
                                                height: 300,
                                                confirmTextColor: ColorConfig.color_ff3715,
                                                content: pText("是否删除该备注", ColorConfig.color_333333, 28.w),
                                                confirmCallback: (value) async {
                                                  List<int> remarkIds = [ctl.remarks[index].id as int];
                                                  var res = await RemarkApi.batchDeleteOrderRemark(remarkIds);
                                                  if (res) {
                                                    ctl.remarks.removeAt(index);
                                                    ctl.update(['remarkList']);
                                                  }
                                                },
                                              );
                                            });
                                      }))),
                            ],
                          );
                        });
                  }),
              Container(
                margin: EdgeInsets.only(top: 46.w),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pText('单据日期', ColorConfig.color_333333, 28.w),
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          // if (ctl.orderTransferId != -1 && ctl.handleTag != "stockInNum") {
                          //   //编辑，不弹出
                          //   return;
                          // }
                          showCupertinoModalBottomSheet(
                              context: Get.context!,
                              animationCurve: Curves.easeIn,
                              builder: (context) => DatePick(
                                  initialSelectedDate: ctl.selectDate,
                                  onCertain: (v) {
                                    ctl.selectDate = v;
                                    ctl.update(['dateString']);
                                  }));
                        },
                        child: Row(
                          children: [
                            GetBuilder<ConfirmController>(
                                id: "dateString",
                                builder: (ctl) {
                                  return pText(
                                      ctl.selectDate == null ? '选择' : ctl.selectDate.toString().substring(0, 10), ColorConfig.color_333333, 28.w);
                                }),
                            pImage('images/icon_goto.png', 22.w, 22.w)
                          ],
                        ))
                  ],
                ),
              ),
              pSizeBoxH(56.w),
            ],
          ),
        )),
        onClose: () {},
        onCertain: () {
          callback.call();
        });
  });
}

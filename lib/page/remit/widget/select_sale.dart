import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/formatter/num_negative_input_formatter.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/remit/controller/remit_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/keyboard/number_keyboard.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget selectOrder() {
  return GetBuilder<RemitController>(
      id: "selectOrder",
      builder: (ctl) {
        return Obx(() => Visibility(
            visible: ctl.curMode.value == 2 && !ctl.isRefund.value,
            child: Container(
              height: 144.w,
              color: Color(ColorConfig.color_ffffff),
              width: double.infinity,
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              alignment: Alignment.center,
              child: pText("+ 手动选择结欠销售单", ColorConfig.color_333333, 24.w,
                  width: 284.w, height: 72.w, borderColor: ColorConfig.color_333333, radius: 10.w, onTap: () {
                ctl.focusNode.unfocus();
                showCupertinoModalBottomSheet(
                    context: Get.context as BuildContext, animationCurve: Curves.easeIn, builder: (context) => selectOrderList());
              }),
            )));
      });
}

Widget selectOrderList() {
  return GetBuilder<RemitController>(
      id: "order_check",
      builder: (ctl) {
        return BottomSheetWidget(
            title: "选择销售单",
            height: 1500.w,
            onCertain: () {
              ctl.node.unfocus();
              ctl.focusNode.unfocus();
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(24.w, 20.w, 24.w, 20.w),
                    color: Color(ColorConfig.color_ffffff),
                    child: Column(
                      children: [
                        Obx(() => pText("${ctl.leftCheckAmount.value}", ColorConfig.color_FA6400, 64.w, fontWeight: FontWeight.w600)),
                        pText("剩余可核销金额", ColorConfig.color_333333, 24.w),
                        pSizeBoxH(17.w),
                        pText("选择有，自动根据最大值填充，也支持手动编辑金额", ColorConfig.color_ffac71, 24.w,
                            width: 700.w, height: 56.w, background: ColorConfig.color_fff5e3, radius: 10.w),
                      ],
                    ),
                  ),
                  Expanded(
                    child: FocusScope(
                        node: ctl.node,
                        child: ListView.builder(
                            itemBuilder: ((BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.only(left: 0.w, top: 20.w, right: 20.w, bottom: 20.w),
                                margin: EdgeInsets.only(left: 24.w, right: 24.w),
                                decoration: BoxDecoration(
                                    color: Color(ColorConfig.color_ffffff),
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Color(ColorConfig.color_efefef), width: (index != ctl.saleList.length - 1) ? 1.w : 0))),
                                height: 150.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GetBuilder<RemitController>(
                                            id: "selectId" + ctl.saleList[index].id.toString(),
                                            builder: (ctl) {
                                              return GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {
                                                  if (ctl.selectIdMap[ctl.saleList[index].id] == true) {
                                                    ctl.selectIdMap.remove(ctl.saleList[index].id);
                                                    ctl.saleList[index].check = "";
                                                  } else {
                                                    if (ctl.leftCheckAmount.value == 0) {
                                                      toastMsg("金额不足");
                                                      return;
                                                    }
                                                    ctl.saleList[index].check = (ctl.saleList[index].balanceAmount!.toDouble() / 100).toString();
                                                    ctl.selectIdMap[ctl.saleList[index].id as int] = true;
                                                  }
                                                  ctl.update(['saleCheckList']);
                                                  ctl.update(["selectId" + ctl.saleList[index].id.toString()]);
                                                  ctl.onEditOneOrderCheck(ctl.saleList[index].id as int);
                                                },
                                                child: Container(
                                                  height: 150.w,
                                                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                                  alignment: Alignment.center,
                                                  child: pImage(
                                                      ctl.selectIdMap[ctl.saleList[index].id] == true ? 'images/checked.png' : 'images/unChecked.png',
                                                      38.w,
                                                      38.w),
                                                ),
                                              );
                                            }),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Visibility(
                                                  visible: ctl.saleList[index].id == ctl.curSaleOrderId,
                                                  child: pImage("images/self.png", 56.w, 28.w),
                                                ),
                                                pText("销售单${ctl.saleList[index].orderSaleSerial}", ColorConfig.color_999999, 28.w),
                                              ],
                                            ),
                                            pText('${ctl.saleList[index].customizeTime}', ColorConfig.color_999999, 28.w),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            pText("核销 ", ColorConfig.color_FA6400, 28.w, fontWeight: FontWeight.w600),
                                            Container(
                                              width: 150.w,
                                              padding: EdgeInsets.only(left: 10.w),
                                              decoration: BoxDecoration(
                                                  color: Color(ColorConfig.color_f5f5f5), borderRadius: BorderRadius.all(Radius.circular(10.w))),
                                              child: GetBuilder<RemitController>(
                                                  id: "amount" + ctl.saleList[index].id.toString(),
                                                  builder: (ctl) {
                                                    return TextField(
                                                        textAlign: TextAlign.left,
                                                        readOnly: ctl.selectIdMap[ctl.saleList[index].id] == true ? false : true,
                                                        controller: TextEditingController.fromValue(TextEditingValue(
                                                            text: '${ctl.saleList[index].check}',
                                                            //判断keyword是否为空
                                                            // 保持光标在最后
                                                            selection: TextSelection.fromPosition(TextPosition(
                                                                affinity: TextAffinity.downstream, offset: '${ctl.saleList[index].check}'.length)))),
                                                        style: TextStyle(
                                                            fontSize: 28.w, color: Color(ColorConfig.color_333333), fontWeight: FontWeight.w600),
                                                        // keyboardType: TextInputType.number,
                                                        keyboardType: NumberKeyboard.inputType,
                                                        enableInteractiveSelection: false,
                                                        inputFormatters: [NumNegativeInputFormatter(negative: false, decimal: true)],
                                                        textInputAction: TextInputAction.next,
                                                        decoration: InputDecoration(
                                                          hintText: '0.00',
                                                          counterText: "",
                                                          isCollapsed: true,
                                                          hintStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_999999)),
                                                          border: InputBorder.none,
                                                          contentPadding: EdgeInsets.fromLTRB(0, 15.w, 0, 15.w),
                                                        ),
                                                        onChanged: (value) {
                                                          ctl.saleList[index].check = value;
                                                          ctl.onEditOneOrderCheck(ctl.saleList[index].id as int);
                                                        });
                                                  }),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            pText('结欠', ColorConfig.color_999999, 28.w),
                                            pText('${PriceUtils.getPrice(ctl.saleList[index].balanceAmount)}', ColorConfig.color_999999, 28.w,
                                                fontWeight: FontWeight.w600),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                            itemCount: ctl.saleList.length)),
                  )
                ],
              ),
            ));
      });
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/formatter/num_negative_input_formatter.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/model/enum/remit_type.dart';
import 'package:haidai_flutter_module/page/remit/controller/remit_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/remit/widget/remit_tab_bar.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_tab.dart';
import 'package:haidai_flutter_module/widget/keyboard/number_keyboard.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget remitMethod() {
  return GetBuilder<RemitController>(
      id: "remit_method",
      builder: (ctl) {
        return Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.w),
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(color: Color(ColorConfig.color_ffffff), borderRadius: BorderRadius.all(Radius.circular(20.w))),
            child: Column(
              children: [
                CustomerTab(
                    tabs: ["收款", "退款"],
                    height: 64.w,
                    width: 280.w,
                    radius: 32.w,
                    labelStyle: TextStyle(fontSize: 32.w, color: Color(ColorConfig.color_333333), fontWeight: FontWeight.w600),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 32.w,
                      color: Color(ColorConfig.color_666666),
                    ),
                    indicatorColor: ColorConfig.color_ffffff,
                    contentBackgroundColor: Color(ColorConfig.color_efefef),
                    change: (index) {
                      ctl.isRefund.toggle();
                      //重置
                      ctl.remitMethods.forEach((element) {
                        element.amount = "";
                      });
                      ctl.curRemitMethodAmount = "";
                      ctl.update(['curAmount', 'remitConfirm', 'orderCheck', 'saleCheckList', 'selectOrder']);
                      ctl.onPriceChange();
                    }),
                pSizeBoxH(45.w),
                GetBuilder<RemitController>(
                    id: "RemitTabBar",
                    builder: (ctl) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FutureBuilder(
                              future: ctl.initRemitMethod(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting || ctl.remitMethods.length == 0) {
                                  return Container(
                                      alignment: Alignment.center,
                                      width: 550.w,
                                      height: 80.w,
                                      child: pText("请添加收款方式后再操作", ColorConfig.color_999999, 28.w));
                                } else {
                                  return RemitTabBar(
                                    remitMethods: ctl.remitMethods,
                                    onChange: (index) {
                                      ctl.curRemitMethodIndex = index;
                                      ctl.curRemitMethodAmount = ctl.remitMethods[index].amount;
                                      ctl.update(['curAmount']);
                                    },
                                  );
                                }
                              }),
                          pImageButton("images/icon_pay_ls.png", 74.w, 74.w, () {
                            Get.toNamed(ArgUtils.map2String(path: Routes.REMIT_SORT, arguments: {Constant.DEPT_ID: ctl.deptId}))!.then((value) {
                              if (value == "refresh") {
                                ctl.update(['RemitTabBar']);
                              }
                            });
                          })
                        ],
                      );
                    }),
                Obx(() => Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Visibility(
                                visible: ctl.isRefund.value,
                                child: Container(
                                  width: 40.w,
                                  height: 4.w,
                                  color: Color(ColorConfig.color_ff3715),
                                ),
                              ),
                              Container(
                                width: 400.w,
                                child: GetBuilder<RemitController>(
                                    id: "curAmount",
                                    builder: (ctl) {
                                      return TextField(
                                          textAlign: TextAlign.left,
                                          focusNode: ctl.focusNode,
                                          controller: TextEditingController.fromValue(TextEditingValue(
                                              text: '${ctl.curRemitMethodAmount}',
                                              //判断keyword是否为空
                                              // 保持光标在最后
                                              selection: TextSelection.fromPosition(
                                                  TextPosition(affinity: TextAffinity.downstream, offset: '${ctl.curRemitMethodAmount}'.length)))),
                                          style: TextStyle(
                                              fontSize: 64.w,
                                              color: Color(ctl.isRefund.value ? ColorConfig.color_ff3715 : ColorConfig.color_333333),
                                              fontWeight: FontWeight.w600),
                                          // keyboardType: TextInputType.number,
                                          keyboardType: NumberKeyboard.inputType,
                                          enableInteractiveSelection: false,
                                          readOnly: ctl.remitMethods.length > 0 ? false : true,
                                          inputFormatters: [NumNegativeInputFormatter(negative: false, decimal: true)],
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            hintText: '0.00',
                                            counterText: "",
                                            isCollapsed: true,
                                            hintStyle: TextStyle(fontSize: 64.w, color: Color(ColorConfig.color_999999)),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(0, 15.w, 0, 15.w),
                                          ),
                                          onChanged: (value) {
                                            ctl.remitMethods[ctl.curRemitMethodIndex].amount = value;
                                            ctl.onPriceChange();
                                          });
                                    }),
                              ),
                            ],
                          ),
                          GetBuilder<RemitController>(
                              id: "curOrderAmount",
                              builder: (ctl) {
                                return Visibility(
                                    visible: ctl.amount != 0 && ctl.amount != -1 && !ctl.isRefund.value && ctl.remitAmount.value == 0,
                                    child: pText('${PriceUtils.getPrice(ctl.amount)}', ColorConfig.color_666666, 24.w,
                                        background: ColorConfig.color_efefef,
                                        radius: 28.w,
                                        height: 56.w,
                                        fontWeight: FontWeight.w600,
                                        padding: EdgeInsets.only(left: 30.w, right: 30.w), onTap: () {
                                      if (ctl.remitMethods.length == 0) {
                                        return;
                                      }
                                      ctl.remitMethods[ctl.curRemitMethodIndex].amount = (ctl.amount / 100).toString();
                                      ctl.curRemitMethodAmount = ctl.remitMethods[ctl.curRemitMethodIndex].amount;
                                      ctl.update(['curAmount', 'curAmountList', "curOrderAmount"]);
                                      ctl.onPriceChange();
                                    }));
                              })
                        ],
                      ),
                    )),
                GetBuilder<RemitController>(
                    id: "curAmountList",
                    builder: (ctl) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: new NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Visibility(
                              visible: ctl.remitMethods[index].amount != "",
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 20.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    pText(ctl.remitMethods[index].remitMethodName!, ColorConfig.color_333333, 28.w),
                                    Row(
                                      children: [
                                        pText('${ctl.isRefund.value ? "退款 " : "收款 "}', ColorConfig.color_333333, 28.w),
                                        pText('￥${ctl.remitMethods[index].amount}', ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                          itemCount: ctl.remitMethods.length);
                    }),
                Obx(() => Visibility(
                    visible: ctl.isRefund.value,
                    child: Row(
                      children: [pImage("images/circle.png", 16.w, 16.w), pSizeBoxW(10.w), pText("实退金额从余额扣除 ，不能超退", ColorConfig.color_999999, 24.w)],
                    )))
              ],
            ));
      });
}

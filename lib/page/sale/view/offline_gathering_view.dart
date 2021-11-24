import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/formatter/num_negative_input_formatter.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/common_utils.dart';
import 'package:haidai_flutter_module/common/utils/customer_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/customer/widget/customer_widget.dart';
import 'package:haidai_flutter_module/page/sale/controller/offline_gathering_controller.dart';
import 'package:haidai_flutter_module/page/sale/widget/offline_gathering_widget.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_media_query.dart';
import 'package:haidai_flutter_module/widget/keyboard/number_keyboard.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// ignore: must_be_immutable
class OfflineGatheringVIew extends GetView<OfflineGatheringController> {

  @override
  Widget build(BuildContext context) {
    return KeyboardMediaQuery(
      child: Scaffold(
        appBar: pAppBar("断网收款"),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            customer(),
            Container(height: 18.w, color: Color(ColorConfig.color_f5f5f5)),
            accountList(),
            Container(height: 1.w, color: Color(ColorConfig.color_efefef)),
            bottom(),
          ],
        ),
      ),
    );
  }

  customer() {
    return GetBuilder<OfflineGatheringController>(
      builder: (ctl) {
        if (ctl.customer == null) return emptyCustomer();
        return customerInfo();
      },
      id: OfflineGatheringController.idCustomer,
    );
  }

  emptyCustomer() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: pText("+新客户", ColorConfig.color_666666, 28.w),
            onTap: () => Get.toNamed(
              ArgUtils.map2String(
                path: Routes.ADD_CUSTOMER,
                arguments: {Constant.DEPT_ID: controller.deptId, Constant.ONLINE: false},
              ),
            )?.then((value) => controller.updateCustomer(value)),
          ),
          pSizeBoxW(40.w),
          pText("|", ColorConfig.color_dcdcdc, 28.w),
          pSizeBoxW(40.w),
          InkWell(
            child: pText("选择客户", ColorConfig.color_666666, 28.w),
            onTap: () => Get.toNamed(
              ArgUtils.map2String(
                  path: Routes.SEARCH_CUSTOMER,
                  arguments: {Constant.DEPT_ID: controller.deptId, Constant.ONLINE: false}),
            )?.then((value) => controller.updateCustomer(value)),
          ),
          pSizeBoxW(40.w),
          pText("|", ColorConfig.color_dcdcdc, 28.w),
          pSizeBoxW(40.w),
          InkWell(
            child: pText("零售客", ColorConfig.color_666666, 28.w),
            onTap: () => controller.getRetailStoreCustomer(),
          ),
        ],
      ),
      height: 86.w,
      alignment: Alignment.center,
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 10.w),
    );
  }

  customerInfo() {
    var customer = controller.customer;
    var name = customer?.customerName;
    if ((customer?.customerName?.length ?? 0) > 6) {
      name = "${customer?.customerName?.substring(0, 5)}...";
    }
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          customerLogo(customer?.customerName, customer?.levelTag),
          pSizeBoxW(16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  pText(name ?? "", ColorConfig.color_333333, 32.w),
                  pSizeBoxW(12.w),
                  InkWell(
                    child: Container(
                      height: 42.w,
                      width: 82.w,
                      child: pText("更换", ColorConfig.color_666666, 24.w),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: Color(ColorConfig.color_f5f5f5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21.w),
                        ),
                      ),
                    ),
                    onTap: () => Get.toNamed(
                      ArgUtils.map2String(
                        path: Routes.SEARCH_CUSTOMER,
                        arguments: {Constant.DEPT_ID: controller.deptId, Constant.ONLINE: false},
                      ),
                    )?.then((value) => controller.updateCustomer(value)),
                  ),
                ],
              ),
              pSizeBoxH(20.w),
              pText(
                CustomerUtils.encodePhone(customer?.customerPhone),
                ColorConfig.color_999999,
                28.w,
              ),
            ],
          ),
        ],
      ),
      padding:
          EdgeInsets.only(left: 22.w, right: 24.w, top: 22.w, bottom: 14.w),
    );
  }

  accountList() {
    return Expanded(
      child: Obx(
        () {
          if (controller.accountSize.value == 0) {
            return emptyWidget();
          } else {
            return ListView.builder(
              itemBuilder: (_, index) => accountItem(index),
              itemCount: controller.accountSize.value,
            );
          }
        },
      ),
    );
  }

  accountItem(int index) {
    var remit = controller.remitMethodList[index];
    var value = controller.remitAmountMap[remit.id!];
    return Container(
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      padding: EdgeInsets.only(bottom: 20.w),
      child: Row(
        children: [
          pText(remit.remitMethodName ?? "", ColorConfig.color_333333, 28.w),
          Expanded(
            child: TextField(
              controller: TextEditingController.fromValue(
                TextEditingValue(text: "${value == 0 ? "" : value}"),
              ),
              onChanged: (text) {
                if (text.isEmpty) {
                  controller.remitAmountMap[remit.id!] = 0;
                } else {
                  var price = double.tryParse(text);
                  if (price == null) {
                    toastMsg("请输入正确格式");
                    controller.remitAmountMap[remit.id!] = 0;
                  } else {
                    controller.remitAmountMap[remit.id!] = price;
                  }
                }
                controller.updateAmountCount();
              },
              // inputFormatters: CommonUtils.getTextInputNumFormatter(max: 999999.99),
              inputFormatters: [NumNegativeInputFormatter(negative: false, decimal: true)],
              style: textStyle(bold: true),
              decoration: InputDecoration(
                hintStyle: textStyle(color: ColorConfig.color_999999),
                hintText: "请输入",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                ),
              ),
              textAlign: TextAlign.end,
              keyboardType: NumberKeyboard.inputType,
            ),
          ),
        ],
      ),
      decoration: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: Color(ColorConfig.color_efefef),
          width: 1.w,
        ),
      ),
      height: 96.w,
    );
  }

  bottom() {
    return Container(
      height: 96.w,
      alignment: Alignment.center,
      color: Colors.white,
      child: Row(
        children: [
          pSizeBoxW(24.w),
          Container(
            alignment: Alignment.center,
            child: Obx(
              () => pText(
                "合计收款 ¥${controller.amountCount.value}",
                ColorConfig.color_333333,
                28.w,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Container()),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Color(ColorConfig.color_F7B500),
              child: pText("挂单", ColorConfig.color_ffffff, 28.w),
              width: 140.w,
              height: 96.w,
            ),
            onTap: () =>
                controller.hangOrder().then((value) => Get.back(result: true)),
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Color(ColorConfig.color_1678FF),
              child: pText("提交", ColorConfig.color_ffffff, 28.w),
              width: 140.w,
              height: 96.w,
            ),
            onTap: () => showOfflineGatheringOrderDialog(),
          ),
        ],
      ),
    );
  }

  showOfflineGatheringOrderDialog() {
    if (controller.customer == null) {
      return Future.error(toastMsg("请选择客户"));
    }
    var empty = true;
    controller.remitAmountMap.forEach((key, value) {
      if (value > 0) {
        empty = false;
      }
    });
    if (empty) return Future.error(toastMsg("请输入收款金额"));

    showCupertinoModalBottomSheet(
      context: Get.context!,
      animationCurve: Curves.easeIn,
      builder: (context) {
        return BottomSheetWidget(
          title: "收款单",
          showCertain: false,
          height: 1400.w,
          child: OfflineGatheringWidget(),
        );
      },
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/store/res/store_remit_method_do.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/customer/widget/customer_widget.dart';
import 'package:haidai_flutter_module/page/sale/controller/offline_gathering_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/date_pick.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// ignore: must_be_immutable
class OfflineGatheringWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        // margin: EdgeInsets.only(top: 150.w),
        child: Column(
          children: [
            // titleBar(),
            contentWidget(),
            submitWidget(),
          ],
        ),
        color: Colors.white,
      ),
      onWillPop: () async => back(),
    );
  }

  titleBar() {
    return Stack(
      children: [
        Expanded(
          child: Container(
            height: 108.w,
            alignment: Alignment.center,
            child: pText("收款单", ColorConfig.color_333333, 36.w,
                fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          right: 30.w,
          top: 24.w,
          child: InkWell(
            child: pImage("images/icon_dialog_close.png", 60.w, 60.w),
            onTap: () => back(),
          ),
        ),
      ],
    );
  }

  back() {
    Get.back();
    return true;
  }

  contentWidget() {
    return Expanded(
      child: SingleChildScrollView(
        child: GetBuilder<OfflineGatheringController>(
          builder: (ctl) {
            var customer = ctl.customer;
            var widgets = <Widget>[
              customerInfo(customer),
              customerBalance(customer),
              remarkWidget(ctl),
              orderDate(ctl),
            ];
            var amountWidgets = <Widget>[];
            var amountSum = 0.0;
            ctl.remitAmountMap.forEach((key, value) {
              if (value > 0) {
                amountWidgets.add(amountItem(ctl.getRemitMethod(key), value));
                amountSum += value;
              }
            });
            widgets.insertAll(2, amountWidgets);
            widgets.insert(
                amountWidgets.length + 2, gatheringWidget(amountSum));
            return Column(
              children: widgets,
            );
          },
        ),
      ),
    );
  }

  remarkWidget(OfflineGatheringController controller) {
    return Container(
      margin: EdgeInsets.only(left: 30.w, top: 20.w, right: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          pText("备注", ColorConfig.color_333333, 28.w),
          pSizeBoxH(9.w),
          Container(
            child: TextField(
              scrollPadding: EdgeInsets.zero,
              style: textStyle(size: 24, color: ColorConfig.color_F3AE1F),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (text) => controller.remark.value = text,
              maxLength: 50,
              maxLines: 2,
              controller: TextEditingController.fromValue(
                TextEditingValue(text: controller.remark.value),
              ),
            ),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w),
              ),
              color: Color(ColorConfig.color_FAFAFA),
            ),
          )
        ],
      ),
    );
  }

  orderDate(OfflineGatheringController controller) {
    return Container(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 40.w),
      child: InkWell(
        child: Row(
          children: [
            pText("单据日期", ColorConfig.color_999999, 28.w),
            Expanded(
              child: Obx(
                () => pText(TimeUtils.getTime(controller.customizeTime.value),
                    ColorConfig.color_999999, 28.w,
                    textAlign: TextAlign.end),
              ),
            ),
            pImage("images/icon_goto.png", 23.w, 23.w),
          ],
        ),
        onTap: () => showCupertinoModalBottomSheet(
          context: Get.context!,
          animationCurve: Curves.easeIn,
          builder: (context) => DatePick(
              initialSelectedDate: controller.customizeTime.value,
              onCertain: (v) => controller.customizeTime.value = v),
        ),
      ),
    );
  }

  customerInfo(StoreCustomerListItemDoEntity? customer) {
    return Visibility(
      child: Container(
        child: Row(
          children: [
            customerLogo(customer?.customerName, customer?.levelTag),
            pSizeBoxW(16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pText(customer?.customerName ?? "", ColorConfig.color_333333,
                    32.w),
                pSizeBoxH(20.w),
                pText(customer?.customerPhone ?? "", ColorConfig.color_999999,
                    28.w),
              ],
            ),
          ],
        ),
        margin: EdgeInsets.only(left: 22.w),
      ),
      visible: customer != null,
    );
  }

  customerBalance(StoreCustomerListItemDoEntity? customer) {
    return Visibility(
      child: Container(
        height: 64.w,
        margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 4.w),
        child: Row(
          children: [
            balanceItem("余额", "¥${PriceUtils.priceString(customer?.balance)}",
                MainAxisAlignment.start, EdgeInsets.only(left: 16.w)),
            balanceItem("结欠", "¥${PriceUtils.priceString(customer?.oweAmount)}",
                MainAxisAlignment.center, EdgeInsets.zero),
            balanceItem("总欠货", "${customer?.oweNum ?? 0}",
                MainAxisAlignment.end, EdgeInsets.only(right: 19.w)),
          ],
        ),
        decoration: ShapeDecoration(
            color: Color(ColorConfig.color_FAFAFA),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w))),
      ),
      visible: customer != null,
    );
  }

  balanceItem(String title, String value, MainAxisAlignment alignment,
      EdgeInsets margin) {
    return Expanded(
      child: Container(
        margin: margin,
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            pText(title, ColorConfig.color_999999, 24.w),
            pText(value, ColorConfig.color_282940, 24.w),
          ],
        ),
      ),
    );
  }

  Widget amountItem(StoreRemitMethodDo remitMethod, double value) {
    return Container(
      margin: EdgeInsets.only(top: 30.w, left: 30.w, right: 30.w),
      child: Row(
        children: [
          pText(remitMethod.remitMethodName ?? "", ColorConfig.color_333333,
              28.w),
          Expanded(child: Container()),
          pText("¥$value", ColorConfig.color_333333, 28.w,
              fontWeight: FontWeight.bold),
        ],
      ),
    );
  }

  Widget gatheringWidget(double amount) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          pText("收款", ColorConfig.color_333333, 24.w),
          pText("¥$amount", ColorConfig.color_333333, 42.w,
              fontWeight: FontWeight.bold),
        ],
      ),
      margin: EdgeInsets.only(top: 30.w, right: 30.w),
    );
  }

  submitWidget() {
    return GetBuilder<OfflineGatheringController>(
      builder: (ctl) => InkWell(
        child: Container(
          child: pText("提交收款", ColorConfig.color_ffffff, 32.w),
          alignment: Alignment.center,
          height: 84.w,
          decoration: ShapeDecoration(
              color: Color(ColorConfig.color_1678FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w),
              )),
          margin:
              EdgeInsets.only(left: 30.w, right: 30.w, top: 10.w, bottom: 10.w),
        ),
        onTap: () => ctl.createOrder().then(
          (value) {
            // MethodChannel(ChannelConfig.flutterToNative).invokeMethod(
            //     ChannelConfig.methodGatheringDetail, jsonEncode(value));
            BackUtils.back();
            Get.offNamed(ArgUtils.map2String(
              path: Routes.GATHERING_DETAIL,
              arguments: {
                Constant.ORDER_ID: value.id,
              },
            ));
            // BackUtils.back(result: true);
          },
        ),
      ),
    );
  }
}

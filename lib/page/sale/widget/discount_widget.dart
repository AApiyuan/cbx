import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/formatter/num_negative_input_formatter.dart';
import 'package:haidai_flutter_module/common/formatter/num_text_input_formatter.dart';
import 'package:haidai_flutter_module/common/utils/permission_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/keyboard/number_keyboard.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

/// 改价
showChangePriceDialog(BuildContext context, SaleDetailDoSaleGoodsList saleGoods, int deptId, int? customerId, Function(int) function) {
  if (saleGoods.storeGoods?.goods == null) {
    GoodsApi.getGoodsPrice(saleGoods.storeGoods!.id!, deptId, customerId)
        .then((value) => _showChangePrice(context, saleGoods, function, value.sailingPrice, value.takingPrice, value.packagePrice, value.price));
  } else {
    _showChangePrice(context, saleGoods, function, saleGoods.storeGoods?.goods?.sailingPrice, saleGoods.storeGoods?.goods?.takingPrice,
        saleGoods.storeGoods?.goods?.packagePrice, saleGoods.storeGoods?.goods?.lastBuyPrice);
  }
}

_showChangePrice(BuildContext context, SaleDetailDoSaleGoodsList saleGoods, Function(int) function, int? sailingPrice, int? takingPrice,
    int? packagePrice, int? lastBuyPrice) {
  var text = PriceUtils.priceString(saleGoods.price, def: "");
  var key = GlobalKey<CustomDialogState>();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => CustomDialog(
      key: key,
      title: '改价',
      type: 1,
      height: 470,
      width: 696,
      isCancel: false,
      isConfirm: false,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 60.w, right: 60.w),
            decoration: ShapeDecoration(
                color: Color(ColorConfig.color_f5f5f5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.w),
                )),
            height: 84.w,
            alignment: Alignment.center,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                NumNegativeInputFormatter(negative: false, decimal: true) //限制长度
              ],
              onSubmitted: (value) {
                text = value;
                key.currentState?.confirmDialog();
              },
              textInputAction: TextInputAction.done,
              keyboardType: NumberKeyboard.inputType,
              textAlign: TextAlign.center,
              onChanged: (value) => text = value,
              controller: TextEditingController.fromValue(TextEditingValue(
                  text: text, selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: text.length)))),
              decoration: InputDecoration(
                hintText: "0",
                hintStyle: textStyle(size: 42, color: ColorConfig.color_999999),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
              ),
              style: textStyle(size: 42, color: ColorConfig.color_282940),
            ),
          ),
          pSizeBoxH(50.w),
          Row(
            children: [
              priceText(
                "销售价A:",
                sailingPrice,
                ColorConfig.color_FF7113,
                EdgeInsets.only(left: 60.w),
                () {
                  text = "${_getPrice(sailingPrice)}";
                  key.currentState?.confirmDialog();
                },
              ),
              Expanded(child: Container()),
              priceText(
                "拿货价B:",
                takingPrice,
                ColorConfig.color_333333,
                EdgeInsets.only(right: 60.w),
                () {
                  text = "${_getPrice(takingPrice)}";
                  key.currentState?.confirmDialog();
                },
              ),
            ],
          ),
          Row(
            children: [
              priceText(
                "打包价C:",
                packagePrice,
                ColorConfig.color_333333,
                EdgeInsets.only(left: 60.w, top: 20.w),
                () {
                  text = "${_getPrice(packagePrice)}";
                  key.currentState?.confirmDialog();
                },
              ),
              Expanded(child: Container()),
              priceText(
                "上次拿货:",
                lastBuyPrice,
                ColorConfig.color_333333,
                EdgeInsets.only(right: 60.w, top: 20.w),
                () {
                  text = "${_getPrice(lastBuyPrice)}";
                  key.currentState?.confirmDialog();
                },
              ),
            ],
          ),
        ],
      ),
      confirmCheckCallback: (value) {
        double? price = double.tryParse(text);
        if (text.isEmpty || price == null) {
          toastMsg("请输入价格");
          return false;
        } else if (price < 0) {
          toastMsg("价格不能为负");
          return false;
        }
        return true;
      },
      confirmCallback: (value) {
        double price = double.parse(text);
        function.call((price * 100).toInt());
      },
    ),
  );
}

/// 获取价钱
_getPrice(int? price) {
  if (price == null)
    return null;
  else
    return price.toDouble() / 100;
}

/// 价钱快捷按钮
priceText(String text, int? price, int priceColor, EdgeInsets margin, Function function) {
  return InkWell(
    child: Container(
      margin: margin,
      padding: EdgeInsets.only(left: 20.w),
      alignment: Alignment.centerLeft,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.w),
          side: BorderSide(color: Color(ColorConfig.color_CCCCCC), width: 1.w),
        ),
      ),
      height: 72.w,
      width: 278.w,
      child: Row(
        children: [
          pText(text, ColorConfig.color_666666, 28.w),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: pText(
                "${PriceUtils.getPrice(price, def: "--")}",
                priceColor,
                28.w,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
    onTap: () => function.call(),
  );
}

/// 打折
showRebateDialog(BuildContext context, int discount, Function(int) function) {
  var text = "${discount == 0 ? "" : discount}";
  var key = GlobalKey<CustomDialogState>();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => CustomDialog(
      key: key,
      title: '折扣',
      type: 1,
      height: 341,
      content: Container(
        height: 84.w,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 84.w,
              margin: EdgeInsets.only(right: 10.w),
              child: pText("0", ColorConfig.color_282940, 42.w),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: Color(ColorConfig.color_FAFAFA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.w),
                ),
              ),
            ),
            pText(".", ColorConfig.color_282940, 42.w),
            Container(
              width: 138.w,
              margin: EdgeInsets.only(left: 10.w),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  color: Color(ColorConfig.color_f5f5f5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.w),
                  )),
              child: TextField(
                controller: TextEditingController.fromValue(TextEditingValue(
                    text: text, selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: text.length)))),
                keyboardType: NumberKeyboard.inputType,
                textAlign: TextAlign.center,
                onChanged: (value) => text = value,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  text = value;
                  key.currentState?.confirmDialog();
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2), FilteringTextInputFormatter.allow(RegExp(r'[0-9]')) //限制长度//限制长度
                ],
                decoration: InputDecoration(
                  hintText: "0",
                  hintStyle: textStyle(size: 42, color: ColorConfig.color_999999),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
                ),
                style: textStyle(size: 42, color: ColorConfig.color_282940, letterSpacing: 15.w),
              ),
            ),
          ],
        ),
      ),
      confirmCheckCallback: (value) {
        int? price = int.tryParse(text);
        if (text.isEmpty || price == null) {
          toastMsg("请输入折扣");
          return false;
        } else if (price <= 0) {
          toastMsg("折扣要大于0");
          return false;
        }
        return true;
      },
      confirmCallback: (value) {
        int price = int.parse(text);
        if (text.length == 1) price *= 10; //填入一位数时应乘10
        function.call(price);
      },
    ),
  );
}

/// 抹零
showWipeZero(BuildContext context, int wipeZero, Function(int) function) async {
  var check = await PermissionUtils.checkPermission(PermissionUtils.STORE_SALE_WIPE_OFF);
  if (!check) {
    return;
  }
  var text = "${wipeZero == 0 ? "" : (wipeZero.toDouble().abs() / 100)}";
  var key = GlobalKey<CustomDialogState>();
  var groupValue = (wipeZero >= 0 ? 1 : 2).obs;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => CustomDialog(
      key: key,
      type: 1,
      height: 339,
      outsideDismiss: false,
      content: Column(
        children: [
          Container(
            height: 84.w,
            margin: EdgeInsets.only(left: 50.w, right: 50.w),
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            alignment: Alignment.centerLeft,
            decoration: ShapeDecoration(
              color: Color(ColorConfig.color_f5f5f5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w),
              ),
            ),
            child: Row(
              children: [
                Obx(
                  () => Visibility(
                    child: pText("- ", ColorConfig.color_999999, 42.w),
                    visible: groupValue.value == 2,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: TextEditingController.fromValue(TextEditingValue(
                        text: text, selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: text.length)))),
                    keyboardType: NumberKeyboard.inputType,
                    textAlign: TextAlign.start,
                    onChanged: (value) => text = value,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      text = value;
                      key.currentState?.confirmDialog();
                    },
                    inputFormatters: [NumTextInputFormatter(), NumNegativeInputFormatter(negative: false, decimal: true)],
                    decoration: InputDecoration(
                      hintText: "0.00",
                      hintStyle: textStyle(size: 42, color: ColorConfig.color_999999),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
                    ),
                    style: textStyle(
                      size: 42,
                      color: ColorConfig.color_282940,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pSizeBoxH(30.w),
          Obx(
            () => Row(
              children: [
                pSizeBoxW(50.w),
                pRadio(
                  value: 1,
                  groupValue: groupValue.value,
                  onChange: (value) => groupValue.value = value,
                ),
                pSizeBoxW(10.w),
                pText(
                  '抹正数',
                  groupValue.value == 1 ? ColorConfig.color_333333 : ColorConfig.color_999999,
                  28.w,
                ),
                pSizeBoxW(30.w),
                pRadio(
                  value: 2,
                  groupValue: groupValue.value,
                  onChange: (value) => groupValue.value = value,
                ),
                pSizeBoxW(10.w),
                pText(
                  '抹负数',
                  groupValue.value == 2 ? ColorConfig.color_333333 : ColorConfig.color_999999,
                  28.w,
                ),
              ],
            ),
          ),
        ],
      ),
      confirmCheckCallback: (value) {
        double? price = double.tryParse(text);
        if (text.isEmpty || price == null) {
          toastMsg("请输入正确数字");
          return false;
        } else if (price < 0) {
          toastMsg("请输入正确数字");
          return false;
        }
        return true;
      },
      confirmCallback: (value) {
        int price;
        if (text.contains(".")) {
          var list = text.split(".");
          price = (list[0].length == 0 ? 0 : int.parse(list[0])) * 100;
          if (list[1].length == 1) {
            price += int.parse(list[1]) * 10;
          } else {
            price += int.parse(list[1]);
          }
        } else {
          price = int.parse(text) * 100;
        }
        function.call(price * (groupValue.value == 1 ? 1 : -1));
      },
    ),
  );
}

/// 税率
showTaxDialog(BuildContext context, int tax, Function(int) function) {
  var text = "${tax == 0 ? "" : (tax < 10 ? "0$tax" : tax)}";
  var key = GlobalKey<CustomDialogState>();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => CustomDialog(
      key: key,
      title: '税率',
      type: 1,
      height: 341,
      content: Container(
        height: 84.w,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 84.w,
              margin: EdgeInsets.only(right: 10.w),
              child: pText("0", ColorConfig.color_282940, 42.w),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: Color(ColorConfig.color_FAFAFA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.w),
                ),
              ),
            ),
            pText(".", ColorConfig.color_282940, 42.w),
            Container(
              width: 138.w,
              margin: EdgeInsets.only(left: 10.w),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  color: Color(ColorConfig.color_f5f5f5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.w),
                  )),
              child: TextField(
                controller: TextEditingController.fromValue(TextEditingValue(
                    text: text, selection: TextSelection.fromPosition(TextPosition(affinity: TextAffinity.downstream, offset: text.length)))),
                keyboardType: NumberKeyboard.inputType,
                textAlign: TextAlign.center,
                onChanged: (value) => text = value,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  text = value;
                  key.currentState?.confirmDialog();
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  // NumNegativeInputFormatter(negative: false) //限制长度//限制长度
                ],
                decoration: InputDecoration(
                  hintText: "0",
                  hintStyle: textStyle(size: 42, color: ColorConfig.color_999999),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0.0)),
                ),
                style: textStyle(size: 42, color: ColorConfig.color_282940, letterSpacing: 15.w),
              ),
            ),
          ],
        ),
      ),
      confirmCheckCallback: (value) {
        int? price = int.tryParse(text);
        if (text.isEmpty || price == null) {
          toastMsg("请输入税率");
          return false;
        } else if (price < 0) {
          toastMsg("税率不能为负");
          return false;
        }
        return true;
      },
      confirmCallback: (value) {
        int price = int.parse(text);
        if (text.length == 1) {
          price *= 10; //填入一位数时应乘10
        }
        function.call(price);
      },
    ),
  );
}

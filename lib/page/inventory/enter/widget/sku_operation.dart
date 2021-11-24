import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/sku_operation_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/keyboard/number_keyboard.dart';

// ignore: must_be_immutable
class SkuOperationWidget extends StatelessWidget {
  bool isLast;
  num goodsId;
  int skuId;
  FocusNode? focusNode;

  SkuOperationWidget(this.goodsId, this.skuId,
      {this.isLast = false, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ColorConfig.color_ffffff),
      width: 259.w,
      height: 73.w,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 2,
            child: GetBuilder<SkuOperationController>(
              builder: (ctl) {
                return GestureDetector(
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Icon(Icons.remove),
                        ),
                        Container(
                          width: 1.w,
                          height: 73.w,
                          color: Color(ColorConfig.color_efefef),
                        ),
                      ],
                    ),
                    color: Colors.white,
                  ),
                  onTap: () => ctl.minusNum(skuId),
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: GetBuilder<SkuOperationController>(
              builder: (ctl) {
                return TextField(
                  focusNode: focusNode,
                  style: textStyle(size: 24, color: ColorConfig.color_333333),
                  controller: TextEditingController.fromValue(
                    TextEditingValue(
                      text: getNumText(ctl.getSelectNum(skuId)),
                      // selection: TextSelection.fromPosition(TextPosition(
                      //     affinity: TextAffinity.downstream,
                      //     offset: '${ctl.getSelectNum(skuId)}'.length)),
                      selection: TextSelection.collapsed(
                          offset: getNumOff(ctl.getSelectNum(skuId))),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: NumberKeyboard.inputType,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6)
                  ],
                  enableInteractiveSelection: false,
                  //只允许输入数字
                  textInputAction:
                      isLast ? TextInputAction.done : TextInputAction.next,
                  onChanged: (text) => ctl.updateNum(
                      skuId, int.parse(text.length == 0 ? '0' : text)),
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "0",
                    hintStyle:
                        textStyle(color: ColorConfig.color_999999, size: 30),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0)
                    ),
                    enabledBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 0.0)
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 0.0)),
                  ),
                );
              },
              id: SkuOperationController.bIdSku(skuId),
            ),
          ),
          Expanded(
            flex: 2,
            child: GetBuilder<SkuOperationController>(
              builder: (ctl) {
                return GestureDetector(
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: 1.w,
                          height: 73.w,
                          color: Color(ColorConfig.color_efefef),
                        ),
                        Expanded(
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                    color: Colors.white,
                  ),
                  onTap: () => ctl.addNum(skuId),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String getNumText(int num) => num == 0 ? '' : "$num";

  int getNumOff(int num) => num == 0 ? 0 : num.toString().length;
}

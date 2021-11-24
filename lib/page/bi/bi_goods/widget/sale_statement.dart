import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

saleStatement() {
  return Container(
    margin: EdgeInsets.only(top: 24.w),
    padding: EdgeInsets.only(left: 30.w, right: 30.w),
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.w),
      ),
      color: Color(ColorConfig.color_393a58),
    ),
    child: GetBuilder<BiGoodsController>(
      builder: (ctl) => Column(
        children: [
          saleStatementItem(
            "销售数量",
            "${ctl.saleStatementData?.normalSaleGoodsNum}",
            "销售金额",
            PriceUtils.getPrice(ctl.saleStatementData?.normalSaleTaxAmount),
            ColorConfig.color_1678FF,
          ),
          line(),
          saleStatementItem(
            "退实物数量",
            "${ctl.saleStatementData?.returnGoodsNum}",
            "退实物金额",
            PriceUtils.getPrice(ctl.saleStatementData?.returnAmount),
            ColorConfig.color_ff1a43,
            leftExtra: "(次品${ctl.saleStatementData?.returnSubStandardGoodsNum})",
          ),
          line(),
          saleStatementItem(
            "退欠货数量",
            "${ctl.saleStatementData?.changeBackOrderGoodsNum}",
            "退欠货金额",
            PriceUtils.getPrice(ctl.saleStatementData?.changeBackOrderAmount),
            ColorConfig.color_ff7532,
          ),
          line(),
          saleStatementItem(
            "总交易数量",
            "=${ctl.saleStatementData?.saleGoodsNum}",
            "总交易金额",
            "=${PriceUtils.getPrice(ctl.saleStatementData?.saleTaxAmount)}",
            ColorConfig.color_ffffff,
          ),
        ],
      ),
      id: BiGoodsController.idSaleStatement,
    ),
  );
}

saleStatementItem(
    String leftTitle,
    String leftValue,
    String rightTitle,
    String rightValue,
    int valueColor, {
      String? leftExtra,
      String? rightExtra,
    }) {
  return Row(
    children: [
      item(leftTitle, leftValue, valueColor, extra: leftExtra),
      item(rightTitle, rightValue, valueColor, extra: rightExtra),
    ],
  );
}

item(String title, String value, int valueColor, {String? extra}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        pSizeBoxH(36.w),
        pText(title, ColorConfig.color_ffffff, 24.w),
        pSizeBoxH(10.w),
        Row(
          children: [
            pText(value, valueColor, 28.w),
            Visibility(
              child: pText(extra ?? "", ColorConfig.color_ffffff, 20.w),
              visible: extra != null,
            ),
          ],
        ),
        pSizeBoxH(36.w),
      ],
    ),
  );
}

line() {
  return Divider(
    color: Color(ColorConfig.color_ffffff).withAlpha((25.5).toInt()),
    height: 1.w,
    thickness: 1.w,
  );
}
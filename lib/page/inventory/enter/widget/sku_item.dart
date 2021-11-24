import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/goods_sku_dialog.dart';
import 'package:haidai_flutter_module/page/inventory/enter/widget/sku_operation.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget skuItem(num goodsId, SkuData skuData, bool isLast, {int? count, bool isBottom = false, FocusNode? focusNode}) {
  return Column(
    children: [
      Row(
        children: [
          Container(
            width: 1.w,
            height: 73.w,
            margin: EdgeInsetsDirectional.only(start: 24.w),
            color: Color(ColorConfig.color_efefef),
          ),
          Container(
            color: Color(ColorConfig.color_ffffff),
            width: 146.w,
            height: 73.w,
            child: Center(
              child: Text(
                "${skuData.isHeader ? skuData.colorName : ""}",
                style: textStyle(size: 24),
              ),
            ),
          ),
          Container(
            width: 1.w,
            height: 73.w,
            color: Color(ColorConfig.color_efefef),
          ),
          Container(
            color: Color(ColorConfig.color_ffffff),
            width: 148.w,
            height: 73.w,
            child: Center(
              child: Text(
                "${skuData.sizeName}",
                style: textStyle(size: 24, color: ColorConfig.color_999999),
              ),
            ),
          ),
          Container(
            width: 1.w,
            height: 73.w,
            color: Color(ColorConfig.color_efefef),
          ),
          Container(
            color: Color(ColorConfig.color_ffffff),
            width: 145.w,
            height: 73.w,
            child: Center(
              child: Text(
                "${skuData.stockNum}",
                style: textStyle(size: 24, color: ColorConfig.color_999999),
              ),
            ),
          ),
          Container(
            width: 1.w,
            height: 73.w,
            color: Color(ColorConfig.color_efefef),
          ),
          skuCountWidget(goodsId, skuData, count, isBottom, focusNode: focusNode),
          Container(
            width: 1.w,
            height: 73.w,
            color: Color(ColorConfig.color_efefef),
          ),
        ],
      ),
      Divider(
        color: Color(ColorConfig.color_efefef),
        height: 1.w,
        indent: isLast? 24.w : 170.w,
        endIndent: 24.w,
      )
    ],
  );
}

///count为空返回可以操作控件，不为空返回不可操作控件
Widget skuCountWidget(num goodsId, SkuData skuData, int? count, bool isBottom, {FocusNode? focusNode}) {
  if (count == null) {
    return SkuOperationWidget(
      goodsId,
      skuData.skuId!,
      isLast: isBottom,
      focusNode: focusNode,
    );
  } else {
    return Container(
      width: 259.w,
      height: 73.w,
      child: Center(
        child: Text(
          "$count",
          style:
              textStyle(size: 24, bold: true, color: ColorConfig.color_1678FF),
        ),
      ),
    );
  }
}

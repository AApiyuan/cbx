import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/controller/bi_customer_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

sortWidget(Function update) {
  return Container(
    child: Container(
      height: 44.w,
      child: GetBuilder<BiCustomerController>(
        builder: (ctl) {
          String left = "销量";
          String right = "销售额";
          String leftSortType = "normalSaleGoodsNum";
          String rightSortType = "normalSaleTaxAmount";
          switch (ctl.listType) {
            case BiCustomerController.SALE_LIST_TYPE_OWE:
              left = "退欠货";
              right = "退欠货额";
              leftSortType = "changeBackOrderGoodsNum";
              rightSortType = "changeBackOrderAmount";
              break;
            case BiCustomerController.SALE_LIST_TYPE_RETURN:
              left = "退实物";
              right = "退实物额";
              leftSortType = "returnGoodsNum";
              rightSortType = "returnAmount";
              break;
            case BiCustomerController.SALE_LIST_TYPE_TOTAL:
              left = "交易数";
              right = "交易额";
              leftSortType = "saleGoodsNum";
              rightSortType = "saleTaxAmount";
              break;
            case BiCustomerController.SALE_LIST_TYPE_REMIT:
              left = "收入";
              right = "支出";
              leftSortType = "receivedAmount";
              rightSortType = "refundAmount";
              break;
          }
          return Row(
            children: [
              Expanded(
                child: pText(
                  "序号",
                  ColorConfig.color_ffffff,
                  24.w,
                  padding: EdgeInsets.only(left: 30.w),
                ),
              ),
              pText("客户", ColorConfig.color_ffffff, 24.w,
                  width: 268.w, alignment: Alignment.centerLeft),
              sortBtn(left, 120.w, leftSortType, ctl, update),
              sortBtn(right, 200.w, rightSortType, ctl, update),
            ],
          );
        },
        id: BiCustomerController.idStatementSort,
      ),
      color: Color(ColorConfig.color_000000).withAlpha((255 * 0.08).toInt()),
    ),
    color: Color(ColorConfig.color_393a58),
  );
}

sortBtn(String title, double width, String sortType, BiCustomerController ctl,
    Function update) {
  String image = "images/no_sort.png";
  if (sortType == ctl.sortType) {
    if (ctl.sortByDesc) {
      image = "images/down_sort.png";
    } else {
      image = "images/up_sort.png";
    }
  }
  return GestureDetector(
    child: Container(
      child: Row(
        children: [
          pText(title, ColorConfig.color_ffffff, 24.w),
          pSizeBoxW(4.w),
          pImage(image, 24.w, 24.w),
        ],
      ),
      width: width,
    ),
    onTap: () {
      update.call();
      ctl.updateOrderBy(sortType);
    },
  );
}

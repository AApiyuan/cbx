import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/model/enum/order_by.dart' as OrderByEnum;
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

// ignore: must_be_immutable
class SortDialog extends Dialog {
  ///stockNum 库存量，欠货 oweNum,saleNum 销量，substandardNum 次品数,sailingPrice 销售价
  ///onSaleTime 上架时间,updatedTime 更新时间,goodsSerial 货号，goodsName 品名
  static final orderBy = [
    _orderBy("updatedTime", false),
    _orderBy("goodsSerial", true),
    _orderBy("goodsSerial", false),
    _orderBy("saleNum", true),
    _orderBy("saleNum", false),
    _orderBy("stockNum", true),
    _orderBy("stockNum", false),
    _orderBy("sailingPrice", true),
    _orderBy("sailingPrice", false),
    _orderBy("onSaleTime", true),
    _orderBy("onSaleTime", false),
    _orderBy("substandardNum", true),
    _orderBy("substandardNum", false),
    _orderBy("oweNum", true),
    _orderBy("oweNum", false),
  ];
  static final name = [
    "最近更新",
    "货号-升序ABC",
    "货号-降序ZYX",
    "销量-升序",
    "销量-降序",
    "正品库存-升序",
    "正品库存-降序",
    "价格-升序",
    "价格-降序",
    "最早上架",
    "最新上架",
    "次品数-升序",
    "次品数-降序",
    "欠货数-升序",
    "欠货数-降序",
  ];

  static _orderBy(String field, bool asc) {
    OrderBy orderBy = OrderBy();
    orderBy.field = field;
    orderBy.by = asc ? OrderByEnum.OrderBy.ASC : OrderByEnum.OrderBy.DESC;
    return orderBy;
  }

  Function(OrderBy orderBy, String name)? onTap;
  String selectName;

  double top;

  Function? onBack;

  SortDialog(this.selectName, {this.onTap, this.top = 0, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: top,
          ),
          onTap: () => onBack?.call(),
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              itemBuilder: (context, index) => listItem(context, index),
              itemCount: name.length,
            ),
            color: Colors.white,
          ),
        )
      ],
    );
  }

  listItem(BuildContext context, int index) {
    int num = index % 4;
    return GestureDetector(
      child: Container(
        color: num == 0 || num == 3
            ? Color(ColorConfig.color_F5FAFF)
            : Colors.white,
        height: 64.w,
        alignment: Alignment.centerLeft,
        margin: EdgeInsetsDirectional.only(start: 24.w),
        child: Text(
          name[index],
          style: textStyle(
              color: name[index] == selectName
                  ? ColorConfig.color_1678FF
                  : ColorConfig.color_666666),
        ),
      ),
      onTap: () {
        onBack?.call();
        onTap?.call(orderBy[index], name[index]);
        // Navigator.pop(context);
      },
    );
  }
}

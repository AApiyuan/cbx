import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

class PlanData extends StatelessWidget {
  PlanData({
    Key? key,
    required this.alreadyTitle,
    required this.notYetTitle,
    required this.inventoryStyleNum,
    this.inventoryNum = 0,
    required this.noInventoryStyleNum,
    this.notYetPlanNum = 0,
    required this.profitStyleNum,
    required this.profitNum,
    required this.lossStyleNum,
    required this.lossNum,
    required this.noProfitStyleNum,
    required this.noProfitNum,
    required this.noLossStyleNum,
    required this.noLossNum,
  }) : super(key: key);

  /// 已盘标题
  final String alreadyTitle;

  /// 未盘标题
  final String notYetTitle;

  /// 已盘款数
  final int inventoryStyleNum;

  /// 已盘商品数量
  final int inventoryNum;

  /// 未盘款数
  final int noInventoryStyleNum;

  /// 未盘数量
  final int notYetPlanNum;

  /// 已盘盈利款数
  final int profitStyleNum;

  ///  已盘盈利数量
  final int profitNum;

  /// 已盘亏损款数
  final int lossStyleNum;

  /// 已盘亏损数量
  final int lossNum;

  /// 未盘盈利款数
  final int noProfitStyleNum;

  ///  未盘盈利数量
  final int noProfitNum;

  /// 未盘亏损款数
  final int noLossStyleNum;

  /// 未盘亏损数量
  final int noLossNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: BorderDirectional(
                  end: borderSide(),
                  bottom: borderSide(),
                ),
              ),
              child: _PlanDataItem(
                title: alreadyTitle,
                goodsStyleNum: inventoryStyleNum,
                goodsNum: inventoryNum,
                profitStyleNum: profitStyleNum,
                profitNum: profitNum,
                lossStyleNum: lossStyleNum,
                lossNum: lossNum,
              ),
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: BorderDirectional(
                  bottom: borderSide(),
                ),
              ),
              child: _PlanDataItem(
                title: notYetTitle,
                goodsStyleNum: noInventoryStyleNum,
                goodsNum: notYetPlanNum,
                profitStyleNum: noProfitStyleNum,
                profitNum: noProfitNum,
                lossStyleNum: noLossStyleNum,
                lossNum: noLossNum,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanDataItem extends StatelessWidget {
  _PlanDataItem({
    Key? key,
    required this.title,
    required this.goodsStyleNum,
    required this.goodsNum,
    required this.profitStyleNum,
    required this.profitNum,
    required this.lossStyleNum,
    required this.lossNum,
  }) : super(key: key);

  /// 标题
  final String title;

  /// 商品款数
  final int goodsStyleNum;

  /// 商品数量
  final int goodsNum;

  /// 盈利款数
  final int profitStyleNum;

  ///  盈利数量
  final int profitNum;

  /// 亏损款数
  final int lossStyleNum;

  /// 亏损数量
  final int lossNum;

  @override
  Widget build(BuildContext context) {
    final _styleAndNum =
        this.goodsNum == 0 ? "$goodsStyleNum款" : "$goodsStyleNum款/$goodsNum件";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 31.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.title,
            style: TextStyle(
              fontSize: 24.w,
              color: Color(ColorConfig.color_999999),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 26.w),
            child: Text(
              _styleAndNum,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(ColorConfig.color_333333),
                fontSize: 32.w,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.w),
            child: Row(
              children: [
                Image(
                  width: 24.w,
                  height: 24.w,
                  image: AssetImage("images/home_check_more.png"),
                ),
                Text(
                  "$profitStyleNum款盘盈$profitNum",
                  style: TextStyle(
                    fontSize: 24.w,
                    color: Color(ColorConfig.color_666666),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12.w),
            child: Row(
              children: [
                Image(
                  width: 24.w,
                  height: 24.w,
                  image: AssetImage("images/home_check_less.png"),
                ),
                Text(
                  "$lossStyleNum款盘亏$lossNum",
                  style: TextStyle(
                    fontSize: 24.w,
                    color: Color(ColorConfig.color_666666),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

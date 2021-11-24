import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/enum/order_stock_goods_type.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/inventory/difference/controller/inventory_goods_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';

class GoodsItem extends StatelessWidget {
  GoodsItem(
    this.goodsId, {
    Key? key,
    this.imgPath,
    this.cover,
    required this.name,
    this.serial,
    required this.stockNum,
    required this.realNum,
    required this.profitNum,
    required this.lessNum,
    this.type = "default",
    required this.index,
  }) : super(key: key);

  /// 商品id
  final int goodsId;

  /// 商品图片
  final String? imgPath;

  final String? cover;

  /// 商品名称
  final String name;

  /// 商品货号
  final String? serial;

  /// 正品库存
  final int stockNum;

  /// 实盘数量
  final int realNum;

  /// 盘盈数量
  final int profitNum;

  /// 盘亏数量
  final int lessNum;

  /// 类型
  final String type;

  /// sku Item 高度
  final double _skuItemHeight = 74.w;

  /// sku bar 高度
  final double _skuBarHeight = 56.w;

  /// item 高度
  final double _height = 140.w;

  /// 索引
  final int index;

  bool _isNormal() {
    return type == OrderStockGoodsTypeEnum.NORMAL;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildGoods(),
        _buildSku(),
      ],
    );
  }

  Widget _buildGoods() {
    return Container(
      height: _height,
      width: double.infinity,
      margin: EdgeInsets.only(top: index == 0 ? 24.w : 56.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(children: [
        NetImageWidget(
          "$imgPath/$cover",
          goodsId: goodsId,
        ),
        Expanded(
            child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            margin: EdgeInsets.only(left: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "$serial ${name.isEmpty ? "" : "-" } $name",
                    style: TextStyle(
                      fontSize: 28.w,
                      fontWeight: FontWeight.bold,
                      color: Color(ColorConfig.color_333333),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  width: 450.w,
                ),
                Text(
                  "${_getStockStr()}$stockNum | ${_getInventoryStr()}$realNum",
                  style: TextStyle(
                      fontSize: 24.w, color: Color(ColorConfig.color_999999)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "盘盈$profitNum",
                        style: TextStyle(
                            fontSize: 24.w,
                            fontWeight: FontWeight.bold,
                            color: Color(ColorConfig.color_1678ff)),
                        children: [
                          TextSpan(
                            text: " 盘亏${lessNum.abs()}",
                            style: TextStyle(
                              fontSize: 24.w,
                              fontWeight: FontWeight.bold,
                              color: Color(ColorConfig.color_FA6400),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GetBuilder<InventoryGoodsController>(
                          id: "$type-$goodsId",
                          tag: type,
                          builder: (ctl) {
                            return Text(
                              ctl.isExpand(goodsId) ? "收起" : "展开",
                              style: TextStyle(
                                fontSize: 24.w,
                                color: Color(ColorConfig.color_999999),
                              ),
                            );
                          },
                        ),
                        GetBuilder<InventoryGoodsController>(
                          id: "$type-$goodsId",
                          tag: type,
                          builder: (ctl) {
                            return Image.asset(
                              ctl.isExpand(goodsId)
                                  ? "images/icon_up.png"
                                  : "images/icon_down.png",
                              height: 24.w,
                              width: 24.w,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            Get.find<InventoryGoodsController>(tag: type)
                .getInventoryRecordGoodsSku(goodsId);
          },
        )),
      ]),
    );
  }

  String _getStockStr() {
    return _isNormal() ? "正品库存" : "次品库存";
  }

  String _getInventoryStr() {
    return _isNormal() ? "正品实盘" : "次品实盘";
  }

  Widget _buildSku() {
    return GetBuilder<InventoryGoodsController>(
      id: "$type-$goodsId",
      tag: type,
      builder: (ctl) {
        final list = ctl.goodsSku["$type-$goodsId"];
        if (list == null) {
          return SizedBox.shrink();
        }
        return Visibility(
          child: Container(
            margin: EdgeInsets.fromLTRB(24.w, 17.w, 24.w, 0),
            child: Column(
              children: _buildSkuItem(list),
            ),
          ),
          visible: ctl.isExpand(goodsId),
        );
      },
    );
  }

  List<Widget> _buildSkuItem(List<SkuInfoEntity> data) {
    List<Widget> children = <Widget>[];
    data.forEach((sku) {
      List<SkuInfoSize> sizes = <SkuInfoSize>[];
      if (sku.sizes != null) {
        for (var i = 0; i < sku.sizes!.length; i++) {
          var size = sku.sizes![i];
          int diff =
              (size.data?.inventoryStock ?? 0) - (size.data?.snapStock ?? 0);
          if (diff == 0) {
            continue;
          }
          sizes.add(size);
        }
      }

      for (var i = 0; i < sizes.length; i++) {
        var size = sizes[i];
        int diff =
            (size.data?.inventoryStock ?? 0) - (size.data?.snapStock ?? 0);
        Widget child = _buildSkuRow(i == 0, size, sku.goodsColor?.name ?? "",
            i == sizes.length - 1, diff);
        children.add(child);
      }
    });
    if (children.length > 0) {
      children.insert(0, _createSkuBar());
    }
    return children;
  }

  /// 创建sku行
  Widget _buildSkuRow(
    bool isFirst,
    SkuInfoSize size,
    String color,
    bool isLast,
    int diff,
  ) {
    String diffText = diff >= 0 ? "盈$diff" : "亏${diff.abs()}";
    int diffColor =
        diff >= 0 ? ColorConfig.color_1678ff : ColorConfig.color_FA6400;
    return Row(
      children: [
        Expanded(
          child: _createItem(isLast, isFirst ? color : "",
              style: textStyle(size: 24, bold: true)),
        ),
        Expanded(
          child: _createItem(true, size.goodsSize?.name ?? ""),
        ),
        Expanded(
          child: _createItem(true, "${size.data?.snapStock}"),
        ),
        Expanded(
          child: _createItem(true, "${size.data?.inventoryStock ?? 0}"),
        ),
        _createItem(
          true,
          diffText,
          width: 115.w,
          style: textStyle(size: 24, bold: true, color: diffColor),
        ),
      ],
    );
  }

  Widget _createSkuBar() {
    return Row(
      children: [
        _createSkuBarItem("颜色"),
        _createSkuBarItem("尺码"),
        _createSkuBarItem(_getStockStr()),
        _createSkuBarItem(_getInventoryStr()),
        _createItem(
          true,
          "差异",
          style: textStyle(size: 24, color: ColorConfig.color_666666),
          color: ColorConfig.color_f5f5f5,
          height: _skuBarHeight,
          width: 115.w,
        ),
      ],
    );
  }

  Widget _createSkuBarItem(String text) {
    return Expanded(
      child: _createItem(
        true,
        text,
        style: textStyle(size: 24, color: ColorConfig.color_666666),
        color: ColorConfig.color_f5f5f5,
        height: _skuBarHeight,
      ),
    );
  }

  Widget _createItem(
    bool isShowBottomBorder,
    String text, {
    TextStyle? style,
    int? color,
    double? height,
    double width = 0,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: BorderDirectional(
          start: borderSide(),
          bottom: borderSide(
              color: isShowBottomBorder
                  ? ColorConfig.color_efefef
                  : ColorConfig.color_00000000),
          end: borderSide(),
        ),
        color: Color(color ?? ColorConfig.color_00000000),
      ),
      child: Container(
        alignment: Alignment.center,
        height: height ?? _skuItemHeight,
        width: width,
        child: Text(
          text,
          style: style == null
              ? textStyle(size: 24, color: ColorConfig.color_999999)
              : style,
        ),
      ),
    );
  }
}

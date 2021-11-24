import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/model/rep/inventory_record_do_entity.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/inventory_data_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import 'goods_sku_dialog.dart';

// ignore: must_be_immutable
class InventoryDataDialog extends StatelessWidget {
  TextEditingController? _textEditingController;

  InventoryDataController? _inventoryDataController;

  late BuildContext context;

  InventoryDataController get controller {
    if (_inventoryDataController == null) {
      _inventoryDataController = Get.find<InventoryDataController>();
    }
    return _inventoryDataController!;
  }

  InventoryDataDialog(int orderId) {
    Get.lazyPut(() => InventoryDataController(orderId));
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Column(
      children: [
        pSizeBoxH(24.w),
        _searchBar(),
        _goodsList(),
      ],
    );
  }

  _searchBar() {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                height: 76.w,
                margin: EdgeInsetsDirectional.only(
                    start: 24.w, end: 24.w, bottom: 20.w),
                padding: EdgeInsetsDirectional.only(end: 20.w),
                decoration: ShapeDecoration(
                  color: Color(ColorConfig.color_efefef),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(38.w)),
                  ),
                ),
                child: GetBuilder<InventoryDataController>(
                  id: InventoryDataController.idSearchClear,
                  builder: (ctl) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: textStyle(),
                            textInputAction: TextInputAction.search,
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: "搜索品名货号",
                              contentPadding:
                                  EdgeInsetsDirectional.only(start: 20.w),
                              hintStyle:
                                  textStyle(color: ColorConfig.color_999999),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (text) => controller.searchGoods(text),
                            onTap: () => controller.openSearch(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        GetBuilder<InventoryDataController>(
          id: InventoryDataController.idSearchClose,
          builder: (ctl) {
            return Visibility(
              child: Container(
                height: 76.w,
                alignment: Alignment.center,
                margin: EdgeInsetsDirectional.only(end: 24.w, bottom: 20.w),
                child: GestureDetector(
                  child: Text(
                    "取消",
                    style: textStyle(color: ColorConfig.color_666666),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    controller.closeSearch();
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              visible: controller.isSearch,
            );
          },
        ),
      ],
    );
  }

  _goodsList() {
    return GetBuilder<InventoryDataController>(
      builder: (ctl) => Expanded(
        child: ListView.builder(
          itemBuilder: (_, index) => _listItem(ctl, index),
          itemCount: ctl.dataList.length,
        ),
      ),
      id: InventoryDataController.idGoodsList,
    );
  }

  _listItem(InventoryDataController ctl, int index) {
    if (ctl.dataList[index] is InventoryRecordGoods) {
      return _goodsItem(ctl, ctl.dataList[index] as InventoryRecordGoods);
    } else if (ctl.dataList[index] is SkuData) {
      var isLast = ctl.dataList.length - 1 == index ||
          ctl.dataList[index + 1] is InventoryRecordGoods ||
          (ctl.dataList[index + 1] is SkuData &&
              (ctl.dataList[index + 1] as SkuData).colorName != null);
      return _skuItem(ctl, ctl.dataList[index] as SkuData, isLast);
    } else {
      return _skuBar(ctl);
    }
  }

  _goodsItem(InventoryDataController ctl, InventoryRecordGoods goods) {
    return Container(
      color: Color(ColorConfig.color_ffffff),
      height: 172.w,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => ctl.changeFlex(goods.id!),
        child: Stack(
          children: [
            Positioned(
              top: 16.w,
              child: NetImageWidget(
                "${goods.storeGoodsBaseDo.imgPath}/${goods.storeGoodsBaseDo.cover}",
                margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
              ),
            ),
            Positioned(
              top: 16.w,
              left: 180.w,
              child: Text(
                GoodsUtils.getGoodsTitle(goods.storeGoodsBaseDo.goodsSerial,
                    goods.storeGoodsBaseDo.goodsName),
                style: textStyle(bold: true),
              ),
            ),
            Positioned(
              left: 180.w,
              bottom: 16.w,
              child: Text(
                "盘点${ctl.goodsSkuCountMap[goods.id]}",
                style: textStyle(
                    size: 24, color: ColorConfig.color_1678FF, bold: true),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 16.w,
              child: Container(
                child: GetBuilder<InventoryDataController>(
                  builder: (ctl) {
                    return Row(
                      children: [
                        Text(
                          ctl.goodsFlexMap[goods.id] ?? false ? "收起" : "展开",
                          style: textStyle(
                              size: 24, color: ColorConfig.color_999999),
                        ),
                        Image.asset(
                          ctl.goodsFlexMap[goods.id] ?? false
                              ? "images/icon_up.png"
                              : "images/icon_down.png",
                          height: 24.w,
                          width: 24.w,
                        ),
                      ],
                    );
                  },
                  id: InventoryDataController.idGoodsFlex(goods.id!),
                ),
                padding: EdgeInsetsDirectional.only(
                    start: 25.w, end: 25.w, top: 60.w),
              ),
            ),
            Positioned(
              left: 180.w,
              bottom: 70.w,
              child: Text(
                "${ctl.isSubstandard ? '次品库存' : '正品库存'}${goods.stockNum}",
                style: textStyle(size: 24, color: ColorConfig.color_999999),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _skuItem(InventoryDataController ctl, SkuData skuData, bool isLast) {
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
                  "${skuData.colorName ?? ""}",
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
            Container(
              width: 259.w,
              height: 73.w,
              child: Center(
                child: Text(
                  "${skuData.inventoryNum}",
                  style: textStyle(
                      size: 24, bold: true, color: ColorConfig.color_1678FF),
                ),
              ),
            ),
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
          indent: isLast ? 24.w : 170.w,
          endIndent: 24.w,
        )
      ],
    );
  }

  _skuBar(InventoryDataController ctl) {
    return Row(
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(start: 24.w),
          color: Color(ColorConfig.color_f5f5f5),
          width: 147.w,
          height: 56.w,
          child: Center(
            child: Text(
              "颜色",
              style: textStyle(size: 24, color: ColorConfig.color_666666),
            ),
          ),
        ),
        Container(
          width: 1.w,
          height: 56.w,
          color: Color(ColorConfig.color_dcdcdc),
        ),
        Container(
          color: Color(ColorConfig.color_f5f5f5),
          width: 148.w,
          height: 56.w,
          child: Center(
            child: Text(
              "尺码",
              style: textStyle(size: 24, color: ColorConfig.color_666666),
            ),
          ),
        ),
        Container(
          width: 1.w,
          height: 56.w,
          color: Color(ColorConfig.color_dcdcdc),
        ),
        Container(
          color: Color(ColorConfig.color_f5f5f5),
          width: 145.w,
          height: 56.w,
          child: Center(
            child: Text(
              ctl.isSubstandard ? "次品库存" : "正品库存",
              style: textStyle(size: 24, color: ColorConfig.color_666666),
            ),
          ),
        ),
        Container(
          width: 1.w,
          height: 56.w,
          color: Color(ColorConfig.color_dcdcdc),
        ),
        Container(
          color: Color(ColorConfig.color_f5f5f5),
          width: 259.w,
          height: 56.w,
          child: Center(
            child: Text(
              "盘点数量",
              style: textStyle(size: 24, color: ColorConfig.color_666666),
            ),
          ),
        ),
      ],
    );
  }
}

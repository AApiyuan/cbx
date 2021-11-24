import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkDetailsMain.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/goods_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/shop_car_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/sku_operation_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/goods_sku_dialog.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/simple_dialog.dart';

// ignore: must_be_immutable
class ShopCarGoods extends StatelessWidget {
  Goods goods;
  final bool onlyCheck;
  final bool isSubstandard;
  late GoodsController _goodsController;
  late ShopCarController _carController;
  late SkuOperationController _skuController;
  String? cTag;

  ShopCarGoods(this.goods, {this.onlyCheck = false, this.isSubstandard = false}) {
    cTag = onlyCheck ? CheckDetailsMain.cShopCarTag : null;
    _carController = Get.find<ShopCarController>(tag: cTag);
    String? gTag = onlyCheck ? CheckDetailsMain.cGoodsTag : null;
    _goodsController = Get.find<GoodsController>(tag: gTag);
    if (!onlyCheck) _skuController = Get.find<SkuOperationController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ColorConfig.color_ffffff),
      height: 172.w,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _carController.changeFlex(goods.id!),
        child: Stack(
          children: [
            Positioned(
              top: 16.w,
              child: NetImageWidget(
                "${goods.imgPath}/${goods.cover}",
                margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
              ),
            ),
            Positioned(
              top: 16.w,
              left: 180.w,
              child: Text(
                "${goods.goodsSerial}${goods.goodsName?.length == 0 ? "" : "-${goods.goodsName}"}",
                style: textStyle(bold: true),
              ),
            ),
            Visibility(
              child: Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 7.w, bottom: 23.w),
                    child: Image.asset(
                      "images/del_pic.png",
                      width: 42.w,
                      height: 42.w,
                    ),
                    color: Colors.transparent,
                  ),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => CheckDialog(
                      "确定删除选择的货品吗？",
                      checkStyle: CheckDialog.redCheckStyle,
                      checkFunction: () => _carController.removeGoods(goods.id!),
                    ),
                  ),
                ),
              ),
              visible: !onlyCheck,
            ),
            Positioned(
              left: 180.w,
              bottom: 16.w,
              child: GetBuilder<ShopCarController>(
                tag: cTag,
                builder: (ctl) {
                  return Text(
                    "盘点${_carController.goodsSelectCount(goods.id!)}",
                    style: textStyle(
                        size: 24, color: ColorConfig.color_1678FF, bold: true),
                  );
                },
                id: ShopCarController.bIdCarGoods(goods.id!),
              ),
            ),
            Visibility(
              child: Positioned(
                right: 205.w,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => showSkuDialog(context, true),
                  child: Container(
                    child: Text(
                      "叠加",
                      style: textStyle(size: 24, color: ColorConfig.color_999999),
                    ),
                    padding: EdgeInsetsDirectional.only(start: 18.w, end: 18.w, top: 16.w, bottom: 16.w),
                    color: Colors.transparent,
                  ),
                ),
              ),
              visible: !onlyCheck,
            ),
            Visibility(
              child: Positioned(
                right: 121.w,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => showSkuDialog(context, false),
                  child: Container(
                    child: Text(
                      "编辑",
                      style: textStyle(size: 24, color: ColorConfig.color_999999),
                    ),
                    padding: EdgeInsetsDirectional.only(start: 18.w, end: 18.w, top: 16.w, bottom: 16.w),
                    color: Colors.transparent,
                  ),
                ),
              ),
              visible: !onlyCheck,
            ),
            Positioned(
              right: 0,
              bottom: 16.w,
              child: Container(
                child: GetBuilder<ShopCarController>(
                  tag: cTag,
                  builder: (ctl) {
                    return Row(
                      children: [
                        Text(
                          ctl.isFlex(goods.id!) ? "收起" : "展开",
                          style: textStyle(
                              size: 24, color: ColorConfig.color_999999),
                        ),
                        Image.asset(
                          ctl.isFlex(goods.id!)
                              ? "images/icon_up.png"
                              : "images/icon_down.png",
                          height: 24.w,
                          width: 24.w,
                        ),
                      ],
                    );
                  },
                  id: ShopCarController.bIdCarGoodsFlex(goods.id!),
                ),
                padding: EdgeInsetsDirectional.only(
                    start: 25.w, end: 25.w, top: 60.w),
              ),
            ),
            Visibility(
              child: Positioned(
                left: 180.w,
                bottom: 70.w,
                child: Text(
                  "${isSubstandard ? '次品库存':'正品库存'}${goods.stockNum}",
                  style: textStyle(size: 24, color: ColorConfig.color_999999),
                ),
              ),
              visible: onlyCheck,
            ),
          ],
        ),
      ),
    );
  }

  showSkuDialog(BuildContext context, bool add) {
    _goodsController.getSkuList(goods.id!).then(
      (skuList) {
        Map<int, int> selectSkuMap = LinkedHashMap();
        skuList.forEach((element) => selectSkuMap[element.skuId!] = add
            ? 0
            : _carController.goodsSkuSelectCount(goods.id!, element.skuId!));
        _skuController.setSkuData(selectSkuMap);
        //显示
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (context) => GoodsSkuDialog(goods, skuList, add),
        );
      },
    );
  }
}

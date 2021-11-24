import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/direct_deliver/controller/direct_deliver_controller.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/res/delivery_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/widget/clear_dialog.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/add_sku.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/mix_sku_edit_list_view.dart';
import 'package:haidai_flutter_module/widget/more_dialog.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget goodsList() {
  return Expanded(
    child: GetBuilder<DirectDeliverController>(
      builder: (ctl) {
        // if (ctl.goodsList.length < 1) {
        //   return emptyWidget();
        // }
        return MixSkuEditListView(
          data: ctl.goodsList,
          skuMap: ctl.skuMap,
          mainItem: _listItem,
          mainItemType: 'DeliveryDetailDoDeliveryGoodsList',
          controller: ctl,
          negative: false,
          topItem: [header()],
          thirdTagName: "欠货",
          thirdTag: 'shortageNum',
          thirdTagExtra: "stockNum",
          thirdTagNameExtra: "库存",
          thirdTagColor: ColorConfig.color_FF3715,
          handleTagName: "数量",
          // onKeyBordChange: (change) => ctl.onKeyBordChange(change),
          handleTag: 'num',
          handleOverThird: false,
          uniKey: "orderSaleGoodsId",
          callBack: (int key, int index, int itemAdd, int itemMinus) {
            ctl.updateGoodsNum(key, itemAdd);
          },
        );
      },
      id: DirectDeliverController.idGoodsList,
    ),
  );
}

_listItem(int index, state) {
  var key = GlobalKey();
  return GetBuilder<DirectDeliverController>(
    builder: (ctl) {
      var goods = ctl.goodsList[index] as DeliveryDetailDoDeliveryGoodsList;
      bool showHead = ctl.checkOrderHead(goods, index);
      return GestureDetector(
        child: Stack(
          children: [
            Column(
              children: [
                Visibility(
                  child: pSizeBoxH(24.w),
                  visible: showHead,
                ),
                Visibility(
                  child: Row(
                    children: [
                      pSizeBoxW(24.w),
                      pImage("images/order_icon.png", 22.w, 26.w),
                      pSizeBoxW(6.w),
                      pText(
                        "销售单${goods.orderSaleSerial}",
                        ColorConfig.color_333333,
                        28.w,
                      ),
                      Expanded(child: Container()),
                      pText(
                        "${goods.orderSaleCustomizeTime}",
                        ColorConfig.color_999999,
                        24.w,
                      ),
                      pSizeBoxW(24.w),
                    ],
                  ),
                  visible: showHead,
                ),
                pSizeBoxH(16.w),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pSizeBoxW(24.w),
                    NetImageWidget(
                      GoodsUtils.getGoodsCover(
                        goods.storeGoods?.imgPath,
                        goods.storeGoods?.cover,
                      ),
                      width: 160,
                      height: 160,
                    ),
                    pSizeBoxW(16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pText(
                          GoodsUtils.getGoodsTitle(
                            goods.storeGoods?.goodsSerial,
                            goods.storeGoods?.goodsName,
                          ),
                          ColorConfig.color_333333,
                          32.w,
                          fontWeight: FontWeight.bold,
                          width: 360.w,
                          alignment: Alignment.centerLeft,
                        ),
                        pSizeBoxH(15.w),
                        pText(
                          "正品库存${goods.stockNum}",
                          ColorConfig.color_999999,
                          28.w,
                          textAlign: TextAlign.start,
                        ),
                        pSizeBoxH(15.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            pText(
                              "欠${goods.shortageNum}",
                              ColorConfig.color_FF3715,
                              32.w,
                              fontWeight: FontWeight.bold,
                              alignment: Alignment.centerLeft,
                            ),
                            pSizeBoxW(16.w),
                            fillGoodsBtn(goods.orderSaleGoodsId!, state),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Visibility(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: pText("备注：${goods.remark}", ColorConfig.color_F3AE1F, 24.w),
                    height: 44.w,
                    margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.w),
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      color: Color(ColorConfig.color_f5f5f5),
                    ),
                  ),
                  visible: goods.remark?.isNotEmpty ?? false,
                ),
                pSizeBoxH(16.w),
              ],
            ),
            Positioned(
              child: GestureDetector(
                child: pImage("images/more.png", 48.w, 28.w, key: key),
                behavior: HitTestBehavior.opaque,
                onTap: () => showMoreDialog(key, ctl, goods, state, index),
              ),
              right: 102.w,
              top: showHead ? 85.w : 20.w,
            ),
            Positioned(
              child: GestureDetector(
                child: pImage("images/icon_dialog_close.png", 42.w, 42.w),
                behavior: HitTestBehavior.opaque,
                onTap: () => showDeleteDialog(() {
                  state.delete(index, goods.orderSaleGoodsId);
                  ctl.deleteGoods(goods.orderSaleGoodsId!);
                }),
              ),
              right: 24.w,
              top: showHead ? 79.w : 14.w,
            ),
            Positioned(
              child: GetBuilder<DirectDeliverController>(
                builder: (ctl) => pText(
                  "发${ctl.getGoodsNum(goods.orderSaleGoodsId!)}",
                  ColorConfig.color_1678FF,
                  32.w,
                  fontWeight: FontWeight.bold,
                ),
                id: DirectDeliverController.idGoodsNum(goods.orderSaleGoodsId),
              ),
              right: 52.w,
              top: showHead ? 200.w : 135.w,
            ),
            Positioned(
              child: pImage("images/icon_down.png", 28.w, 22.w),
              right: 24.w,
              top: showHead ? 215.w : 150.w,
            ),
          ],
        ),
        behavior: HitTestBehavior.opaque,
        onTap: () {
          state.operator(index, goods.orderSaleGoodsId);
          ctl.update([DirectDeliverController.idHeader]);
        },
      );
    },
  );
}

fillGoodsBtn(int orderSaleGoodsId, state) {
  return GetBuilder<DirectDeliverController>(
      builder: (ctl) {
        var isFill = ctl.isFillGoods(orderSaleGoodsId);
        return GestureDetector(
          child: Container(
            height: 32.w,
            width: 102.w,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.w),
              ),
              color: Color(isFill ? ColorConfig.color_1678FF : ColorConfig.color_efefef),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pImage(isFill ? "images/all_icon.png" : "images/none_icon.png", 20.w, 20.w),
                pSizeBoxW(8.w),
                pText(
                  "全发",
                  isFill ? ColorConfig.color_ffffff : ColorConfig.color_1678FF,
                  24.w,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          onTap: () => isFill ? ctl.clearGoods(orderSaleGoodsId, state) : ctl.fillGoods(orderSaleGoodsId, state),
        );
      },
      id: DirectDeliverController.idFillGoods(orderSaleGoodsId));
}

showMoreDialog(GlobalKey<State<StatefulWidget>> key, DirectDeliverController controller,
    DeliveryDetailDoDeliveryGoodsList goods, state, int index) {
  MoreDialog({
    "叠加": () => showCupertinoModalBottomSheet(
          context: Get.context!,
          expand: true,
          enableDrag: false,
          animationCurve: Curves.easeIn,
          builder: (context) => AddSku(
            controller: controller,
            title: GoodsUtils.getGoodsTitle(goods.storeGoods?.goodsSerial, goods.storeGoods?.goodsName),
            imgUrl: GoodsUtils.getGoodsCover(goods.storeGoods?.imgPath, goods.storeGoods?.cover),
            skus: controller.skuMap[goods.orderSaleGoodsId] as List,
            thirdTag: "num",
            callback: (skus, map) {
              //更新列表数据；
              state.updateAdd(skus, map, goods.orderSaleGoodsId, index);
              controller.update([DirectDeliverController.idGoodsList]);
            },
          ),
        ),
    "备注": () => showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (_) => CustomDialog(
            title: '备注',
            type: 0,
            value: goods.remark ?? "",
            confirmCallback: (value) {
              goods.remark = value;
              controller.update([DirectDeliverController.idGoodsNum(goods.orderSaleGoodsId)]);
            },
          ),
        ),
  }).show(Get.context!, key);
}

header() {
  return GetBuilder<DirectDeliverController>(
    builder: (ctl) => Visibility(
      child: Container(
        child: Row(
          children: [
            pSizeBoxW(24.w),
            pText("发货", ColorConfig.color_1678FF, 28.w, fontWeight: FontWeight.bold),
            pSizeBoxW(10.w),
            pText(
              "${ctl.goodsNumTotal}件${ctl.goodsStyleNum}款${PriceUtils.getPrice(ctl.priceTotal)}",
              ColorConfig.color_333333,
              28.w,
              fontWeight: FontWeight.bold,
            ),
            Expanded(child: Container()),
            GestureDetector(
              child: pText("全部收起", ColorConfig.color_999999, 28.w),
              onTap: () => eventBus.fire(AddGoodsEvent(-1)),
              behavior: HitTestBehavior.opaque,
            ),
            pImage("images/icon_down.png", 18.w, 12.w),
            pSizeBoxW(24.w),
          ],
        ),
        padding: EdgeInsets.only(bottom: 36.w),
      ),
      visible: ctl.goodsList.length > 1,
    ),
    id: DirectDeliverController.idHeader,
  );
}

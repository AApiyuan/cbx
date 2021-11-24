import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/mix_sku_edit_list_view.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget saleHeader() {
  return GetBuilder<SaleEnterController>(
    builder: (ctl) {
      return Visibility(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  pSizeBoxW(24.w),
                  pText("销售", ColorConfig.color_1678FF, 28.w,
                      fontWeight: FontWeight.bold),
                  pSizeBoxW(10.w),
                  pText("text", ColorConfig.color_333333, 28.w,
                      fontWeight: FontWeight.bold),
                ],
              ),
              pSizeBoxH(24.w),
              Row(
                children: [
                  InkWell(
                    child: Container(
                      height: 44.w,
                      width: 172.w,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 24.w),
                      child: pText("多款优惠", ColorConfig.color_1678FF, 24.w),
                      decoration: ShapeDecoration(
                          color: Color(ColorConfig.color_1A1678FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.w),
                          )),
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    child: pText("全部收起", ColorConfig.color_999999, 28.w),
                  ),
                  pSizeBoxW(24.w),
                ],
              ),
              pSizeBoxH(36.w),
              Container(color: Color(ColorConfig.color_efefef), height: 1.w)
            ],
          ),
          color: Colors.white,
        ),
        visible: ctl.hasSale,
      );
    },
    id: SaleEnterController.idSaleHeader,
  );
}

saleList() {
  return GetBuilder<SaleEnterController>(
    builder: (controller) {
      return Visibility(
        child: Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            color: Colors.white,
            child: MixSkuEditListView(
              data: controller.saleList,
              skuMap: controller.saleSkuMap,
              mainItem: saleListItem,
              controller: controller,
              negative: false,
              thirdTagName: "可卖",
              thirdTag: 'canSell',
              handleTagName: "数量",
              handleTag: 'num',
              callBack: (int key, int index, int itemAdd, int itemMinus) {
                // ctl.calculate(key, index, itemAdd);
              },
            ),
          ),
        ),
        visible: controller.hasSale,
      );
    },
    id: SaleEnterController.idSaleList,
  );
}

saleListItem(int index, state) {
  return GetBuilder<SaleEnterController>(
    builder: (ctl) {
      var goods = ctl.saleItem(index);
      return Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 24.w),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => state.operator(index, goods.id),
                    child: Row(
                      children: [
                        NetImageWidget(
                          GoodsUtils.getGoodsCover(goods.imgPath, goods.cover),
                          height: 160,
                          width: 160,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16.w),
                          height: 160.w,
                          width: 382.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 382.w,
                                alignment: Alignment.centerLeft,
                                child: pText(
                                    GoodsUtils.getGoodsTitle(
                                        goods.goodsSerial, goods.goodsName),
                                    ColorConfig.color_333333,
                                    32.w,
                                    fontWeight: FontWeight.bold),
                              ),
                              pText('正品库存', ColorConfig.color_999999, 28.w),
                              Row(
                                children: [
                                  pText("text", ColorConfig.color_1678FF, 32.w),
                                  pImage("images/icon_down.png", 32.w, 32.w),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  pSizeBoxH(16.w),
                  Visibility(
                    // visible: goods.remark != null && goods.remark != '',
                    child: Container(
                      decoration: new BoxDecoration(
                          color: Color(ColorConfig.color_f5f5f5),
                          borderRadius: new BorderRadius.circular((10.w))),
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      margin: EdgeInsets.only(bottom: 14.w),
                      alignment: Alignment.centerLeft,
                      height: 44.w,
                      width: double.infinity,
                      child: pText("备注: ${"item.remark"}",
                          ColorConfig.color_F3AE1F, 24.w),
                    ),
                  ),
                ],
              ),
            ),
            new Positioned(
              right: 0,
              top: 15.w,
              child: Container(
                height: 66.w,
                width: 125.w,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () => print("更多"),
                        child: pImage("images/more.png", 48.w, 32.w)),
                    pSizeBoxW(36.w),
                    InkWell(
                      onTap: () {
                        state.delete(index, goods.id);
                        // ctl.deleteGoods(item.goodsId, item.addNum);
                      },
                      child: pImage("images/icon_dialog_close.png", 40.w, 40.w),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';
import 'package:haidai_flutter_module/page/goods/model/sale_and_sale_goods_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/forbid.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget oweGoods(BuildContext buildContext, SaleDetailDoSaleGoodsList oweGoods,
    Function onTap) {
  var goods = Goods();
  goods.imgPath = oweGoods.storeGoods?.imgPath;
  goods.id = oweGoods.id;
  goods.cover = oweGoods.storeGoods?.cover;
  goods.goodsName = oweGoods.storeGoods?.goodsName;
  goods.goodsSerial = oweGoods.storeGoods?.goodsSerial;
  return baseGoods(
    buildContext,
    goods,
    onTap,
    leftBottom: pText(
        "欠货${oweGoods.shortageNum ?? 0}",
        (oweGoods.shortageNum ?? 0) == 0
            ? ColorConfig.color_CCCCCC
            : ColorConfig.color_FF7314,
        28.w),
    selectColor: ColorConfig.color_FF7314,
  );
}

Widget oweOrderHeader(SaleAndSaleGoodsDoEntity orderHeader) {
  return Container(
    padding: EdgeInsets.only(top: 24.w, left: 24.w, right: 24.w),
    child: Row(
      children: [
        pImage("images/order_icon.png", 22.w, 26.w),
        pText("销售单${orderHeader.orderSaleSerial}", ColorConfig.color_333333,
            28.w),
        Expanded(child: Container(height: 0)),
        pText("${orderHeader.customizeTime}", ColorConfig.color_999999, 24.w),
      ],
    ),
  );
}

Widget stockGoods(
    BuildContext buildContext, Goods goods, bool normal, Function onTap) {
  return baseGoods(
    buildContext,
    goods,
    onTap,
    leftBottom: pText(
        "${normal ? "正品库存" : "次品库存"}${normal ? (goods.stockNum ?? 0) : (goods.substandardNum ?? 0)}",
        ColorConfig.color_999999,
        28.w),
  );
}

Widget saleGoods(
    BuildContext buildContext, Goods goods, Function onTap, GoodsListController controller) {
  int price = goods.sailingPrice ?? 0;
  if (controller.goodsType == GoodsListController.TYPE_SALE && controller.saleLastPrice) {
    price = goods.lastBuyPrice ?? price;
  } else if (controller.goodsType == GoodsListController.TYPE_RETURN && controller.returnLastPrice) {
    price = goods.lastBuyPrice ?? price;
  } else if (controller.customerLevel == "C") {
    price = goods.packagePrice ?? price;
  } else if (controller.customerLevel == "B") {
    price = goods.takingPrice ?? price;
  }
  return baseGoods(
    buildContext,
    goods,
    onTap,
    leftBottom: pText(
        "¥${PriceUtils.priceString(price)}", ColorConfig.color_FF5D1E, 36.w),
    center: controller.online ? pText(
        "正品库存 ${goods.stockNum ?? 0}  |  销量 ${goods.saleNum ?? 0}  |  欠货 ${goods.oweNum ?? 0}",
        ColorConfig.color_999999,
        24.w) : null,
  );
}

Widget returnGoods(BuildContext buildContext, Goods goods, Function onTap) {
  return baseGoods(
    buildContext,
    goods,
    onTap,
    leftBottom: pText(
        "发过货${goods.customerDeliveryNum ?? 0}",
        (goods.customerDeliveryNum ?? 0) == 0
            ? ColorConfig.color_CCCCCC
            : ColorConfig.color_FF3715,
        28.w),
    selectColor: ColorConfig.color_FF3715,
  );
}

Widget baseGoods(
  BuildContext buildContext,
  Goods goods,
  Function onTap, {
  Widget? leftBottom,
  Widget? center,
  int selectColor = ColorConfig.color_1678ff,
}) {
  return Forbid(
    child: Container(
      height: 176.w,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            child: NetImageWidget(
              (goods.imgPath ?? "") + "/" + (goods.cover ?? ""),
              width: 140,
              height: 140,
              radius: 10,
            ),
            top: 18.w,
            left: 24.w,
          ),
          Positioned(
            child: pText(
              GoodsUtils.getGoodsTitle(goods.goodsSerial!, goods.goodsName),
              ColorConfig.color_333333,
              28.w,
              fontWeight: FontWeight.bold,
              alignment: Alignment.centerLeft,
              width: 530.w,
            ),
            top: 18.w,
            left: 180.w,
          ),
          Positioned(
            bottom: 18.w,
            left: 180.w,
            child: leftBottom ?? pSizeBoxW(0),
          ),
          Positioned(
            left: 180.w,
            top: 70.w,
            child: center ?? pSizeBoxW(0),
          ),
          GetBuilder<GoodsListController>(
            builder: (ctl) {
              var selectNum = ctl.getSelectNum(goods.id!);
              return Visibility(
                  child: Positioned(
                    right: 24.w,
                    bottom: 18.w,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 3.w, bottom: 3.w),
                      child: pText(
                          "已选$selectNum", ColorConfig.color_ffffff, 24.w,
                          fontWeight: FontWeight.bold),
                      decoration: ShapeDecoration(
                          color: Color(selectColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.w))),
                    ),
                  ),
                  visible: selectNum > 0);
            },
          ),
          Container(
            margin: EdgeInsets.only(left: 180.w, right: 24.w),
            alignment: Alignment.bottomCenter,
            child: Divider(
              height: 1.w,
              thickness: 1.w,
              color: Color(ColorConfig.color_efefef),
            ),
          ),
        ],
      ),
    ),
    onTap: () => onTap.call(),
  );
}

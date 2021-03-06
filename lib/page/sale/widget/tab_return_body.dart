import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleGoodsDiscountTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/widget/clear_dialog.dart';
import 'package:haidai_flutter_module/page/sale/widget/discount_widget.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/mix_sku_edit_list_view.dart';
import 'package:haidai_flutter_module/widget/more_dialog.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

// ignore: must_be_immutable
class TabReturnBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabReturnBodyState();
  }
}

class TabReturnBodyState extends State<TabReturnBody>
    with AutomaticKeepAliveClientMixin {
  late BuildContext _context;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    this._context = context;
    return Column(
      children: [
        // header(),
        // empty(),
        goodsList(),
      ],
    );
  }

  Widget header() {
    return GetBuilder<SaleEnterController>(
      builder: (ctl) {
        return Visibility(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    pSizeBoxW(24.w),
                    pText("?????????", ColorConfig.color_FF3715, 28.w,
                        fontWeight: FontWeight.bold),
                    pSizeBoxW(10.w),
                    GetBuilder<SaleEnterController>(
                        builder: (ctl) {
                          return pText(
                              "${ctl.returnCount}???/${ctl.returnSelectMap.length}???/${PriceUtils.getPrice(ctl.returnPrice)}",
                              ColorConfig.color_333333,
                              28.w,
                              fontWeight: FontWeight.bold);
                        },
                        id: SaleEnterController.idReturnHeaderStatistics),
                  ],
                ),
                pSizeBoxH(24.w),
                Row(
                  children: [
                    pSizeBoxW(24.w),
                    pText("????????????", ColorConfig.color_333333, 28.w),
                    substandardBtn("??????", SaleEnterController.idNormalGoods),
                    substandardBtn(
                        "??????", SaleEnterController.idSubstandardGoods),
                    Expanded(child: Container()),
                    InkWell(
                      child: pText("????????????", ColorConfig.color_999999, 28.w),
                      onTap: () => eventBus.fire(AddGoodsEvent(-1)),
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
          visible: ctl.hasReturn,
        );
      },
      id: SaleEnterController.idReturnHeader,
    );
  }

  substandardBtn(String text, String id) {
    return GetBuilder<SaleEnterController>(
      builder: (ctl) {
        var color;
        if ((id == SaleEnterController.idNormalGoods && !ctl.isSubstandard) ||
            (id == SaleEnterController.idSubstandardGoods &&
                ctl.isSubstandard)) {
          color = ColorConfig.color_333333;
        } else {
          color = ColorConfig.color_999999;
        }
        return Row(
          children: [
            pSizeBoxW(20.w),
            pRadio(
              value: id == SaleEnterController.idSubstandardGoods,
              groupValue: ctl.isSubstandard,
              onChange: (value) => ctl.setSubstandard(value),
            ),
            pText(text, color, 28.w),
          ],
        );
      },
      id: id,
    );
  }

  empty() {
    return GetBuilder<SaleEnterController>(
      builder: (ctl) => Visibility(
        child: emptyWidget(),
        visible: !ctl.hasReturn,
      ),
      id: SaleEnterController.idReturnEmpty,
    );
  }

  goodsList() {
    return GetBuilder<SaleEnterController>(
      builder: (controller) {
        return Expanded(
          child: Container(
            color: Colors.white,
            child: MixSkuEditListView(
              tag: SaleEnterController.idReturnList,
              data: controller.returnList,
              skuMap: controller.returnSkuMap,
              mainItem: goodsItem,
              mainItemType: 'SaleDetailDoSaleGoodsList',
              controller: controller,
              negative: false,
              handleTagColor: ColorConfig.color_FF3715,
              topItem: [header(), empty()],
              thirdTagName: "?????????",
              thirdTag: 'customerDeliveryNum',
              handleTagName: "??????",
              handleTag: 'num',
              onKeyBordChange: (change) => controller.onKeyBordChange(change),
              callBack: (int key, int index, int itemAdd, int itemMinus) {
                controller.updateReturnGoodsCount(key, itemAdd);
              },
            ),
          ),
        );
      },
      id: SaleEnterController.idReturnList,
    );
  }

  goodsItem(int index, state) {
    var moreKey = GlobalKey();
    return GetBuilder<SaleEnterController>(
      builder: (ctl) {
        SaleDetailDoSaleGoodsList saleGoods = ctl.returnItem(index);
        // saleGoods.dis
        var goods = saleGoods.storeGoods!;
        return GetBuilder<SaleEnterController>(
          builder: (ctl) {
            var priceText;
            var discountEnum = EnumCoverUtils.stringToEnums(
                saleGoods.discountType, SaleGoodsDiscountTypeEnum.values);
            if (discountEnum == SaleGoodsDiscountTypeEnum.CHANGE_PRICE) {
              priceText = "???${PriceUtils.getPrice(saleGoods.price)}";
            } else {
              priceText = PriceUtils.getPrice(ctl.getGoodsPrice(saleGoods));
            }
            priceText =
                "$priceText  |  ??????${PriceUtils.getPrice(ctl.getReturnGoodsReq(goods.id!)?.receivableAmount)}";
            return Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
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
                                GoodsUtils.getGoodsCover(
                                    goods.imgPath, goods.cover),
                                height: 160,
                                width: 160,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 16.w),
                                height: 160.w,
                                // width: 382.w,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 382.w,
                                      alignment: Alignment.centerLeft,
                                      child: pText(
                                          GoodsUtils.getGoodsTitle(
                                              goods.goodsSerial,
                                              goods.goodsName),
                                          ColorConfig.color_333333,
                                          38.w,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      child: pText(
                                        "$priceText",
                                        ColorConfig.color_999999,
                                        28.w,
                                        textAlign: TextAlign.start,
                                      ),
                                      width: 510.w,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        InkWell(
                                          child: pText("??????",
                                              ColorConfig.color_999999, 28.w),
                                          onTap: () => showChangePriceDialog(
                                            _context,
                                            saleGoods,
                                            ctl.deptId,
                                            ctl.customerId,
                                            (price) => changePrice(
                                                price, saleGoods, ctl),
                                          ),
                                        ),
                                        pSizeBoxW(36.w),
                                        Visibility(
                                          child: InkWell(
                                            child: Container(
                                              alignment: Alignment.bottomCenter,
                                              height: 50.w,
                                              // color: Colors.blue,
                                              child: Row(
                                                children: [
                                                  pText(
                                                      "??????${PriceUtils.getPrice(goods.goods?.lastBuyPrice)}",
                                                      ColorConfig.color_999999,
                                                      28.w),
                                                  pSizeBoxW(10.w),
                                                  pImage(
                                                      "images/icon_connecter_copy.png",
                                                      25.w,
                                                      28.w),
                                                  pSizeBoxW(10.w),
                                                ],
                                              ),
                                            ),
                                            onTap: () => changePrice(
                                                goods.goods?.lastBuyPrice ?? 0,
                                                saleGoods,
                                                ctl),
                                          ),
                                          visible: goods.goods != null &&
                                              goods.goods?.lastBuyPrice != null,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        pSizeBoxH(16.w),
                        Visibility(
                          visible: (saleGoods.remark?.length ?? 0) > 0,
                          child: Container(
                            decoration: new BoxDecoration(
                                color: Color(ColorConfig.color_f5f5f5),
                                borderRadius:
                                    new BorderRadius.circular((10.w))),
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            margin: EdgeInsets.only(bottom: 14.w),
                            alignment: Alignment.centerLeft,
                            height: 44.w,
                            width: double.infinity,
                            child: pText("??????: ${saleGoods.remark}",
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
                              onTap: () =>
                                  showMoreDialog(ctl, saleGoods, moreKey),
                              child: pImage("images/more.png", 48.w, 32.w,
                                  key: moreKey)),
                          pSizeBoxW(36.w),
                          InkWell(
                            onTap: () => showDeleteDialog(() {
                              state.delete(index, goods.id);
                              ctl.deleteReturnGoods(goods.id!);
                            }),
                            child: pImage(
                                "images/icon_dialog_close.png", 40.w, 40.w),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 140.w,
                    child: GestureDetector(
                      child: Row(
                        children: [
                          pText("???${ctl.returnSelectMap[goods.id] ?? 0}",
                              ColorConfig.color_FF3715, 34.w,
                              fontWeight: FontWeight.bold),
                          pImage("images/icon_down.png", 32.w, 32.w),
                        ],
                      ),
                      onTap: () => state.operator(index, goods.id),
                    ),
                  ),
                ],
              ),
            );
          },
          id: SaleEnterController.idReturnGoods(goods.id!),
        );
      },
    );
  }

  showMoreDialog(SaleEnterController controller,
      SaleDetailDoSaleGoodsList saleGoods, GlobalKey key) {
    MoreDialog({
      "????????????": () => controller.addSaleGoods(saleGoods),
      "??????": () {
        showDialog(
          context: _context,
          barrierDismissible: false,
          builder: (_) => CustomDialog(
            title: '??????',
            type: 0,
            value: saleGoods.remark ?? "",
            confirmCallback: (value) {
              saleGoods.remark = value;
              controller.update(
                  [SaleEnterController.idReturnGoods(saleGoods.goodsId!)]);
            },
          ),
        );
      },
    }).show(_context, key);
  }

  changePrice(
      int price, SaleDetailDoSaleGoodsList saleGoods, SaleEnterController ctl) {
    saleGoods.discountType =
        EnumCoverUtils.enumsToString(SaleGoodsDiscountTypeEnum.CHANGE_PRICE);
    saleGoods.price = price;
    ctl.updateReturnGoodsCount(
        saleGoods.goodsId!, ctl.returnSelectMap[saleGoods.goodsId!] ?? 0);
  }
}

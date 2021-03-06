import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleGoodsDiscountTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/model/store/res/store_discount_template_do.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/discount_template_detail_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/widget/clear_dialog.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/common_dialog.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/mix_sku_edit_list_view.dart';
import 'package:haidai_flutter_module/widget/more_dialog.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import 'clearance_widget.dart';
import 'discount_widget.dart';
import 'more_discount_widget.dart';

// ignore: must_be_immutable
class TabSaleBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabSaleBodyState();
  }
}

class TabSaleBodyState extends State<TabSaleBody>
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
        // saleHeader(),
        // empty(),
        saleList(),
      ],
    );
  }

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
                    pText("??????", ColorConfig.color_1678FF, 28.w,
                        fontWeight: FontWeight.bold),
                    pSizeBoxW(10.w),
                    GetBuilder<SaleEnterController>(
                        builder: (ctl) {
                          return pText(
                              "${ctl.saleCount}???/${ctl.saleSelectMap.length}???/${PriceUtils.getPrice(ctl.salePrice)}",
                              ColorConfig.color_333333,
                              28.w,
                              fontWeight: FontWeight.bold);
                        },
                        id: SaleEnterController.idSaleHeaderStatistics),
                  ],
                ),
                pSizeBoxH(24.w),
                Row(
                  children: [
                    Visibility(
                      child: InkWell(
                        child: Container(
                          height: 44.w,
                          width: 172.w,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              pText("??????${PriceUtils.priceString(ctl.tax)}",
                                  ColorConfig.color_333333, 24.w),
                              pSizeBoxW(12.w),
                              pImage("images/icon_edit_blue.png", 31.w, 31.w),
                            ],
                          ),
                          decoration: ShapeDecoration(
                            color: Color(ColorConfig.color_1A1678FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.w),
                            ),
                          ),
                        ),
                        onTap: () => showTax(ctl),
                      ),
                      // visible: ctl.type == SaleEnterController.TYPE_QUOTATION,
                    ),
                    InkWell(
                      child: Container(
                        height: 44.w,
                        width: 172.w,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 24.w),
                        child: pText("????????????", ColorConfig.color_1678FF, 24.w),
                        decoration: ShapeDecoration(
                          color: Color(ColorConfig.color_1A1678FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.w),
                          ),
                        ),
                      ),
                      onTap: () => showMoreDiscount(ctl),
                    ),
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
          visible: ctl.hasSale,
        );
      },
      id: SaleEnterController.idSaleHeader,
    );
  }

  empty() {
    return GetBuilder<SaleEnterController>(
      builder: (ctl) => Visibility(
        child: emptyWidget(),
        visible: !ctl.hasSale,
      ),
      id: SaleEnterController.idSaleEmpty,
    );
  }

  saleList() {
    return GetBuilder<SaleEnterController>(
      builder: (controller) {
        return Expanded(
          child: Container(
            color: Colors.white,
            child: MixSkuEditListView(
              tag: SaleEnterController.idSaleList,
              data: controller.saleList,
              skuMap: controller.saleSkuMap,
              mainItem: saleListItem,
              mainItemType: 'SaleDetailDoSaleGoodsList',
              controller: controller,
              negative: false,
              topItem: [saleHeader(), empty()],
              thirdTagName:
                  controller.type == SaleEnterController.TYPE_OFFLINE_SALE
                      ? ""
                      : "??????",
              thirdTag: controller.type == SaleEnterController.TYPE_OFFLINE_SALE
                  ? ""
                  : 'canSell',
              handleTagName: "??????",
              onKeyBordChange: (change) => controller.onKeyBordChange(change),
              handleTag: 'num',
              callBack: (int key, int index, int itemAdd, int itemMinus) {
                controller.updateSaleGoodsCount({key: itemAdd});
              },
            ),
          ),
        );
      },
      id: SaleEnterController.idSaleList,
    );
  }

  saleListItem(int index, state) {
    var moreKey = GlobalKey();
    return GetBuilder<SaleEnterController>(
      builder: (ctl) {
        SaleDetailDoSaleGoodsList saleGoods = ctl.saleItem(index);
        var goods = saleGoods.storeGoods!;
        return GetBuilder<SaleEnterController>(
          builder: (ctl) {
            var priceText;
            var discountEnum = EnumCoverUtils.stringToEnums(
                saleGoods.discountType, SaleGoodsDiscountTypeEnum.values);
            if (discountEnum == SaleGoodsDiscountTypeEnum.CHANGE_PRICE) {
              priceText = "???${PriceUtils.getPrice(saleGoods.price)}";
            } else if (discountEnum == SaleGoodsDiscountTypeEnum.REBATE) {
              priceText =
                  "???${PriceUtils.priceString(saleGoods.discount)} x ${PriceUtils.getPrice(saleGoods.salePrice)}";
            } else if (discountEnum == SaleGoodsDiscountTypeEnum.TEMPLATE) {
              priceText =
                  "??????${PriceUtils.getPrice(saleGoods.discountTemplateDetail?.totalPrice)}/${saleGoods.discountTemplateDetail?.enableNum ?? 0}???";
            } else {
              priceText =
                  "${PriceUtils.getPrice(ctl.getGoodsPrice(saleGoods))}";
            }
            var receivableAmount = ctl.getTaxReceivableAmount(goods.id!);
            priceText =
                "$priceText  |  ??????${PriceUtils.getPrice(receivableAmount)}";
            return Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              child: GestureDetector(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 24.w),
                      child: Column(
                        children: [
                          Row(
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
                                      // mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                              // color: Colors.blue,
                                            ),
                                            onTap: () => changePrice(
                                                goods.goods?.lastBuyPrice ?? 0,
                                                saleGoods,
                                                ctl),
                                          ),
                                          visible: ctl.type !=
                                                  SaleEnterController
                                                      .TYPE_OFFLINE_SALE &&
                                              goods.goods != null &&
                                              goods.goods?.lastBuyPrice != null,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          pSizeBoxH(16.w),
                          Visibility(
                            visible: (saleGoods.remark?.length ?? 0) > 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(ColorConfig.color_f5f5f5),
                                  borderRadius: BorderRadius.circular((10.w))),
                              padding: EdgeInsets.only(left: 10.w, right: 10.w),
                              margin: EdgeInsets.only(bottom: 14.w),
                              alignment: Alignment.centerLeft,
                              height: 44.w,
                              width: double.infinity,
                              child: pText(
                                "??????: ${saleGoods.remark}",
                                ColorConfig.color_F3AE1F,
                                24.w,
                                alignment: Alignment.centerLeft,
                              ),
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
                                ctl.deleteSaleGoods(goods.id!);
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
                      child: Row(
                        children: [
                          pText("???${ctl.saleSelectMap[goods.id] ?? 0}",
                              ColorConfig.color_1678FF, 34.w,
                              fontWeight: FontWeight.bold),
                          pImage("images/icon_down.png", 32.w, 32.w),
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () => state.operator(index, goods.id),
              ),
            );
          },
          id: SaleEnterController.idSaleGoods(goods.id!),
        );
      },
    );
  }

  showMoreDialog(SaleEnterController controller,
      SaleDetailDoSaleGoodsList saleGoods, GlobalKey key) {
    var map = {
      "????????????": () => controller.addReturnGoods(saleGoods),
      "????????????": () => MethodChannel(ChannelConfig.flutterToNative).invokeMethod(
            ChannelConfig.methodOtherStockDialog,
            {
              Constant.DEPT_ID: controller.deptId,
              Constant.GOODS_ID: saleGoods.goodsId,
            },
          ),
      "????????????": () => controller
          .getDiscountTemplate()
          .then((value) => showClearanceDialog(value, saleGoods, controller)),
      "??????": () => showDialog(
            context: _context,
            barrierDismissible: false,
            builder: (_) => CustomDialog(
              title: '??????',
              type: 0,
              value: saleGoods.remark ?? "",
              confirmCallback: (value) {
                saleGoods.remark = value;
                controller.update(
                    [SaleEnterController.idSaleGoods(saleGoods.goodsId!)]);
              },
            ),
          ),
    };
    if (controller.type == SaleEnterController.TYPE_OFFLINE_SALE) {
      map.remove("????????????");
    }
    MoreDialog(map).show(_context, key);
  }

  // getDiscountTemplate(
  //     SaleEnterController controller, SaleDetailDoSaleGoodsList saleGoods) {
  //   var param = StoreDiscountTemplateReq();
  //   param.status = Status.ENABLE;
  //   param.style = StoreDiscountTemplateEnum.CLEARANCE;
  //   param.customerDeptId = controller.deptId;
  //   StoreDiscountTemplateApi.getDiscountTemplate(param)
  //       .then((value) => showClearanceDialog(value, saleGoods, controller));
  // }

  showClearanceDialog(List<StoreDiscountTemplateDo> data,
      SaleDetailDoSaleGoodsList saleGoods, SaleEnterController ctl) {
    CommonDialog(
      "????????????",
      ClearanceWidget(
          data, (templateDetail) => template(templateDetail, saleGoods, ctl)),
    ).showBottom(_context);
  }

  template(StoreDiscountTemplateDo templateDetail,
      SaleDetailDoSaleGoodsList saleGoods, SaleEnterController ctl) {
    saleGoods.discountType =
        EnumCoverUtils.enumsToString(SaleGoodsDiscountTypeEnum.TEMPLATE);
    saleGoods.discountTemplateDetail =
        DiscountTemplateDetailEntity().fromJson(templateDetail.toJson());
    saleGoods.discountTemplateId = templateDetail.id;
    ctl.updateSaleGoodsCount(
        {saleGoods.goodsId!: ctl.saleSelectMap[saleGoods.goodsId!] ?? 0});
  }

  changePrice(
      int price, SaleDetailDoSaleGoodsList saleGoods, SaleEnterController ctl) {
    saleGoods.discountType =
        EnumCoverUtils.enumsToString(SaleGoodsDiscountTypeEnum.CHANGE_PRICE);
    saleGoods.price = price;
    ctl.updateSaleGoodsCount(
        {saleGoods.goodsId!: ctl.saleSelectMap[saleGoods.goodsId!] ?? 0});
  }

  showMoreDiscount(SaleEnterController controller) {
    var content = MoreDiscountWidget(controller.getSaleGoodsList());
    CommonDialog(
      "??????",
      content,
      leftWidget: InkWell(
        child: Container(
          child: pText("??????", ColorConfig.color_ff3715, 28.w),
          alignment: Alignment.center,
          height: 70.w,
        ),
        onTap: () => showClearDialog(() => content.clearDiscount(controller)),
      ),
    ).showBottom(_context);
  }

  showClearDialog(Function function) {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_) => CustomDialog(
        type: 1,
        height: 220,
        outsideDismiss: false,
        content: pText(
          "??????????????????????????????",
          ColorConfig.color_333333,
          32.w,
          fontWeight: FontWeight.bold,
        ),
        confirmTextColor: ColorConfig.color_FF3715,
        confirmContent: "??????",
        confirmCallback: (value) => function.call(),
      ),
    );
  }

  showTax(SaleEnterController ctl) {
    showTaxDialog(
      _context,
      ctl.tax,
      (tax) {
        ctl.taxSetting = true;
        ctl.setTax(tax);
        ctl.calculate(updateList: [
          SaleEnterController.idAmountStatistics,
          SaleEnterController.idSaleHeader
        ]);
      },
    );
  }
}

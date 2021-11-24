import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/pull_or_off.dart';
import 'package:haidai_flutter_module/model/enum/select_type.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/goods_page_param.dart';
import 'package:haidai_flutter_module/model/rep/store_goods_sku_req_entity.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/goods/model/goods_sku_entity.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/widget/clear_dialog.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/mix_sku_edit_list_view.dart';
import 'package:haidai_flutter_module/widget/more_dialog.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class TabOweBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabOweBodyState();
  }
}

class TabOweBodyState extends State<TabOweBody>
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
            padding: EdgeInsets.only(bottom: 36.w),
            child: Row(
              children: [
                pSizeBoxW(24.w),
                pText("退欠货", ColorConfig.color_FF7314, 28.w,
                    fontWeight: FontWeight.bold),
                pSizeBoxW(10.w),
                GetBuilder<SaleEnterController>(
                    builder: (ctl) {
                      return pText(
                          "${ctl.oweCount}件/${ctl.oweSelectMap.length}款/${PriceUtils.getPrice(ctl.owePrice)}",
                          ColorConfig.color_333333,
                          28.w,
                          fontWeight: FontWeight.bold);
                    },
                    id: SaleEnterController.idOweHeaderStatistics),
                Expanded(child: Container()),
                InkWell(
                  child: pText("全部收起", ColorConfig.color_999999, 28.w),
                  onTap: () => eventBus.fire(AddGoodsEvent(-1)),
                ),
                pSizeBoxW(24.w),
              ],
            ),
            color: Colors.white,
          ),
          visible: ctl.hasOwe,
        );
      },
      id: SaleEnterController.idOweHeader,
    );
  }

  empty() {
    return GetBuilder<SaleEnterController>(
      builder: (ctl) => Visibility(
        child: emptyWidget(),
        visible: !ctl.hasOwe,
      ),
      id: SaleEnterController.idOweEmpty,
    );
  }

  goodsList() {
    return GetBuilder<SaleEnterController>(
      builder: (controller) {
        return Expanded(
          child: Container(
            color: Colors.white,
            child: MixSkuEditListView(
              tag: SaleEnterController.idOweList,
              data: controller.oweList,
              skuMap: controller.oweSkuMap,
              uniKey: "id",
              mainItem: goodsItem,
              mainItemType: 'SaleDetailDoSaleGoodsList',
              controller: controller,
              handleTagColor: ColorConfig.color_FF7314,
              negative: false,
              topItem: [header(), empty()],
              thirdTagName: "欠货",
              thirdTag: 'shortageNum',
              handleTagName: "数量",
              handleTag: 'num',
              onKeyBordChange: (change) => controller.onKeyBordChange(change),
              handleOverThird: false,
              callBack: (int key, int index, int itemAdd, int itemMinus) {
                controller.updateOweGoodsCount(key, itemAdd);
              },
            ),
          ),
        );
      },
      id: SaleEnterController.idOweList,
    );
  }

  Widget oweOrderHeader(SaleDetailDoSaleGoodsList oweGoods) {
    return Container(
      padding: EdgeInsets.only(top: 24.w, right: 24.w, bottom: 24.w),
      child: Row(
        children: [
          pImage("images/order_icon.png", 22.w, 26.w),
          pText("销售单${oweGoods.relationOrderSaleSerial}",
              ColorConfig.color_333333, 28.w),
          Expanded(child: Container(height: 0)),
          pText("${oweGoods.relationOrderSaleCustomizeTime}",
              ColorConfig.color_999999, 24.w),
        ],
      ),
    );
  }

  goodsItem(int index, state) {
    var moreKey = GlobalKey();
    return GetBuilder<SaleEnterController>(
      builder: (ctl) {
        SaleDetailDoSaleGoodsList oweGoods = ctl.oweItem(index);
        var goods = oweGoods.storeGoods!;
        return GetBuilder<SaleEnterController>(
          builder: (ctl) {
            var price = oweGoods.taxPrice ?? 0;
            var priceText = "${PriceUtils.getPrice(price)}";
            priceText =
                "$priceText  |  总额${PriceUtils.getPrice(ctl.getOweGoodsReq(oweGoods.id!)?.receivableAmount)}";
            return Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      children: [
                        oweOrderHeader(oweGoods),
                        InkWell(
                          onTap: () => state.operator(index, oweGoods.id),
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
                                    Container(
                                      child: pText(
                                          " ", ColorConfig.color_333333, 28.w),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        pSizeBoxH(16.w),
                        Visibility(
                          visible: (oweGoods.remark?.length ?? 0) > 0,
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
                            child: pText("备注: ${oweGoods.remark}",
                                ColorConfig.color_F3AE1F, 24.w),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Positioned(
                    right: 0,
                    top: 75.w,
                    child: Container(
                      height: 66.w,
                      width: 125.w,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () =>
                                  showMoreDialog(ctl, oweGoods, moreKey),
                              child: pImage("images/more.png", 48.w, 32.w,
                                  key: moreKey)),
                          pSizeBoxW(36.w),
                          InkWell(
                            onTap: () => showDeleteDialog(() {
                              state.delete(index, oweGoods.id);
                              ctl.deleteOweGoods(oweGoods.id!);
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
                    top: 216.w,
                    child: GestureDetector(
                      child: Row(
                        children: [
                          pText("退${ctl.oweSelectMap[oweGoods.id] ?? 0}",
                              ColorConfig.color_FF7314, 34.w,
                              fontWeight: FontWeight.bold),
                          pImage("images/icon_down.png", 32.w, 32.w),
                        ],
                      ),
                      onTap: () => state.operator(index, oweGoods.id),
                    ),
                  ),
                ],
              ),
            );
          },
          id: SaleEnterController.idOweGoods(oweGoods.id!),
        );
      },
    );
  }

  showMoreDialog(SaleEnterController controller,
      SaleDetailDoSaleGoodsList saleGoods, GlobalKey key) {
    MoreDialog({
      "快捷退货": () => controller.addReturnGoods(saleGoods),
      "快捷购买": () => controller.addSaleGoods(saleGoods),
      "备注": () => showDialog(
            context: _context,
            barrierDismissible: false,
            builder: (_) => CustomDialog(
              title: '备注',
              type: 0,
              value: saleGoods.remark ?? "",
              confirmCallback: (value) {
                saleGoods.remark = value;
                controller
                    .update([SaleEnterController.idOweGoods(saleGoods.id!)]);
              },
            ),
          ),
    }).show(_context, key);
  }
}

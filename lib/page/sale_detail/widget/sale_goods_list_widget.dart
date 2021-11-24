import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleGoodsDiscountTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/goods/widget/goods_widget.dart';
import 'package:haidai_flutter_module/page/sale_detail/controller/sale_detail_controller.dart';
import 'package:haidai_flutter_module/page/stock/detail/controller/stock_detail_controller.dart';
import 'package:haidai_flutter_module/page/stock/detail/widget/orderTitle.dart';
import 'package:haidai_flutter_module/page/stock/detail/widget/order_remark.dart';
import 'package:haidai_flutter_module/page/stock/detail/widget/static_title.dart';
import 'package:haidai_flutter_module/page/stock/model/req/order_stock_update_dto.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';
import 'package:haidai_flutter_module/repository/order/stock_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/mix_sku_list_view.dart';
import 'package:haidai_flutter_module/widget/mix_sku_silver_view.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class SaleGoodsListWidget extends StatefulWidget {
  var _context;

  SaleGoodsListWidget();

  @override
  State<StatefulWidget> createState() {
    return _SaleGoodsListWidgetState();
  }
}

class _SaleGoodsListWidgetState extends State<SaleGoodsListWidget> {
  @override
  Widget build(BuildContext context) {
    widget._context = context;
    return goodsListWidget();
  }

  Widget goodsListWidget() {
    return GetBuilder<SaleDetailController>(
        id: "saleList",
        builder: (ctl) {
          return MixSkuSilverView(
            tag: "saleList",
            data: ctl.saleList,
            skuMap: ctl.saleSkuMap,
            mainItem: goodsItem,
            mainItemType: "SaleDetailDoSaleGoodsList",
            controller: ctl,
            thirdTagName: "数量",
            thirdTag: "goodsNum",
            thirdTagColor: ColorConfig.color_1678ff,
            fourTagName: "欠货",
            fourTag: "shortageNum",
            fourTagColor: ColorConfig.color_ff3715,
            fiveTagName: "退欠",
            fiveTag: "canceledNum",
            fiveTagColor: ColorConfig.color_ff7f00,
          );
        });
  }

  Widget goodsItem(int index, state) {
    return GetBuilder<SaleDetailController>(
        id: "goods" + index.toString(),
        builder: (ctl) {
          var item = ctl.saleList[index];

          String goodsName = (item.storeGoods.goodsSerial ?? "") +
              (item.storeGoods.goodsName == null || item.storeGoods.goodsName?.length == 0 ? "" : "-") +
              (item.storeGoods.goodsName ?? "");
          var priceText;
          var discountEnum = EnumCoverUtils.stringToEnums(item.discountType, SaleGoodsDiscountTypeEnum.values);
          if (discountEnum == SaleGoodsDiscountTypeEnum.CHANGE_PRICE) {
            priceText = "改${PriceUtils.getPrice(item.price)}";
          } else if (discountEnum == SaleGoodsDiscountTypeEnum.REBATE) {
            priceText = "折${PriceUtils.priceString(item.discount)} x ${PriceUtils.getPrice(item.salePrice)}";
          } else if (discountEnum == SaleGoodsDiscountTypeEnum.TEMPLATE) {
            priceText = "清仓${PriceUtils.getPrice(item.discountTemplateDetail?.totalPrice)}/${item.discountTemplateDetail?.enableNum ?? 0}件";
          } else {
            priceText = "${PriceUtils.getPrice(item.salePrice)}";
          }
          priceText = "$priceText  |  总额${PriceUtils.getPrice(item.receivableAmount)}";

          return Container(
            child: Container(
                margin: EdgeInsets.only(top: index == 0 ? 30.w : 10.w, bottom: 12.w),
                padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        state.operator(index, item.goodsId);
                      },
                      child: Row(
                        children: [
                          NetImageWidget(
                            (item.storeGoods.imgPath ?? "") + "/" + (item.storeGoods.cover ?? ""),
                            height: 140,
                            width: 140,
                          ),
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 16.w),
                                height: 140.w,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 382.w,
                                          alignment: Alignment.centerLeft,
                                          child: pText(goodsName, ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    pText(priceText, ColorConfig.color_999999, 28.w),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            updateRemark(widget._context, item, ctl, index);
                                          },
                                          child: pText("备注", ColorConfig.color_999999, 28.w),
                                        ),
                                        Row(
                                          children: [
                                            Visibility(
                                              visible: item.shortageNum != 0,
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            color: Color(ColorConfig.color_ff6146),
                                                            borderRadius: BorderRadiusDirectional.only(
                                                              bottomStart: Radius.circular(4.w),
                                                              topStart: Radius.circular(4.w),
                                                            )),
                                                        alignment: Alignment.center,
                                                        width: 28.w,
                                                        height: 28.w,
                                                        child: pText("欠", ColorConfig.color_ffffff, 20.w)),
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            color: Color(ColorConfig.color_ffebe7),
                                                            borderRadius: BorderRadiusDirectional.only(
                                                              bottomEnd: Radius.circular(4.w),
                                                              topEnd: Radius.circular(4.w),
                                                            )),
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.only(left: 12.w, right: 12.w),
                                                        height: 28.w,
                                                        child: pText(item.shortageNum.toString(), ColorConfig.color_ff3715, 20.w,
                                                            fontWeight: FontWeight.w500))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            pSizeBoxW(5.w),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                pText("售", ColorConfig.color_1678ff, 32.w),
                                                pText(item.goodsNum.toString(), ColorConfig.color_1678ff, 34.w, fontWeight: FontWeight.w600),
                                              ],
                                            ),
                                            GetBuilder<SaleDetailController>(
                                                id: "open" + item.goodsId.toString(),
                                                builder: (ctl) {
                                                  return Row(
                                                    children: [
                                                      pImage("images/icon_down.png", 32.w, 32.w)

                                                      // pText(
                                                      //     (ctl.openStatus[item.goodsId] == null || ctl.openStatus[item.goodsId] == false)
                                                      //         ? "展开"
                                                      //         : "收起",
                                                      //     ColorConfig.color_999999,
                                                      //     28.w),
                                                      // pImage(
                                                      //     (ctl.openStatus[item.goodsId] == null || ctl.openStatus[item.goodsId] == false)
                                                      //         ? "images/icon_down.png"
                                                      //         : "images/icon_up.png",
                                                      //     32.w,
                                                      //     32.w)
                                                    ],
                                                  );
                                                })
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                    GetBuilder<SaleDetailController>(
                        id: "saleGoodsRemark" + item.goodsId.toString(),
                        builder: (ctl) {
                          return Visibility(
                              visible: item.remark != null && item.remark != "",
                              child: InkWell(
                                onTap: () {
                                  updateRemark(widget._context, item, ctl, index);
                                },
                                child: Container(
                                  decoration:
                                      new BoxDecoration(color: Color(ColorConfig.color_f5f5f5), borderRadius: new BorderRadius.circular((10.w))),
                                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                  margin: EdgeInsets.only(top: 16.w),
                                  alignment: Alignment.centerLeft,
                                  height: 44.w,
                                  width: double.infinity,
                                  child: pText("备注: " + item.remark.toString(), ColorConfig.color_F3AE1F, 24.w),
                                ),
                              ));
                        })
                  ],
                )),
          );
        });
  }
}

updateRemark(_context, item, ctl, index) {
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_) {
        return CustomDialog(
          title: '备注',
          type: 0,
          value: item.remark ?? "",
          confirmCallback: (value) {
            SaleApi.updateGoodsRemark(item.id, value).then((v) {
              ctl.saleList[index].remark = value;
              ctl.update(["saleGoodsRemark" + item.goodsId.toString()]);
            });
          },
        );
      });
}

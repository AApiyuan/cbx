import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
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

class ReturnOwesListWidget extends StatefulWidget {
  var _context;

  ReturnOwesListWidget();

  @override
  State<StatefulWidget> createState() {
    return _ReturnOweListWidgetState();
  }
}

class _ReturnOweListWidgetState extends State<ReturnOwesListWidget> {
  @override
  Widget build(BuildContext context) {
    widget._context = context;
    return goodsListWidget();
  }

  Widget goodsListWidget() {
    return GetBuilder<SaleDetailController>(
        id: "returnOweList",
        builder: (ctl) {
          return MixSkuSilverView(
            tag: "returnOweList",
            data: ctl.oweList,
            skuMap: ctl.oweSkuMap,
            uniKey: "id",
            mainItem: goodsItem,
            mainItemType: "SaleDetailDoSaleGoodsList",
            controller: ctl,
            thirdTagName: "数量",
            thirdTag: "goodsNum",
            thirdTagColor: ColorConfig.color_ff7f00,
          );
        });
  }

  Widget goodsItem(int index, state) {
    return GetBuilder<SaleDetailController>(
        id: "goods" + index.toString(),
        builder: (ctl) {
          var item = ctl.oweList[index];

          String goodsName = (item.storeGoods.goodsSerial ?? "") +
              (item.storeGoods.goodsName == null || item.storeGoods.goodsName?.length == 0 ? "" : "-") +
              (item.storeGoods.goodsName ?? "");

          var price = item.price ?? 0;
          var priceText = "${PriceUtils.getPrice(price)}";
          priceText = "$priceText  |  总额${PriceUtils.getPrice(item.receivableAmount)}";
          return Container(
            child: Container(
              child: Container(
                  margin: EdgeInsets.only(top: index == 0 ? 30.w : 10.w, bottom: 12.w),
                  padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          state.operator(index, item.id);
                        },
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                NetImageWidget(
                                  (item.storeGoods.imgPath ?? "") + "/" + (item.storeGoods.cover ?? ""),
                                  height: 140,
                                  width: 140,
                                ),
                                Positioned(
                                    bottom: 0.w,
                                    left: 0.w,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
                                      width: 140.w,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 0, 0, 0.6),
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.w), bottomLeft: Radius.circular(10.w))),
                                      child: Column(
                                        children: [
                                          pText("销售单", ColorConfig.color_ffffff, 20.w),
                                          pText("${item.relationOrderSaleSerial}", ColorConfig.color_ffffff, 20.w)
                                        ],
                                      ),
                                    ))
                              ],
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
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    pText("退", ColorConfig.color_ff7f00, 32.w),
                                                    pText(item.goodsNum.abs().toString(), ColorConfig.color_ff7f00, 34.w,
                                                        fontWeight: FontWeight.w600),
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
                                    )))
                          ],
                        ),
                      ),
                      GetBuilder<SaleDetailController>(
                          id: "returnOweRemark" + item.id.toString(),
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
            ),
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
              ctl.oweList[index].remark = value;
              ctl.update(["returnOweRemark" + item.id.toString()]);
            });
          },
        );
      });
}

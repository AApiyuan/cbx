import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleGoodsDiscountTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/delivery_detail/controller/delivery_detail_controller.dart';
import 'package:haidai_flutter_module/page/goods/widget/goods_widget.dart';
import 'package:haidai_flutter_module/page/sale_detail/controller/sale_detail_controller.dart';
import 'package:haidai_flutter_module/page/stock/detail/controller/stock_detail_controller.dart';
import 'package:haidai_flutter_module/page/stock/detail/widget/orderTitle.dart';
import 'package:haidai_flutter_module/page/stock/detail/widget/order_remark.dart';
import 'package:haidai_flutter_module/page/stock/detail/widget/static_title.dart';
import 'package:haidai_flutter_module/page/stock/model/req/order_stock_update_dto.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';
import 'package:haidai_flutter_module/repository/order/stock_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/mix_sku_list_view.dart';
import 'package:haidai_flutter_module/widget/mix_sku_silver_view.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';



class DeliveryGoodsListWidget extends StatefulWidget {
  var _context;

  DeliveryGoodsListWidget();

  @override
  State<StatefulWidget> createState() {
    return _DeliveryGoodsListWidgetState();
  }
}

class _DeliveryGoodsListWidgetState extends State<DeliveryGoodsListWidget> {
  @override
  Widget build(BuildContext context) {
    widget._context = context;
    return goodsListWidget();
  }

  Widget goodsListWidget() {
    return GetBuilder<DeliveryDetailController>(
        id: "deliveryList",
        builder: (ctl) {
          return MixSkuSilverView(
            tag: "deliveryList",
            uniKey: "id",
            data: ctl.saleList,
            skuMap: ctl.saleSkuMap,
            mainItem: goodsItem,
            mainItemType: "DeliveryDetailDeliveryGoodsList",
            controller: ctl,
            thirdTagName: "发货数",
            thirdTag: "goodsNum",
            thirdTagColor: ColorConfig.color_1678ff,

          );
        });
  }

  Widget goodsItem(int index, state) {
    return GetBuilder<DeliveryDetailController>(
        id: "goods" + index.toString(),
        builder: (ctl) {
          var item = ctl.saleList[index];

          String goodsName = item.storeGoodsBaseDo!.goodsNameSerial!;
          String orderInfo = '销售单' + '\n' + item.orderSaleId!.toString();

          return Container(
            child: Container(
                margin: EdgeInsets.only(
                    top: index == 0 ? 30.w : 10.w, bottom: 12.w),
                padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        state.operator(index, item.id);
                      },
                      child: Row(
                        children: [
                          Row(children: [
                            Stack(
                            children: [
                              NetImageWidget(
                                (item.storeGoodsBaseDo!.imgPath ?? "") + "/" +
                                    (item.storeGoodsBaseDo!.cover ?? ""),
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
                                    child: GestureDetector(child: Column(
                                      children: [
                                        pText("销售单", ColorConfig.color_ffffff, 20.w),
                                        pText(item.orderSaleSerial, ColorConfig.color_ffffff, 20.w)
                                      ],
                                    ),onTap: (){
                                      Get.toNamed(ArgUtils.map2String(path: Routes.SALE_DETAIL, arguments: {
                                        Constant.ORDER_SALE_ID: item.orderSaleId,
                                        Constant.DEPT_ID: ctl.deptId
                                      }));
                                    },),
                                  ))
                            ],
                          ),],),

                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 16.w),
                                height: 140.w,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          width: 382.w,
                                          alignment: Alignment.centerLeft,
                                          child: pText(goodsName,
                                              ColorConfig.color_333333, 32.w,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    // pText(priceText, ColorConfig.color_999999, 28.w),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            updateRemark(
                                                widget._context, item, ctl,
                                                index);
                                          },
                                          child: pText(
                                              "备注", ColorConfig.color_999999,
                                              28.w),
                                        ),
                                        Row(
                                          children: [
                                            pSizeBoxW(5.w),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                // pText("发",
                                                //     ColorConfig.color_1678ff,
                                                //     32.w),
                                                pText("发" + item.goodsNum.toString(),
                                                    ColorConfig.color_1678ff,
                                                    34.w, fontWeight: FontWeight
                                                        .w600),
                                              ],
                                            ),
                                            GetBuilder<
                                                DeliveryDetailController>(
                                                id: "open" +
                                                    item.goodsId.toString(),
                                                builder: (ctl) {
                                                  return Row(
                                                    children: [
                                                      pImage(
                                                          "images/icon_down.png",
                                                          32.w, 32.w)

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
                    GetBuilder<DeliveryDetailController>(
                        id: "deliveryGoodsRemark" + item.id.toString(),
                        builder: (ctl) {
                          return Visibility(
                              visible: item.remark != null && item.remark != "",
                              child: InkWell(
                                onTap: () {
                                  updateRemark(
                                      widget._context, item, ctl, index);
                                },
                                child: Container(
                                  decoration:
                                  new BoxDecoration(
                                      color: Color(ColorConfig.color_f5f5f5),
                                      borderRadius: new BorderRadius.circular(
                                          (10.w))),
                                  padding: EdgeInsets.only(
                                      left: 10.w, right: 10.w),
                                  margin: EdgeInsets.only(top: 16.w),
                                  alignment: Alignment.centerLeft,
                                  height: 44.w,
                                  width: double.infinity,
                                  child: pText("备注: " + item.remark.toString(),
                                      ColorConfig.color_F3AE1F, 24.w),
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
            SaleApi.updateDeliveryGoodsRemark(item.id, value).then((v) {
              ctl.saleList[index].remark = value;
              ctl.update(["deliveryGoodsRemark" + item.id.toString()]);
            });
          },
        );
      });
}

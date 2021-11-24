import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/page/stock/detail/controller/stock_detail_controller.dart';
import 'package:haidai_flutter_module/page/stock/model/req/order_stock_update_dto.dart';
import 'package:haidai_flutter_module/repository/order/stock_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/mix_sku_silver_view.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class GoodsListWidget extends StatelessWidget {
  var _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return goodsListWidget();
  }

  Widget goodsListWidget() {
    return GetBuilder<StockDetailController>(builder: (ctl) {
      return  GetBuilder<StockDetailController>(
                id: "transferList",
                builder: (ctl) {
                  return MixSkuSilverView(
                    data: ctl.getData(),
                    skuMap: ctl.skuMap,
                    mainItem: goodsItem,
                    mainItemType: "OrderStockNewDoGoods",
                    // topItem: [orderTitle(), orderRemark(), staticTitle()],
                    controller: ctl,
                    thirdTagName: ctl.thirdTagName,
                    thirdTag: ctl.thirdTag,
                    navigateThird: ctl.navigateThird,
                    thirdTagColor: ctl.thirdTagColor,
                    fourTagName: ctl.fourTagName,
                    fourTag: ctl.fourTag,
                    fourTagColor: ctl.fourTagColor,
                    navigateFour: ctl.navigateFour,
                    showNavigateTag: ctl.isAdjust ? 'thirdTag' : null,
                  );
                },
              );
    });
  }

  Widget goodsItem(int index, state) {
    return GetBuilder<StockDetailController>(
        id: "goods" + index.toString(),
        builder: (ctl) {
          var item = ctl.getData()[index];
          String goodsName = (item.storeGoodsBaseDo.goodsSerial ?? "") +
              (item.storeGoodsBaseDo.goodsName == null ||
                      item.storeGoodsBaseDo.goodsName?.length == 0
                  ? ""
                  : "-") +
              (item.storeGoodsBaseDo.goodsName ?? "");
          return Container(
            child: Stack(children: [
              Container(
                  margin:
                      EdgeInsets.only(top: index == 0 ? 30.w : 10.w, bottom: 14.w),
                  padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          state.operator(index, item.goodsId);
                          ctl.openStatus[item.goodsId] =
                              ctl.openStatus[item.goodsId] == null
                                  ? true
                                  : !ctl.openStatus[item.goodsId]!;
                          ctl.update(["open" + item.goodsId.toString()]);
                        },
                        child: Row(
                          children: [
                            NetImageWidget(
                              (item.storeGoodsBaseDo.imgPath ?? "") +
                                  "/" +
                                  (item.storeGoodsBaseDo.cover ?? ""),
                              height: 140,
                              width: 140,
                            ),
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left: 16.w),
                                    height: 160.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 382.w,
                                              alignment: Alignment.centerLeft,
                                              child: pText(
                                                  goodsName,
                                                  ColorConfig.color_333333,
                                                  32.w,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                updateRemark(
                                                    _context, item, ctl, index);
                                              },
                                              child: pText(
                                                  "备注",
                                                  ColorConfig.color_999999,
                                                  28.w),
                                            ),
                                            Row(
                                              children: [
                                                GetBuilder<
                                                        StockDetailController>(
                                                    id: "open" +
                                                        item.goodsId.toString(),
                                                    builder: (ctl) {
                                                      return Row(
                                                        children: [
                                                          GetBuilder<
                                                                  StockDetailController>(
                                                              id: "goodsAddNum" +
                                                                  item.goodsId
                                                                      .toString(),
                                                              builder: (ctl) {
                                                                if (item.addNum !=
                                                                        0 &&
                                                                    item.subtractNum !=
                                                                        0) {
                                                                  return Row(
                                                                    children: [
                                                                      pText(
                                                                          '增加' +
                                                                              item.addNum
                                                                                  .toString(),
                                                                          ColorConfig
                                                                              .color_1678FF,
                                                                          32.w,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                      pText(
                                                                          "  减少" +
                                                                              (-item.subtractNum)
                                                                                  .toString(),
                                                                          ColorConfig
                                                                              .color_FA6400,
                                                                          32.w,
                                                                          fontWeight:
                                                                              FontWeight.w600)
                                                                    ],
                                                                  );
                                                                } else {
                                                                  if (ctl.oldStock!
                                                                          .orderType ==
                                                                      OrderStockTypeEnum
                                                                          .SUBSTANDARD_RECORD) {
                                                                    int num = item
                                                                            .addNum -
                                                                        item.subtractNum;
                                                                    return Row(
                                                                      children: [
                                                                        pText(
                                                                            "正品少$num",
                                                                            ColorConfig.color_1678ff,
                                                                            32.w,
                                                                            fontWeight: FontWeight.w600),
                                                                        pText(
                                                                            "  次品多$num",
                                                                            ColorConfig.color_FA6400,
                                                                            32.w,
                                                                            fontWeight: FontWeight.w600)
                                                                      ],
                                                                    );
                                                                  } else if (ctl
                                                                          .oldStock!
                                                                          .orderType ==
                                                                      OrderStockTypeEnum
                                                                          .SUBSTANDARD_RECOVER) {
                                                                    int num = item
                                                                            .addNum -
                                                                        item.subtractNum;
                                                                    return Row(
                                                                      children: [
                                                                        pText(
                                                                            "正品多$num",
                                                                            ColorConfig.color_1678ff,
                                                                            32.w,
                                                                            fontWeight: FontWeight.w600),
                                                                        pText(
                                                                            "  次品少$num",
                                                                            ColorConfig.color_FA6400,
                                                                            32.w,
                                                                            fontWeight: FontWeight.w600)
                                                                      ],
                                                                    );
                                                                  } else {
                                                                    if (item.addNum !=
                                                                        0) {
                                                                      return pText(
                                                                          (ctl.isAdjust ? '增加' : '入库') +
                                                                              item.addNum
                                                                                  .toString(),
                                                                          ColorConfig
                                                                              .color_1678FF,
                                                                          32.w,
                                                                          fontWeight:
                                                                              FontWeight.w600);
                                                                    } else {
                                                                      return pText(
                                                                          (ctl.isAdjust ? '减少' : '出库') +
                                                                              (-item.subtractNum)
                                                                                  .toString(),
                                                                          ColorConfig
                                                                              .color_FA6400,
                                                                          32.w,
                                                                          fontWeight:
                                                                              FontWeight.w600);
                                                                    }
                                                                  }
                                                                }
                                                              }),
                                                          pImage(
                                                              (ctl.openStatus[item
                                                                              .goodsId] ==
                                                                          null ||
                                                                      ctl.openStatus[
                                                                              item.goodsId] ==
                                                                          false)
                                                                  ? "images/icon_down.png"
                                                                  : "images/icon_up.png",
                                                              32.w,
                                                              32.w)
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
                      GetBuilder<StockDetailController>(
                          id: "goodsRemark" + item.goodsId.toString(),
                          builder: (ctl) {
                            return Visibility(
                                visible:
                                    item.remark != null && item.remark != "",
                                child: InkWell(
                                  onTap: () {
                                    updateRemark(_context, item, ctl, index);
                                  },
                                  child: Container(
                                    decoration: new BoxDecoration(
                                        color: Color(ColorConfig.color_f5f5f5),
                                        borderRadius:
                                            new BorderRadius.circular((10.w))),
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    margin: EdgeInsets.only(top: 16.w),
                                    alignment: Alignment.centerLeft,
                                    height: 44.w,
                                    width: double.infinity,
                                    child: pText(
                                        "备注: " + item.remark.toString(),
                                        ColorConfig.color_F3AE1F,
                                        24.w),
                                  ),
                                ));
                          })
                    ],
                  )),
            ]),
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
            OrderStockUpdateDto param = new OrderStockUpdateDto();
            param.id = ctl.oldStock!.id;
            OrderStockUpdateDtoRemarks newRemark =
                new OrderStockUpdateDtoRemarks();
            newRemark.id = item.id;
            newRemark.remark = value;
            param.remarks = [newRemark];

            StockApi.updateRemark(param).then((v) {
              ctl.data[index].remark = value;
              ctl.update(["goodsRemark" + item.goodsId.toString()]);
            });
          },
        );
      });
}

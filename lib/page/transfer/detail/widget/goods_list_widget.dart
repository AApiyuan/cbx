import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/transfer/detail/controller/transfer_detail_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/substandard.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_status.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/mix_sku_silver_view.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';


class GoodsListWidget extends StatelessWidget {
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return goodsListWidget();
  }

  Widget goodsListWidget() {
    return GetBuilder<TransferDetailController>(builder: (ctl) {
      return GetBuilder<TransferDetailController>(
        id: "transferList",
        builder: (ctl) {
          return MixSkuSilverView(
            data: ctl.getData(),
            skuMap: ctl.skuMap,
            mainItem: goodsItem,
            mainItemType: "TransferDoGoods",
            controller: ctl,
            thirdTagName: ctl.thirdTagName,
            thirdTag: ctl.thirdTag,
            thirdTagColor: ctl.thirdTagColor,
            fourTagName: ctl.fourTagName,
            fourTag: ctl.fourTag,
            fourTagColor: ctl.fourTagColor,
            fiveTagName: ctl.fiveTagName,
            fiveTag: ctl.fiveTag,
            fiveTagColor: ctl.fiveTagColor,
            compareTag: ctl.compareTag,
            comparedTag: ctl.comparedTag,
          );
        },
      );
    });
  }

  Widget goodsItem(int index, state) {
    return GetBuilder<TransferDetailController>(
        id: "goods" + index.toString(),
        builder: (ctl) {
          var item = ctl.getData()[index];
          String goodsName = (item.storeGoodsBaseDo.goodsSerial ?? "") +
              (item.storeGoodsBaseDo.goodsName == null ||
                      item.storeGoodsBaseDo.goodsName?.length == 0
                  ? ""
                  : "-") +
              (item.storeGoodsBaseDo.goodsName ?? "");
          bool showDifferent = false;
          String different = "";
          if ((item.differanceMore != null && item.differanceMore != 0) ||
              (item.differanceLess != null && item.differanceLess != 0)) {
            showDifferent = true;
            if (item.differanceMore != null && item.differanceMore != 0) {
              different += ("多" + item.differanceMore.toString());
              if (item.differanceLess != null && item.differanceLess != 0) {
                different += ("/少" + item.differanceLess.toString());
              }
            } else if (item.differanceLess != null &&
                item.differanceLess != 0) {
              different += ("少" + item.differanceLess.toString());
            }
          }

          return Container(
            child: Stack(children: [
              Container(
                  margin: EdgeInsets.only(
                      top: index == 0 ? 30.w : 10.w, bottom: 12.w),
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
                                    height: 140.w,
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
                                            ),
                                            Visibility(
                                                visible: showDifferent,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          250, 100, 0, 0.1),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      14.w),
                                                              topRight:
                                                                  Radius
                                                                      .circular(
                                                                          14.w),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      14.w))),
                                                  padding: EdgeInsets.fromLTRB(
                                                      12.w, 4.w, 12.w, 4.w),
                                                  alignment: Alignment.center,
                                                  child: pText(
                                                      different,
                                                      ColorConfig.color_FA6400,
                                                      20.w,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                          ],
                                        ),
                                        GetBuilder<TransferDetailController>(
                                            builder: (ctl) {
                                          if (ctl.orderTransfer!.orderSaleId !=
                                              null) {
                                            //配货
                                            if (ctl.orderTransfer!.status ==
                                                    TransferStatusEnum
                                                        .STOCK_IN ||
                                                ctl.orderTransfer!.status ==
                                                    TransferStatusEnum.FINISH) {
                                              return pText(
                                                  '配货出库' +
                                                      item.stockOutNum
                                                          .toString(),
                                                  ColorConfig.color_999999,
                                                  28.w);
                                            } else {
                                              return Container();
                                            }
                                          } else if (ctl
                                                  .orderTransfer!.status ==
                                              TransferStatusEnum
                                                  .WAIT_STOCK_IN) {
                                            if (ctl.orderTransfer!.orderType ==
                                                TransferOrderTypeEnum.APPLY) {
                                              return pText(
                                                  '申请' +
                                                      item.applyNum.toString(),
                                                  ColorConfig.color_999999,
                                                  28.w);
                                            } else {
                                              return Container();
                                            }
                                          } else if (ctl
                                                      .orderTransfer!.status ==
                                                  TransferStatusEnum.STOCK_IN ||
                                              ctl.orderTransfer!.status ==
                                                  TransferStatusEnum.FINISH) {
                                            if (ctl.orderTransfer!.orderType ==
                                                TransferOrderTypeEnum.APPLY) {
                                              return pText(
                                                  '申请' +
                                                      item.applyNum.toString() +
                                                      "/出库" +
                                                      item.stockOutNum
                                                          .toString(),
                                                  ColorConfig.color_999999,
                                                  28.w);
                                            } else {
                                              String type = "";
                                              if (ctl.orderTransfer!
                                                      .orderType ==
                                                  TransferOrderTypeEnum
                                                      .DIRECT) {
                                                type = ctl.orderTransfer!
                                                            .substandard ==
                                                        SubstandardEnum.NO
                                                    ? "正品"
                                                    : "次品";
                                              }
                                              return pText(
                                                  type +
                                                      "出库" +
                                                      item.stockOutNum
                                                          .toString(),
                                                  ColorConfig.color_999999,
                                                  28.w);
                                            }
                                          } else {
                                            return Container();
                                          }
                                        }),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: _context,
                                                    barrierDismissible: false,
                                                    builder: (_) {
                                                      return CustomDialog(
                                                        title: '备注',
                                                        type: 0,
                                                        value:
                                                            item.remark ?? "",
                                                        confirmCallback:
                                                            (value) {
                                                          //直接添加 货品备注

                                                          TransferApi
                                                                  .updateGoodsRemark(
                                                                      item.id,
                                                                      value)
                                                              .then((v) {
                                                            ctl.data[index]
                                                                .remark = value;
                                                            ctl.update([
                                                              "goodsRemark" +
                                                                  item.goodsId
                                                                      .toString()
                                                            ]);
                                                          });
                                                        },
                                                      );
                                                    });
                                              },
                                              child: pText(
                                                  "备注",
                                                  ColorConfig.color_999999,
                                                  28.w),
                                            ),
                                            Row(
                                              children: [
                                                GetBuilder<
                                                        TransferDetailController>(
                                                    id: "open" +
                                                        item.goodsId.toString(),
                                                    builder: (ctl) {
                                                      return Row(
                                                        children: [
                                                          GetBuilder<
                                                                  TransferDetailController>(
                                                              id: "goodsAddNum" +
                                                                  item.goodsId
                                                                      .toString(),
                                                              builder: (ctl) {
                                                                if (ctl.orderTransfer!
                                                                        .orderSaleId !=
                                                                    null) {
                                                                  //配货
                                                                  if (ctl.orderTransfer!
                                                                              .status ==
                                                                          TransferStatusEnum
                                                                              .STOCK_IN ||
                                                                      ctl.orderTransfer!
                                                                              .status ==
                                                                          TransferStatusEnum
                                                                              .FINISH) {
                                                                    return pText(
                                                                        '配货入库' +
                                                                            item.stockInNum
                                                                                .toString(),
                                                                        ColorConfig
                                                                            .color_1678FF,
                                                                        32.w,
                                                                        fontWeight:
                                                                            FontWeight.w600);
                                                                  } else {
                                                                    return pText(
                                                                        '配货出库' +
                                                                            item.stockOutNum
                                                                                .toString(),
                                                                        ColorConfig
                                                                            .color_1678FF,
                                                                        32.w,
                                                                        fontWeight:
                                                                            FontWeight.w600);
                                                                  }
                                                                } else if (ctl
                                                                        .orderTransfer!
                                                                        .status ==
                                                                    TransferStatusEnum
                                                                        .WAIT_STOCK_OUT) {
                                                                  return pText(
                                                                      '申请' +
                                                                          item.applyNum
                                                                              .toString(),
                                                                      ColorConfig
                                                                          .color_1678FF,
                                                                      32.w,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600);
                                                                } else if (ctl
                                                                        .orderTransfer!
                                                                        .status ==
                                                                    TransferStatusEnum
                                                                        .WAIT_STOCK_IN) {
                                                                  String type =
                                                                      "";
                                                                  if (ctl.orderTransfer!
                                                                          .orderType ==
                                                                      TransferOrderTypeEnum
                                                                          .DIRECT) {
                                                                    type = ctl.orderTransfer!.substandard ==
                                                                            SubstandardEnum.NO
                                                                        ? "正品"
                                                                        : "次品";
                                                                  }
                                                                  return pText(
                                                                      type +
                                                                          '出库' +
                                                                          item.stockOutNum
                                                                              .toString(),
                                                                      ColorConfig
                                                                          .color_1678FF,
                                                                      32.w,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600);
                                                                } else if (ctl
                                                                            .orderTransfer!
                                                                            .status ==
                                                                        TransferStatusEnum
                                                                            .STOCK_IN ||
                                                                    ctl.orderTransfer!
                                                                            .status ==
                                                                        TransferStatusEnum
                                                                            .FINISH) {
                                                                  String type =
                                                                      "";
                                                                  if (ctl.orderTransfer!
                                                                          .orderType ==
                                                                      TransferOrderTypeEnum
                                                                          .DIRECT) {
                                                                    type = ctl.orderTransfer!.substandard ==
                                                                            SubstandardEnum.NO
                                                                        ? "正品"
                                                                        : "次品";
                                                                  }
                                                                  return pText(
                                                                      type +
                                                                          '入库' +
                                                                          item.stockInNum
                                                                              .toString(),
                                                                      ColorConfig
                                                                          .color_1678FF,
                                                                      32.w,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600);
                                                                } else {
                                                                  return Container();
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
                      GetBuilder<TransferDetailController>(
                          id: "goodsRemark" + item.goodsId.toString(),
                          builder: (ctl) {
                            return Visibility(
                                visible:
                                    item.remark != null && item.remark != "",
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: _context,
                                        barrierDismissible: false,
                                        builder: (_) {
                                          return CustomDialog(
                                            title: '备注',
                                            type: 0,
                                            value: item.remark ?? "",
                                            confirmCallback: (value) {
                                              TransferApi.updateGoodsRemark(
                                                      item.id, item.remark)
                                                  .then((v) {
                                                ctl.data[index].remark = value;
                                                ctl.update([
                                                  "goodsRemark" +
                                                      item.goodsId.toString()
                                                ]);
                                              });
                                            },
                                          );
                                        });
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/distribution/controller/distribution_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/add_sku.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/mix_sku_edit_list_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/more_dialog.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class GoodsListWidget extends StatelessWidget {
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return goodsListWidget();
  }

  Widget goodsListWidget() {
    return GetBuilder<DistributionController>(builder: (ctl) {
      return Expanded(
          child: Container(
              color: Color(ColorConfig.color_ffffff),
              width: Get.width,
              margin: EdgeInsets.fromLTRB(0.w, 20.w, 0.w, 110.w),
              child: GetBuilder<DistributionController>(
                id: "transferList",
                builder: (ctl) {
                  return MixSkuEditListView(
                    data: ctl.getData(),
                    skuMap: ctl.skuMap,
                    mainItem: goodsItem,
                    controller: ctl,
                    thirdTagName: ctl.thirdTagName as String,
                    thirdTag: ctl.thirdTag as String,
                    handleTagName: "数量",
                    handleTag: ctl.handleTag as String,
                    handleOverThird: ctl.handleOverThird,
                    thirdTagExtra: ctl.thirdTagExtra as String,
                    thirdTagNameExtra: ctl.thirdTagNameExtra as String,
                    callBack: (int key, int index, int itemAdd, int itemMinus) {
                      ctl.calculate(key, index, itemAdd, itemMinus);
                    },
                  );
                },
              )));
    });
  }

  Widget goodsItem(int index, state) {
    var moreKey = GlobalKey();

    return GetBuilder<DistributionController>(
        id: "goods" + index.toString(),
        builder: (ctl) {
          var item = ctl.getData()[index];
          String goodsName = (item.storeGoodsBaseDo.goodsSerial ?? "") +
              (item.storeGoodsBaseDo.goodsName == null || item.storeGoodsBaseDo.goodsName?.length == 0 ? "" : "-") +
              (item.storeGoodsBaseDo.goodsName ?? "");

          return Container(
            child: Stack(children: [
              Container(
                  margin: EdgeInsets.only(top: 35.w, bottom: 14.w, left: 24.w, right: 24.w),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => state.operator(index, item.goodsId),
                        child: Row(
                          children: [
                            NetImageWidget(
                              (item.storeGoodsBaseDo.imgPath ?? "") + "/" + (item.storeGoodsBaseDo.cover ?? ""),
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
                                        Container(
                                          width: 382.w,
                                          alignment: Alignment.centerLeft,
                                          child: pText(goodsName, ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w600),
                                        ),
                                        GetBuilder<DistributionController>(builder: (ctl) {
                                          if (ctl.handleTag == "stockOutNum") {
                                            return Row(
                                              children: [
                                                pText('库存' + (item.stockNum.toString() == 'null' ? "0" : item.stockNum.toString()),
                                                    ColorConfig.color_999999, 28.w),
                                                pSizeBoxW(16.w),
                                                SizedBox(
                                                  width: 1.w,
                                                  height: 24.w,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(color: Color(ColorConfig.color_CCCCCC)),
                                                  ),
                                                ),
                                                pSizeBoxW(16.w),
                                                pText(
                                                    '待配' + (item.notDistributionNum.toString() == 'null' ? "0" : item.notDistributionNum.toString()),
                                                    ColorConfig.color_999999,
                                                    28.w),
                                              ],
                                            );
                                          } else {
                                            return Row(
                                              children: [
                                                pText('欠货' + (item.shortageNum == 'null' ? "0" : item.shortageNum.toString()),
                                                    ColorConfig.color_999999, 28.w),
                                                pSizeBoxW(16.w),
                                                SizedBox(
                                                  width: 1.w,
                                                  height: 24.w,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(color: Color(ColorConfig.color_CCCCCC)),
                                                  ),
                                                ),
                                                pSizeBoxW(16.w),
                                                pText('配出' + (item.stockOutNum.toString() == 'null' ? "0" : item.stockOutNum.toString()),
                                                    ColorConfig.color_999999, 28.w),
                                              ],
                                            );
                                          }
                                        }),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            pText("备注", ColorConfig.color_999999, 28.w, width: 60.w, onTap: () {
                                              showDialog(
                                                  context: _context,
                                                  barrierDismissible: false,
                                                  builder: (_) {
                                                    return CustomDialog(
                                                      title: '备注',
                                                      type: 0,
                                                      value: item.remark ?? "",
                                                      confirmCallback: (value) {
                                                        ctl.data[index].remark = value;
                                                        ctl.update(["goodsRemark" + item.goodsId.toString()]);
                                                      },
                                                    );
                                                  });
                                            }),
                                            Row(
                                              children: [
                                                GetBuilder<DistributionController>(
                                                    id: "goodsAddNum" + item.goodsId.toString(),
                                                    builder: (ctl) {
                                                      return pText(
                                                          ctl.staticTitle + item.toJson()[ctl.handleTag].toString(), ColorConfig.color_1678FF, 32.w,
                                                          fontWeight: FontWeight.w600);
                                                    }),
                                                pImage("images/icon_down.png", 32.w, 32.w)
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    )))
                          ],
                        ),
                      ),
                      GetBuilder<DistributionController>(
                          id: "goodsRemark" + item.goodsId.toString(),
                          builder: (ctl) {
                            return Visibility(
                                visible: item.remark != null && item.remark != "",
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
                                              ctl.data[index].remark = value;
                                              ctl.update(["goodsRemark" + item.goodsId.toString()]);
                                            },
                                          );
                                        });
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
              new Positioned(
                  right: 24.w,
                  top: 15.w,
                  child: Container(
                    height: 66.w,
                    width: 53.w,
                    child: Row(
                      children: [
                        GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              showMoreDialog(ctl, item, index, state, goodsName, moreKey);
                            },
                            child: pImage("images/more.png", 48.w, 32.w, key: moreKey)),
                      ],
                    ),
                  )),
            ]),
          );
        });
  }

  showMoreDialog(DistributionController ctl, item, index, state, goodsName, _moreKey) {
    MoreDialog({
      "叠加": () {
        ctl.update(["goodsOperateShow" + item.goodsId.toString()]);
        showCupertinoModalBottomSheet(
            context: Get.context!,
            expand: true,
            enableDrag: false,
            animationCurve: Curves.easeIn,
            builder: (context) => AddSku(
                  controller: ctl,
                  title: goodsName,
                  imgUrl: (item.storeGoodsBaseDo.imgPath ?? "") + "/" + (item.storeGoodsBaseDo.cover ?? ""),
                  skus: ctl.skuMap[item.goodsId] as List,
                  thirdTag: ctl.handleTag as String,
                  callback: (skus, map) {
                    //更新列表数据；
                    state.updateAdd(skus, map, item.goodsId, index);
                  },
                ));
      }
    }).show(_context, _moreKey);
  }
}

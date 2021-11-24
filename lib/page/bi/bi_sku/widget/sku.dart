import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_sku/controller/sku_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget sku() {
  return GetBuilder<SkuController>(
      id: 'sku',
      builder: (ctl) {
        return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    width: 1500.w,
                    margin: EdgeInsets.only(top: 30.w, bottom: 30.w),
                    decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          margin: EdgeInsets.only(top: 40.w),
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          height: 44.w,
                          child: Row(
                            children: [
                              pText("颜色", 0xb3ffffff, 24.w, width: 180.w, alignment: Alignment.centerLeft),
                              pText("尺码", 0xb3ffffff, 24.w, width: 180.w, alignment: Alignment.centerLeft),
                              pText("销售数", 0xb3ffffff, 24.w, width: 180.w, alignment: Alignment.centerLeft),
                              pText("正品库存", 0xb3ffffff, 24.w, width: 180.w, alignment: Alignment.centerLeft),
                              pText("次品库存", 0xb3ffffff, 24.w, width: 180.w, alignment: Alignment.centerLeft),
                              pText("欠货", 0xb3ffffff, 24.w, width: 180.w, alignment: Alignment.centerLeft),
                              pText("退欠货数", 0xb3ffffff, 24.w, width: 180.w, alignment: Alignment.centerLeft),
                              pText("退实物数", 0xb3ffffff, 24.w, width: 180.w, alignment: Alignment.centerLeft),
                            ],
                          ),
                        ),
                        Expanded(
                            child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            if (ctl.skuMap.length > 0) {
                              return Container(
                                padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.w, bottom: 20.w),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.w,
                                            color: ctl.skuMap[index]['showLine'] ? Color.fromRGBO(255, 255, 255, 0.1) : Colors.transparent))),
                                child: Row(
                                  children: [
                                    pText(ctl.skuMap[index]['showText'] ? ctl.skuMap[index]['color'] : "", ColorConfig.color_ffffff, 24.w,
                                        width: 180.w, alignment: Alignment.centerLeft),
                                    pText(ctl.skuMap[index]['size'], ColorConfig.color_ffffff, 24.w, width: 180.w, alignment: Alignment.centerLeft),
                                    pText(
                                        ctl.skuMap[index]['data'].normalSaleGoodsNum != null
                                            ? ctl.skuMap[index]['data'].normalSaleGoodsNum.toString()
                                            : '0',
                                        ColorConfig.color_ffffff,
                                        24.w,
                                        width: 180.w,
                                        alignment: Alignment.centerLeft),
                                    pText(ctl.skuMap[index]['data'].stockNum != null ? ctl.skuMap[index]['data'].stockNum.toString() : '0',
                                        ColorConfig.color_ffffff, 24.w,
                                        width: 180.w, alignment: Alignment.centerLeft),
                                    pText(ctl.skuMap[index]['data'].substandardNum != null ? ctl.skuMap[index]['data'].substandardNum.toString() : '0',
                                        ColorConfig.color_ffffff, 24.w,
                                        width: 180.w, alignment: Alignment.centerLeft),
                                    pText(ctl.skuMap[index]['data'].shortageNum != null ? ctl.skuMap[index]['data'].shortageNum.toString() : '0',
                                        ColorConfig.color_ff1a43, 24.w,
                                        width: 180.w, alignment: Alignment.centerLeft),
                                    pText(
                                        ctl.skuMap[index]['data'].returnGoodsNum != null ? ctl.skuMap[index]['data'].returnGoodsNum.toString() : '0',
                                        ColorConfig.color_ffffff,
                                        24.w,
                                        width: 180.w,
                                        alignment: Alignment.centerLeft),
                                    pText(
                                        ctl.skuMap[index]['data'].changeBackOrderGoodsNum != null
                                            ? ctl.skuMap[index]['data'].changeBackOrderGoodsNum.toString()
                                            : '0',
                                        ColorConfig.color_ffffff,
                                        24.w,
                                        width: 180.w,
                                        alignment: Alignment.centerLeft),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                          itemCount: ctl.skuMap.length,
                        ))
                      ],
                    )));
      });
}

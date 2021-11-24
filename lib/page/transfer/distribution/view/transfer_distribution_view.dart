import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/model/enum/transfer_enum.dart';
import 'package:haidai_flutter_module/page/transfer/distribution/controller/transfer_distribution_controller.dart';
import 'package:haidai_flutter_module/page/transfer/distribution/widget/transfer_distribution_shop_filter.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_distribution_list_entity.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/drawer_dialog.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

// ignore: must_be_immutable
class TransferDistributionView extends GetView<TransferDistributionController> {
  EasyRefreshController _controller = EasyRefreshController();
  late TransferDistributionController _transController =
      Get.find<TransferDistributionController>();
  var data = [];
  var _toolbarKey = GlobalKey();
  var _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    // TODO: implement build
    return WillPopScope(
        child: GetBuilder<TransferDistributionController>(
            id: "TransferDistribution",
            builder: (ctl) {
              return Scaffold(
                backgroundColor: Color(ColorConfig.color_ffffff),
                appBar: pAppBar(
                  '配货任务' + '(' + ctl.count.toString() + ')',
                  actions: [
                    GestureDetector(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            pImage("images/record.png", 34.w, 34.w),
                            pText("调拨记录", ColorConfig.color_1678ff, 14.w)
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(
                          ArgUtils.map2String(
                              path: Routes.TRANSFER_CENTER,
                              arguments: {
                                "depId": ctl.deptId,
                                "TransferOrderType":
                                    TransferOrderType.transferOut.index,
                                "TransferSelectType":
                                    TransferSelectType.distribution.index
                              }),
                        );
                      },
                    ),
                    pSizeBoxW(40.w)
                  ],
                ),
                body: Container(
                    color: Color(ColorConfig.color_f5f5f5),
                    child: Column(
                      children: [
                        Container(
                          key: _toolbarKey,
                          color: Color(ColorConfig.color_ffffff),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              pSizeBoxW(24.w),

                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  _transController.loadShopData().then((value) {
                                    DrawerDialog((dialog) =>
                                        distributionShopContent(dialog, value,
                                            () {
                                          print("他店");
                                          // print(_transController.selectedHisShopId);
                                        })).show(_context, _toolbarKey);
                                  });
                                },
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      pText(
                                          '店铺', ColorConfig.color_999999, 24.w),
                                      pImage(
                                          "images/icon_down.png", 24.w, 24.w),
                                    ]),
                              )),
                              Expanded(
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      pText('只查看未打印', ColorConfig.color_999999,
                                          24.w),
                                      GetBuilder<
                                              TransferDistributionController>(
                                          id: "transferListSwitch",
                                          builder: (ctl) {
                                            return CupertinoSwitch(
                                              value: ctl.notPrint,
                                              activeColor: Colors.greenAccent,
                                              onChanged: (value) {
                                                ctl.notPrint = value;
                                                _controller.resetRefreshState();
                                                ctl.loadListCountData();
                                              },
                                            );
                                          }),
                                    ]),
                              ),
                              pSizeBoxW(24.w),

                              //
                            ],
                          ),
                        ),
                        Expanded(
                            child: EasyRefresh.custom(
                                enableControlFinishLoad: false,
                                controller: _controller,
                                header: RefreshUtils.defaultHeader(),
                                footer: RefreshUtils.defaultFooter(),
                                onRefresh: () async {
                                  ctl.pageNo = 1;
                                  ctl.loadListData();
                                },
                                onLoad: () async {
                                  await Future.delayed(Duration(seconds: 1),
                                      () {
                                    ctl.pageNo++;
                                    ctl.loadListData();
                                  });
                                },
                                slivers: <Widget>[
                              GetBuilder<TransferDistributionController>(
                                  builder: (ctl) {
                                if (ctl.data.length == 0) {
                                  return SliverToBoxAdapter(
                                    child: Center(
                                        child: emptyWidget(
                                            bgColor:
                                                ColorConfig.color_00000000)),
                                  );
                                } else {
                                  return SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        TransferDistributionListEntity item =
                                            ctl.data[index];
                                        String remark = '';
                                        if (item.remarkList != null) {
                                          for (var remarkItem in item.remarkList!) {
                                            if (remark.length > 0) {
                                              remark = remark + '\n';
                                            }
                                            remark = remark + remarkItem.createdByName! + ':' + remarkItem.remark!;
                                          }
                                        }
                                        if (ctl.data.length == 0) {
                                          return SliverToBoxAdapter(
                                            child: Center(
                                                child: emptyWidget(bgColor: ColorConfig.color_00000000)),
                                          );
                                        }


                                        return Container(
                                          width: double.infinity,
                                          padding:
                                              EdgeInsets.only(bottom: 10.w),
                                          margin: EdgeInsets.only(
                                              left: 24.w,
                                              right: 24.w,
                                              top: 5.w,
                                              bottom: 5.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(11.0),
                                            // color: Colors.white,
                                          ),
                                          child: Column(children: [
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: 20.w,
                                                    bottom: 20.w,
                                                    left: 10.w,
                                                    right: 0),
                                                width: Get.width,
                                                child: pText(
                                                    item.customizeTime!,
                                                    ColorConfig.color_999999,
                                                    24.w,
                                                    textAlign: TextAlign.left)),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(11.w),
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                // borderRadius: BorderRadius.circular(15),

                                                children: [
                                                  pSizeBoxH(24.w),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      pSizeBoxW(20.w),
                                                      pContainerText(
                                                          '#' +
                                                              (int.parse(item
                                                                          .orderSaleSerial!) %
                                                                      1000)
                                                                  .toString(),
                                                          ColorConfig
                                                              .color_ffffff,
                                                          24.w,
                                                          62.w,
                                                          28.w,
                                                          background:
                                                              ColorConfig
                                                                  .color_000000,
                                                          radius: 4.w),
                                                      pSizeBoxW(5),
                                                      pText(
                                                          item.customizeTime!
                                                              .substring(0, 10),
                                                          ColorConfig
                                                              .color_333333,
                                                          24.w,
                                                          textAlign:
                                                              TextAlign.right,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      Expanded(
                                                          child: Container()),
                                                    ],
                                                  ),
                                                  pSizeBoxH(20.w),
                                                  InkWell(
                                                      onTap: () {
                                                        // Get.toNamed(
                                                        //     ArgUtils.map2String(
                                                        //         path: Routes
                                                        //             .TRANSFER_DISTRIBUTION_RECORD),
                                                        //     arguments: {
                                                        //       "depId": 14001
                                                        //     });
                                                      },
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          pSizeBoxW(20.w),
                                                          pText(
                                                              item.deptName! +
                                                                  '-' +
                                                                  item.storeCustomer!
                                                                      .customerName!,
                                                              ColorConfig
                                                                  .color_999999,
                                                              24.w,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left),
                                                          Expanded(
                                                              child:
                                                                  Container()),
                                                          pSizeBoxW(10)
                                                        ],
                                                      )),
                                                  Visibility(
                                                      visible:
                                                          item.remarkList !=
                                                              null,
                                                      // visible: item.remarkList!.length > 0,
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 15,
                                                            bottom: 5,
                                                            left: 11,
                                                            right: 11),
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5,
                                                                left: 9,
                                                                right: 9,
                                                                bottom: 5),
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      11.0),
                                                          color:
                                                              Colors.grey[100],
                                                        ),
                                                        child: pText(
                                                            remark,
                                                            ColorConfig
                                                                .color_F3AE1F,
                                                            24.w,
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 999),
                                                      )),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10,
                                                            left: 11,
                                                            right: 11),
                                                        // width: double.infinity,
                                                        child: pText(
                                                            '待配' +
                                                                item.notDistributionStyleNum
                                                                    .toString() +
                                                                '款' +
                                                                item.notDistributionNum
                                                                    .toString(),
                                                            ColorConfig
                                                                .color_333333,
                                                            32.w,
                                                            textAlign:
                                                                TextAlign.right,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Expanded(
                                                          child: Container()),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      pSizeBoxW(20.w),
                                                      InkWell(
                                                        onTap: () {
                                                          print(ctl.deptId);
                                                          print(item.id);
                                                          var deptId =
                                                              _transController
                                                                  .deptId;
                                                          var orderSaleId =
                                                              item.id;
                                                          Get.toNamed(
                                                            ArgUtils.map2String(
                                                                path: Routes
                                                                    .TRANSFER_DISTRIBUTION_RECORD,
                                                                arguments: {
                                                                  Constant.STOCK_OUT_DEPT_ID:
                                                                      deptId,
                                                                  Constant.ORDER_SALE_ID:
                                                                      orderSaleId
                                                                }),
                                                          );
                                                        },
                                                        child: pText(
                                                          '开单' +
                                                              item.normalSaleNum
                                                                  .toString() +
                                                              '已调出' +
                                                              item.distributionNum
                                                                  .toString(),
                                                          ColorConfig
                                                              .color_333333,
                                                          28.w,
                                                          textAlign:
                                                              TextAlign.right,
                                                        ),
                                                      ),
                                                      pImage(
                                                          'images/icon_goto_01.png',
                                                          20.w,
                                                          20.w),
                                                      Expanded(
                                                          child: Container()),
                                                      // OutlineButton(
                                                      //     onPressed: () {
                                                      //       MethodChannel(ChannelConfig
                                                      //               .flutterToNative)
                                                      //           .invokeMethod(
                                                      //               ChannelConfig
                                                      //                   .methodPrintDistribution,
                                                      //               item.id);
                                                      //     },
                                                      //     borderSide: new BorderSide(
                                                      //         color: Color(ColorConfig
                                                      //             .color_1678FF)),
                                                      //     color: Color(
                                                      //         ColorConfig.color_1678FF),
                                                      //     shape: RoundedRectangleBorder(
                                                      //         borderRadius:
                                                      //             BorderRadius.all(
                                                      //                 Radius.circular(
                                                      //                     32.w))),
                                                      //     child: pText(
                                                      //       '打印' +
                                                      //           item.printNum
                                                      //               .toString(),
                                                      //       ColorConfig.color_1678FF,
                                                      //       24.w,
                                                      //       textAlign: TextAlign.center,
                                                      //     )),
                                                      pText(
                                                        '打印' +
                                                            item.printNum
                                                                .toString(),
                                                        ColorConfig
                                                            .color_1678FF,
                                                        24.w,
                                                        onTap: () {
                                                          MethodChannel(
                                                                  ChannelConfig
                                                                      .flutterToNative)
                                                              .invokeMethod(
                                                                  ChannelConfig
                                                                      .methodPrintDistribution,
                                                                  item.id);
                                                        },
                                                        width: 130.w,
                                                        height: 64.w,
                                                        radius: 32.w,
                                                        borderColor: ColorConfig
                                                            .color_1678FF,
                                                      ),
                                                      pSizeBoxW(10.w),
                                                      pButton(
                                                          130.w,
                                                          64.w,
                                                          '调出',
                                                          ColorConfig
                                                              .color_ffffff,
                                                          24.w, () {
                                                        Map<String, dynamic>
                                                            param = new Map();
                                                        param[Constant
                                                                .ORDER_SALE_ID] =
                                                            item.id;
                                                        param[Constant
                                                                .DEPT_ID] =
                                                            ctl.deptId;
                                                        param[Constant
                                                                .DISTRIBUTE_DEPT_ID] =
                                                            item.deptId;
                                                        Get.toNamed(ArgUtils
                                                                .map2String(
                                                                    path: Routes
                                                                        .DISTRIBUTION,
                                                                    arguments:
                                                                        param))!
                                                            .then((value) {
                                                          if (value ==
                                                              'Refresh') {
                                                            ctl.loadListCountData();
                                                          }
                                                        });
                                                      }, radius: 32.w),
                                                      pSizeBoxW(10)
                                                    ],
                                                  ),
                                                  pSizeBoxH(10.w),
                                                ],
                                              ),
                                            )
                                          ]),
                                        );
                                      },
                                      childCount: ctl.data.length,
                                    ),
                                  );
                                }
                              }),
                            ])),
                      ],
                    )),
              );
            }),
        onWillPop: () {
          BackUtils.back();
          return new Future.value(false);
        });

    throw UnimplementedError();
  }
}

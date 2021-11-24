import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/page/transfer/center/controller/transfer_center_controller.dart';
import 'package:haidai_flutter_module/page/transfer/center/widget/transfer_order_status.dart';
import 'package:haidai_flutter_module/page/transfer/distribution/controller/transfer_distribution_record_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_status.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_item_model_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_list_do_entity.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TransferDistributionRecordView
    extends GetView<TransferDistributionRecordController> {
  TransferDistributionRecordController _transController =
      Get.find<TransferDistributionRecordController>();
  EasyRefreshController _controller = EasyRefreshController();
  var data = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<TransferDistributionRecordController>(
        id: "TransferDistributionRecord",
        builder: (ctl) {
          return Scaffold(
            backgroundColor: Color(ColorConfig.color_f5f5f5),
            appBar: pAppBar(
              '调拨记录' + '(' + ctl.data.length.toString() + ')',
              actions: [pSizeBoxW(40.w)],
            ),
            body: EasyRefresh.custom(
                enableControlFinishLoad: false,
                controller: _controller,
                header: RefreshUtils.defaultHeader(),
                footer: RefreshUtils.defaultFooter(),
                onRefresh: () async {
                  ctl.pageNo = 1;
                  ctl.loadListData();
                },
                onLoad: () async {
                  _controller.finishLoad(noMore: false);
                },
                slivers: <Widget>[
                  GetBuilder<TransferDistributionRecordController>(
                    builder: (ctl) {
                      if (ctl.data.length == 0) {
                        return SliverToBoxAdapter(
                          child: Center(
                              child: emptyWidget(
                                  bgColor: ColorConfig.color_00000000)),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            TransferListDoEntity item = ctl.data[index];
                            TransferItemModelEntity listObj = listItem(item);
                            if (ctl.data.length == 0) {
                              return SliverToBoxAdapter(
                                child: Center(
                                    child: emptyWidget(
                                        bgColor: ColorConfig.color_00000000)),
                              );
                            }
                            return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () =>
                                    ctl.toTransferDetail(item.id as int),
                                child: Container(
                                  width: Get.width,
                                  margin: EdgeInsets.only(
                                      left: 24.0.w,
                                      right: 24.w,
                                      top: 5.w,
                                      bottom: 0.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11.0.w),
                                    // color: Colors.white,
                                  ),
                                  child: Column(children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 5.w,
                                            bottom: 5.w,
                                            left: 0.w,
                                            right: 11.w),
                                        width: Get.width,
                                        child: pText(listObj.time!,
                                            ColorConfig.color_999999, 24.w,
                                            textAlign: TextAlign.left)),
                                    Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(11.0),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            // borderRadius: BorderRadius.circular(15),
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 14.w,
                                                      left: 11.w,
                                                      right: 11.w),
                                                  width: Get.width,
                                                  child: pText(
                                                      listObj.deptName!,
                                                      ColorConfig.color_333333,
                                                      28.w,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      textAlign:
                                                          TextAlign.left)),
                                              pSizeBoxH(15.w),
                                              GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () {
                                                    Get.toNamed(
                                                        ArgUtils.map2String(
                                                            path: Routes
                                                                .SALE_DETAIL,
                                                            arguments: {
                                                          Constant.ORDER_SALE_ID:
                                                              item.orderSaleId,
                                                          Constant.DEPT_ID: ctl
                                                                      .stockOutDeptId !=
                                                                  -1
                                                              ? ctl
                                                                  .stockOutDeptId
                                                              : ctl
                                                                  .stockInDeptId
                                                        }));
                                                  },
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      pSizeBoxW(20.w),
                                                      pText(
                                                          listObj.orderInfo!,
                                                          ColorConfig
                                                              .color_999999,
                                                          24.w,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          textAlign:
                                                              TextAlign.left),
                                                      pImage(
                                                          'images/icon_goto_01.png',
                                                          20.w,
                                                          20.w),
                                                      Expanded(
                                                          child: Container()),
                                                      pSizeBoxW(10.w)
                                                    ],
                                                  )),
                                              pSizeBoxH(20.w),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 0,
                                                    left: 20.w,
                                                    right: 20.w),
                                                width: Get.width,
                                                child: TransferOrderStatus(
                                                    orderType: item.orderType!,
                                                    status: item.status!),
                                              ),
                                              Visibility(
                                                  visible:
                                                      listObj.remarks!.length >
                                                          0,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 15.w,
                                                        bottom: 10.w,
                                                        left: 11.w,
                                                        right: 11.w),
                                                    padding: EdgeInsets.only(
                                                        top: 5.w,
                                                        left: 9.w,
                                                        right: 9.w,
                                                        bottom: 8.w),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              11.0.w),
                                                      color: Colors.grey[100],
                                                    ),
                                                    child: pText(
                                                        listObj.remarks!,
                                                        ColorConfig
                                                            .color_F3AE1F,
                                                        24.w,
                                                        textAlign:
                                                            TextAlign.left),
                                                  )),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 15.w,
                                                        bottom: 15.w,
                                                        left: 11.w,
                                                        right: 11.w),
                                                    // width: double.infinity,
                                                    child: pText(
                                                        listObj.numInfo!,
                                                        ColorConfig
                                                            .color_333333,
                                                        32.w,
                                                        textAlign:
                                                            TextAlign.right,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Visibility(
                                                    visible:
                                                        listObj.difference !=
                                                            'NO_DIFFERENCE',
                                                    child: pContainerText(
                                                        '差异',
                                                        ColorConfig
                                                            .color_ffffff,
                                                        20.w,
                                                        52.w,
                                                        32.w,
                                                        background: ColorConfig
                                                            .color_FF8A15,
                                                        radius: 16.w),
                                                  ),
                                                  pSizeBoxW(10.w)
                                                ],
                                              ),
                                              GetBuilder<
                                                      TransferDistributionRecordController>(
                                                  id: "operation" +
                                                      item.id.toString(),
                                                  builder: (ctl) {
                                                    return actButtons(
                                                        item, listObj, index);
                                                  }),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                            visible:
                                                item.canceled == "CANCELED",
                                            child: Positioned(
                                              bottom: 0,
                                              right: 0,
                                              left: 0,
                                              top: 0,
                                              child: Stack(
                                                alignment:
                                                    Alignment.centerRight,
                                                children: [
                                                  Container(
                                                      color: Color(ColorConfig
                                                          .color_99ffffff)),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 24.w),
                                                    child: pImage(
                                                        "images/icon_canceled.png",
                                                        124.w,
                                                        124.w),
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ]),
                                  //
                                ));
                          },
                          childCount: ctl.data.length,
                        ),
                      );
                    },
                  ),
                ]),
          );
        });
  }

  Widget actButtons(
      TransferListDoEntity item, TransferItemModelEntity listObj, index) {
    List<Widget> actions = [];
    for (var actionTitle in listObj.actions!) {
      actions.add(pSizeBoxW(10.w));
      if (actionTitle == '完成并发货') {
        actions.add(actionButton(item, actionTitle, () {
          TransferApi.checkStock(item.id as int).then((v) {
            if (v) {
              _transController
                  .toFinish(item.id as int, isDelivery: true)
                  .then((v) {
                if (v) {
                  data[index].status = TransferStatusEnum.FINISH;
                  _transController.update(["operation" + item.id.toString()]);
                }
              });
            } else {
              showDialog(
                  context: Get.context as BuildContext,
                  builder: (_) {
                    return CustomDialog(
                      type: 1,
                      confirmTextColor: ColorConfig.color_ff3715,
                      content: pText(
                        "确定发货吗?发货数超库存，会导致负库存",
                        ColorConfig.color_333333,
                        32.w,
                        fontWeight: FontWeight.w600,
                        maxLines: 2,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            top: 0.w, left: 80.w, bottom: 0.w, right: 80.w),
                      ),
                      confirmCallback: (value) async {
                        _transController
                            .toFinish(item.id as int, isDelivery: true)
                            .then((v) {
                          if (v) {
                            data[index].status = TransferStatusEnum.FINISH;
                            _transController
                                .update(["operation" + item.id.toString()]);
                          }
                        });
                      },
                    );
                  });
            }
          });
        }));
      } else if (actionTitle == '仅完成') {
        actions.add(actionButton(item, actionTitle, () {
          _transController.toFinish(item.id as int).then((v) {
            if (v) {
              data[index].status = TransferStatusEnum.FINISH;
              _transController.update(["operation" + item.id.toString()]);
            }
          });
        }));
      } else {
        actions.add(actionButton(item, actionTitle,
            () => _transController.toTransferCreateOrUpdate(transfer: item)));
      }
    } //
    actions.add(pSizeBoxW(12.w));
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: actions),
      Visibility(visible: actions.length != 1, child: pSizeBoxH(20.w))
    ]);
  }

  Widget actionButton(
      TransferListDoEntity item, String title, Function function) {
    return pActionText(
        title, ColorConfig.color_333333, 24.w, 150.w, 64.w, function,
        borderColor: ColorConfig.color_dcdcdc,
        radius: 32.w,
        fontWeight: FontWeight.w500);
  }

  Widget actionBottons(TransferListDoEntity item) {
    if (item.status! == TransferStatusEnum.WAIT_STOCK_IN) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [actionBotton(item, '先入库')]);
    } else if (item.status! == TransferStatusEnum.STOCK_IN &&
        item.difference == 'NO_DIFFERENCE') {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [actionBotton(item, '修改入库数')]);
    } else if (item.status! == TransferStatusEnum.STOCK_IN &&
        item.difference != 'NO_DIFFERENCE') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          actionBotton(item, '修改入库数'),
          actionBotton(item, '仅完成'),
          actionBotton(item, '完成并发货'),
        ],
      );
    } else if (item.status! == TransferStatusEnum.FINISH) {
      return Container();
    } else if (item.status! == TransferStatusEnum.WAIT_STOCK_IN &&
        item.difference == '') {
      return Container();
    }
    return Container();
  }

  Widget actionBotton(TransferListDoEntity item, String title) {
    return Container(
        padding: EdgeInsets.only(
          top: 5.w,
          right: 11.w,
          bottom: 5.w,
        ),
        child: OutlineButton(
            onPressed: () {},
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.w))),
            child: Text(title)));
  }

  TransferItemModelEntity listItem(TransferListDoEntity item) {
    var listItem = TransferItemModelEntity();
    var stockOut = _transController.stockOutDeptId == -1;
    listItem.time = '#' +
        (int.parse(item.orderSerial!) % 100).toString() +
        ' ' +
        item.customizeTime!;
    listItem.orderType = item.orderType;
    listItem.status = item.status;
    listItem.deptName = stockOut
        ? ('出库方：' + item.stockOutDeptName!)
        : ('入库方：' + item.stockInDeptName!);
    String remark = '';
    if (item.remarks != null) {
      for (var remarkItem in item.remarks!) {
        if (remark.length > 0) {
          remark = remark + '\n';
        }
        remark = remark + remarkItem.createdByName! + ':' + remarkItem.remark!;
      }
    }
    listItem.remarks = remark;
    listItem.difference = item.difference;

    var name = item.storeCustomer!.customerName;
    if (name!.length > 7) {
      name = name.substring(0, 6) + '...';
    }
    listItem.orderInfo = '销售单：' +
        name +
        '  ' +
        '#' +
        item.orderSaleSerial!.substring(6) +
        '  ' +
        item.customizeTime!.substring(0, 10);

    List<String> actions = [];
    // 调入
    if (_transController.stockOutDeptId == -1) {
      // 待入库（已出待收）
      if (item.status! == TransferStatusEnum.WAIT_STOCK_IN) {
        actions = ['先入库'];
      } else if (item.status! == TransferStatusEnum.STOCK_IN) {
        //已入库（已收货）
        //无差异
        if (item.difference == 'NO_DIFFERENCE') {
          actions = ['修改入库数', '仅完成', '完成并发货'];
        } else {
          //有差异
          actions = ['修改入库数'];
        }
      } else {}
    } else {
      // 调出
      // 待出库（已出待收）
      if (item.status! == TransferStatusEnum.WAIT_STOCK_OUT) {
        actions = ['修改出库数'];
      } else if (item.status! == TransferStatusEnum.WAIT_STOCK_IN) {
        actions = ['修改出库数'];
      } else if (item.status! == TransferStatusEnum.STOCK_IN) {
        //已入库（已收货）
        actions = ['修改出库数'];
      } else {}
    }
    listItem.actions = actions;

    String countInfo = '';
    if (item.stockInStyleNum.toString() != '0') {
      countInfo = '出库' +
          item.stockOutStyleNum.toString() +
          '款' +
          item.stockOutNum.toString() +
          '入库' +
          item.stockInStyleNum.toString() +
          '款' +
          item.stockInNum.toString();
    } else {
      countInfo = '出库' +
          item.stockOutStyleNum.toString() +
          '款' +
          item.stockOutNum.toString();
    }

    listItem.numInfo = countInfo;

    return listItem;
  }
}

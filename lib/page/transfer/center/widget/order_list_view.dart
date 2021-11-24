import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/transfer/center/controller/transfer_center_controller.dart';
import 'package:haidai_flutter_module/page/transfer/center/widget/transfer_center_list.dart';
import 'package:haidai_flutter_module/page/transfer/center/widget/transfer_order_status.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_order_type.dart';
import 'package:haidai_flutter_module/page/transfer/model/enum/transfer_status.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_count_param_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_item_model_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_list_do_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_page_param_entity.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:intl/intl.dart';

class OrderListView extends StatefulWidget {
  late final String liststatus;

  OrderListView(this.liststatus);

  @override
  _OrderListViewState createState() => _OrderListViewState(liststatus);
}

class _OrderListViewState extends State<OrderListView> {
  late final String liststatus;
  late EasyRefreshController _controller;
  late TransferCenterController _transController;
  final int stockInDeptId = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();

  var data = [];

  _OrderListViewState(this.liststatus);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _transController = Get.find<TransferCenterController>();
    _controller = EasyRefreshController();
    if (liststatus == 'DISTRIBUTION') {
      _transController.distributionCtr = _controller;
    }
    if (liststatus == 'DIRECT') {
      _transController.directCtr = _controller;
    }
    if (liststatus == 'APPLY') {
      _transController.applyCtr = _controller;
    }
    if (liststatus == 'SUBSTANDARD') {
      _transController.substandardCtr = _controller;
    }
    loadListData(refresh: true);
  }

  void loadListData({bool refresh = true}) {
    _transController.pageRefresh(liststatus, _controller, refresh: refresh);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return EasyRefresh.custom(
        enableControlFinishLoad: false,
        controller: _controller,
        header: RefreshUtils.defaultHeader(),
        footer: RefreshUtils.defaultFooter(),
        onRefresh: () async {
          _transController.pageRefresh(liststatus, _controller, refresh: true);
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 1), () {
            _transController.loadMore(liststatus, _controller);
          });
        },
        slivers: <Widget>[
          GetBuilder<TransferCenterController>(
            id: 'TransferCenterController' + liststatus,
            builder: (ctl) {
              List listData = _transController.currentData(liststatus);
              data = listData;
              if (data.length == 0) {
                return SliverToBoxAdapter(
                  child: Center(
                      child: emptyWidget(bgColor: ColorConfig.color_00000000)),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    TransferListDoEntity item = data[index];
                    TransferItemModelEntity listObj = listItem(item);
                    // GlobalKey listGlobalKey = GlobalKey();
                    return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () =>
                            _transController.toTransferDetail(item.id as int),
                        child: Container(
                          // key:listGlobalKey,
                          padding: EdgeInsets.only(left: 24.w, right: 24.w),
                          child: Column(children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                height: 64.w,
                                child: pText(listObj.time!,
                                    ColorConfig.color_999999, 24.w,
                                    textAlign: TextAlign.left)),
                            Stack(
                              children: [
                                Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.w),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(24.w),
                                  child: Column(
                                    // borderRadius: BorderRadius.circular(15),
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: pText(listObj.deptName!,
                                              ColorConfig.color_333333, 28.w,
                                              fontWeight: FontWeight.w600)),
                                      Visibility(
                                          visible: liststatus == "DISTRIBUTION",
                                          child: GestureDetector(
                                            child: Row(
                                              children: [
                                                pText(
                                                    listObj.orderInfo!,
                                                    ColorConfig.color_999999,
                                                    28.w),
                                                pImage("images/icon_goto.png",
                                                    24.w, 24.w),
                                              ],
                                            ),
                                            onTap: () {
                                              Get.toNamed(ArgUtils.map2String(
                                                  path: Routes.SALE_DETAIL,
                                                  arguments: {
                                                    Constant.ORDER_SALE_ID:
                                                        item.orderSaleId,
                                                    Constant.DEPT_ID:
                                                        ctl.stockInDeptId
                                                  }));
                                            },
                                          )),
                                      pSizeBoxH(36.w),
                                      TransferOrderStatus(
                                          orderType: item.orderType!,
                                          status: item.status!),
                                      Visibility(
                                          visible: listObj.remarks!.length > 0,
                                          child: pSizeBoxH(20.w)),
                                      Visibility(
                                          visible: listObj.remarks!.length > 0,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 6.w,
                                                left: 16.w,
                                                right: 6.w,
                                                bottom: 16.w),
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.w),
                                              color: Color(
                                                  ColorConfig.color_FAFAFA),
                                            ),
                                            child: pText(listObj.remarks!,
                                                ColorConfig.color_F3AE1F, 24.w,
                                                textAlign: TextAlign.left,
                                                maxLines: 99999),
                                          )),
                                      pSizeBoxH(42.w),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          pText(listObj.numInfo!,
                                              ColorConfig.color_333333, 32.w,
                                              textAlign: TextAlign.right,
                                              fontWeight: FontWeight.bold),
                                          Visibility(
                                            visible: listObj.difference !=
                                                'NO_DIFFERENCE',
                                            child: pContainerText(
                                                '差异',
                                                ColorConfig.color_ffffff,
                                                20.w,
                                                52.w,
                                                32.w,
                                                background:
                                                    ColorConfig.color_FF8A15,
                                                radius: 16.w),
                                          ),
                                          pSizeBoxW(10)
                                        ],
                                      ),
                                      pSizeBoxH(36.w),
                                      GetBuilder<TransferCenterController>(
                                          id: "operation" + item.id.toString(),
                                          builder: (ctl) {
                                            // return Visibility(visible: item.status != TransferStatusEnum.FINISH, child: actionButtons(item, index));
                                            return actButtons(
                                                item, listObj, index);
                                          }),
                                    ],
                                  ),
                                ),
                                Visibility(
                                    visible: item.canceled == "CANCELED",
                                    child: Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      top: 0,
                                      child: Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          Container(
                                              color: Color(
                                                  ColorConfig.color_99ffffff)),
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 24.w),
                                            child: pImage(
                                                "images/icon_canceled.png",
                                                124.w,
                                                124.w),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ]),
                          //
                        ));
                  },
                  childCount: listData.length,
                ),
              );
            },
          ),
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

  TransferItemModelEntity listItem(TransferListDoEntity item) {
    var listItem = TransferItemModelEntity();
    listItem.time = '#' +
        (int.parse(item.orderSerial!) % 100).toString() +
        ' ' +
        item.createdTime!;
    listItem.orderType = item.orderType;
    listItem.status = item.status;
    if (_transController.groupValue == 0 && liststatus == "DIRECT") {
      listItem.deptName = '出库方：' + item.stockOutDeptName!;
    } else if (_transController.groupValue == 1 && liststatus != "APPLY") {
      listItem.deptName = '入库方：' + item.stockInDeptName!;
    } else if (_transController.groupValue == 0) {
      listItem.deptName = '出库方：' + item.stockOutDeptName!;
    } else {
      listItem.deptName = '申请方：' + item.stockInDeptName!;
    }
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
    if (liststatus == "DISTRIBUTION") {
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
    } else {
      listItem.orderInfo = '';
    }

    List<String> actions = [];
    // 调入
    if (_transController.groupValue == 0) {
      // 待入库（已出待收）
      if (item.status! == TransferStatusEnum.WAIT_STOCK_IN) {
        if (liststatus == "DISTRIBUTION") {
          actions = ['先入库'];
        } else {
          actions = ['入库'];
        }
      } else if (item.status! == TransferStatusEnum.STOCK_IN) {
        //已入库（已收货）
        //无差异
        if (item.difference == 'NO_DIFFERENCE') {
          if (liststatus == "DISTRIBUTION") {
            actions = ['修改入库数', '仅完成', '完成并发货'];
          } else {
            actions = ['修改入库数', '仅完成'];
          }
        } else {
          //有差异
          actions = ['修改入库数'];
        }
      } else {}
    } else {
      // 调出
      // 待出库（已出待收）
      if (item.status! == TransferStatusEnum.WAIT_STOCK_OUT) {
        if (liststatus == "APPLY") {
          actions = ['出库'];
        } else {
          actions = ['修改出库数'];
        }
      } else if (item.status! == TransferStatusEnum.WAIT_STOCK_IN) {
        actions = ['修改出库数'];
      } else if (item.status! == TransferStatusEnum.STOCK_IN) {
        //已入库（已收货）
        actions = ['修改出库数'];
      } else {}
    }
    listItem.actions = actions;

    String countInfo = '';
    if (liststatus == "APPLY") {
      if (item.status! == TransferStatusEnum.WAIT_STOCK_OUT ||
          item.status! == TransferStatusEnum.WAIT_STOCK_IN) {
        countInfo = '申请' +
            item.applyStyleNum.toString() +
            '款' +
            item.applyNum.toString();
      } else if (item.status! == TransferStatusEnum.FINISH) {
        countInfo = '申请' +
            item.applyStyleNum.toString() +
            '款' +
            item.applyNum.toString() +
            '出库' +
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
            item.stockOutNum.toString() +
            '入库' +
            item.stockInStyleNum.toString() +
            '款' +
            item.stockInNum.toString();
      }
    } else if (item.status! == TransferStatusEnum.WAIT_STOCK_OUT ||
        item.status! == TransferStatusEnum.WAIT_STOCK_IN) {
      countInfo = '出库' +
          item.stockOutStyleNum.toString() +
          '款' +
          item.stockOutNum.toString();
    } else {
      countInfo = '出库' +
          item.stockOutStyleNum.toString() +
          '款' +
          item.stockOutNum.toString() +
          '入库' +
          item.stockInStyleNum.toString() +
          '款' +
          item.stockInNum.toString();
    }
    listItem.numInfo = countInfo;

    return listItem;
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
        if (actionTitle == "修改出库数") {
          if (item.orderType == TransferOrderTypeEnum.DIRECT) {
            actions.add(actionButton(
                item,
                actionTitle,
                () => _transController.toTransferCreateOrUpdate(
                    transfer: item, showAllSku: true)));
          } else {
            actions.add(actionButton(
                item,
                actionTitle,
                () =>
                    _transController.toTransferCreateOrUpdate(transfer: item)));
          }
        } else {
          actions.add(actionButton(item, actionTitle,
              () => _transController.toTransferCreateOrUpdate(transfer: item)));
        }
      }
    } //
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: actions);
  }
}

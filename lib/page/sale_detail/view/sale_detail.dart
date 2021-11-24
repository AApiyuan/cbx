import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/dept_config_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale_detail/controller/sale_detail_controller.dart';
import 'package:haidai_flutter_module/page/sale_detail/widget/customer.dart';
import 'package:haidai_flutter_module/page/sale_detail/widget/order_check.dart';
import 'package:haidai_flutter_module/page/sale_detail/widget/order_operation.dart';
import 'package:haidai_flutter_module/page/sale_detail/widget/order_price.dart';
import 'package:haidai_flutter_module/page/sale_detail/widget/return_goods_list_widget.dart';
import 'package:haidai_flutter_module/page/sale_detail/widget/return_goods_statistic.dart';
import 'package:haidai_flutter_module/page/sale_detail/widget/return_owe_list_widget.dart';
import 'package:haidai_flutter_module/page/sale_detail/widget/return_owe_statistic.dart';
import 'package:haidai_flutter_module/page/sale_detail/widget/sale_goods_list_widget.dart';
import 'package:haidai_flutter_module/page/sale_detail/widget/sale_goods_statistic.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class SaleDetail extends GetView<SaleDetailController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: GetBuilder<SaleDetailController>(builder: (ctl) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: Color(ColorConfig.color_ffffff),
        appBar: pAppBar("单据详情", back: true, type: 0, actions: [
          IconButton(
              icon: Container(
                padding: EdgeInsets.only(top: 5.w),
                child: Column(
                  children: [
                    pImage("images/icon_print.png", 29.w, 28.w),
                    pText("打印", ColorConfig.color_333333, 16.w)
                  ],
                ),
              ),
              onPressed: () {
                //处理打印
                MethodChannel(ChannelConfig.flutterToNative).invokeMethod(
                  ChannelConfig.methodPrintSale,
                  ctl.saleOrder?.id,
                );
              }),
          pSizeBoxW(20.w),
          IconButton(
              icon: Container(
                padding: EdgeInsets.only(top: 5.w),
                child: Column(
                  children: [
                    pImage("images/more1.png", 29.w, 28.w),
                    pText("更多", ColorConfig.color_333333, 16.w)
                  ],
                ),
              ),
              onPressed: () {
                showMenu(
                  context: context,
                  items: <PopupMenuEntry>[
                    //items 子项
                    PopupMenuItem(
                        value: '1',
                        padding: EdgeInsets.only(left: 20.w),
                        height: 100.w,
                        child: pText(
                          '复制',
                          ColorConfig.color_ffffff,
                          32.w,
                          width: 140.w,
                        )),
                    PopupMenuItem(
                      padding: EdgeInsets.only(left: 20.w),
                      value: '2',
                      height: 100.w,
                      child: pText('撤销', ColorConfig.color_ffffff, 32.w,
                          width: 140.w),
                    ),
                    PopupMenuItem(
                      value: '3',
                      padding: EdgeInsets.only(left: 20.w),
                      height: 100.w,
                      child: pText('分享', ColorConfig.color_ffffff, 32.w,
                          width: 140.w),
                    ),
                    PopupMenuItem(
                      value: '4',
                      padding: EdgeInsets.only(left: 20.w),
                      height: 100.w,
                      child: pText('操作记录', ColorConfig.color_ffffff, 32.w,
                          width: 140.w),
                    ),
                    PopupMenuItem(
                      value: '5',
                      padding: EdgeInsets.only(left: 20.w),
                      height: 100.w,
                      child: pText('分享图片', ColorConfig.color_ffffff, 32.w,
                          width: 140.w),
                    )
                  ],
                  color: Color(ColorConfig.color_333333),
                  position: RelativeRect.fromLTRB(200.w, 180.w, 24.w, 200.w),
                ).then((value) {
                  if (value == '1') {
                    //复制
                    if (ctl.hasSaleGoods()) {
                      Get.offNamed(ArgUtils.map2String(
                        path: Routes.SALE_ENTER,
                        arguments: {
                          Constant.DEPT_ID: ctl.saleOrder?.deptId,
                          SaleEnterController.COPY_ORDER_SALE_ID:
                              ctl.saleOrder?.id,
                        },
                      ));
                    } else {
                      toastMsg("没有销售货品不能复制");
                    }
                  } else if (value == '2') {
                    //撤销
                    cancel(ctl);
                  } else if (value == '3') {
                    //分享
                    MethodChannel(ChannelConfig.flutterToNative).invokeMethod(
                        ChannelConfig.methodShareSale,
                        jsonEncode(ctl.saleOrder));
                  } else if (value == '4') {
                    //撤销
                    Map<String, dynamic> param = new Map();
                    param[Constant.ORDER_SALE_ID] = ctl.saleOrder!.id;
                    param[Constant.DEPT_ID] = ctl.deptId;
                    Get.toNamed(ArgUtils.map2String(
                        path: Routes.SALE_OPERATION, arguments: param));
                  } else if (value == '5') {
                    //撤销
                    Map<String, dynamic> param = new Map();
                    param[Constant.ORDER_SALE_ID] = ctl.saleOrder!.id;
                    param[Constant.DEPT_ID] = ctl.deptId;
                    Get.toNamed(ArgUtils.map2String(
                        path: Routes.SALE_SHARE, arguments: param));
                  }
                });
              }),
          pSizeBoxW(40.w)
        ]),
        body: GetBuilder<SaleDetailController>(
          builder: (ctl) {
            return FutureBuilder(
                future: ctl.init(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Color(ColorConfig.color_ffffff));
                  } else {
                    if (ctl.saleOrder == null) {
                      return emptyWidget();
                    }
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: customer(),
                        ),
                        SliverToBoxAdapter(
                          child: orderPrice(),
                        ),
                        SliverToBoxAdapter(
                          child: orderCheck(),
                        ),
                        saleGoodsStatistic(),
                        SaleGoodsListWidget(),
                        returnOweStatistic(),
                        ReturnOwesListWidget(),
                        returnGoodsStatistic(),
                        ReturnGoodsListWidget(),
                        SliverToBoxAdapter(child: pSizeBoxH(140))
                      ],
                    );
                  }
                });
          },
          id: "orderDetail",
        ),
        bottomSheet: orderOperation(),
      ));
    }), onWillPop: () {
      BackUtils.back();
      return new Future.value(false);
    });
  }
}

//撤销
cancel(SaleDetailController ctl) async {
  if (!await DeptConfigUtils.checkOrderTime(DeptConfigUtils.ORDER_SALE_EDIT_1, ctl.saleOrder!.customizeTime!)) {
    toastMsg("不能撤销\n已超店铺设置的可编辑天数");
    return;
  }
  if (ctl.saleOrder!.canceled == CanceledEnum.CANCELED) {
    toastMsg("单据已撤销");
    return;
  }
  SaleApi.checkCanceledSale(ctl.saleOrder!.id as int).then((v) {
    if (!v.hasDeliverySale! &&
        !v.hasSale! &&
        !v.hasStoreCustomerBalanceChange!) {
      //直接撤销
      showDialog(
          context: Get.context as BuildContext,
          builder: (_) {
            return CustomDialog(
              type: 1,
              confirmContent: "确定撤销",
              confirmTextColor: ColorConfig.color_1678ff,
              content: pText("确定撤销吗？", ColorConfig.color_333333, 32.w,
                  fontWeight: FontWeight.w600),
              confirmCallback: (value) {
                SaleApi.canceledSale(ctl.saleOrder!.id as int,
                        showLoading: true)
                    .then((v) {
                  if (v) {
                    ctl.saleOrder!.canceled = CanceledEnum.CANCELED;
                    ctl.update(["cancelIcon"]);
                  }
                });
              },
            );
          });
    } else if (v.hasSale!) {
      toastMsg("该单有退欠货，不能撤销");
    } else {
      showDialog(
          context: Get.context as BuildContext,
          builder: (_) {
            return CustomDialog(
              title: '提示',
              type: 1,
              confirmContent: "确定撤销",
              confirmTextColor: ColorConfig.color_1678ff,
              content: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    pImage("images/order_cancel_bg.png", 200.w, 150.w),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pSizeBoxH(28.w),
                          pText(
                              "有以下情况需要撤销关联单据", ColorConfig.color_333333, 28.w),
                          pSizeBoxH(36.w),
                          Visibility(
                            visible: v.hasStoreCustomerBalanceChange!,
                            child:
                                pText("· 已有核销", ColorConfig.color_ff3715, 28.w),
                          ),
                          pSizeBoxH(24.w),
                          Visibility(
                              visible: v.hasDeliverySale!,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pText(
                                      "· 已发货", ColorConfig.color_ff3715, 28.w),
                                  pSizeBoxH(24.w),
                                  pText("只从发货单移除该销售单的货品",
                                      ColorConfig.color_999999, 28.w),
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              confirmCallback: (value) {
                SaleApi.canceledSale(ctl.saleOrder!.id as int,
                        showLoading: true)
                    .then((v) {
                  if (v) {
                    ctl.saleOrder!.canceled = CanceledEnum.CANCELED;
                    ctl.update(["cancelIcon"]);
                  }
                });
              },
            );
          });
    }
  });
}

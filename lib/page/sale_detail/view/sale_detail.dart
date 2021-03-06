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
        appBar: pAppBar("????????????", back: true, type: 0, actions: [
          IconButton(
              icon: Container(
                padding: EdgeInsets.only(top: 5.w),
                child: Column(
                  children: [
                    pImage("images/icon_print.png", 29.w, 28.w),
                    pText("??????", ColorConfig.color_333333, 16.w)
                  ],
                ),
              ),
              onPressed: () {
                //????????????
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
                    pText("??????", ColorConfig.color_333333, 16.w)
                  ],
                ),
              ),
              onPressed: () {
                showMenu(
                  context: context,
                  items: <PopupMenuEntry>[
                    //items ??????
                    PopupMenuItem(
                        value: '1',
                        padding: EdgeInsets.only(left: 20.w),
                        height: 100.w,
                        child: pText(
                          '??????',
                          ColorConfig.color_ffffff,
                          32.w,
                          width: 140.w,
                        )),
                    PopupMenuItem(
                      padding: EdgeInsets.only(left: 20.w),
                      value: '2',
                      height: 100.w,
                      child: pText('??????', ColorConfig.color_ffffff, 32.w,
                          width: 140.w),
                    ),
                    PopupMenuItem(
                      value: '3',
                      padding: EdgeInsets.only(left: 20.w),
                      height: 100.w,
                      child: pText('??????', ColorConfig.color_ffffff, 32.w,
                          width: 140.w),
                    ),
                    PopupMenuItem(
                      value: '4',
                      padding: EdgeInsets.only(left: 20.w),
                      height: 100.w,
                      child: pText('????????????', ColorConfig.color_ffffff, 32.w,
                          width: 140.w),
                    ),
                    PopupMenuItem(
                      value: '5',
                      padding: EdgeInsets.only(left: 20.w),
                      height: 100.w,
                      child: pText('????????????', ColorConfig.color_ffffff, 32.w,
                          width: 140.w),
                    )
                  ],
                  color: Color(ColorConfig.color_333333),
                  position: RelativeRect.fromLTRB(200.w, 180.w, 24.w, 200.w),
                ).then((value) {
                  if (value == '1') {
                    //??????
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
                      toastMsg("??????????????????????????????");
                    }
                  } else if (value == '2') {
                    //??????
                    cancel(ctl);
                  } else if (value == '3') {
                    //??????
                    MethodChannel(ChannelConfig.flutterToNative).invokeMethod(
                        ChannelConfig.methodShareSale,
                        jsonEncode(ctl.saleOrder));
                  } else if (value == '4') {
                    //??????
                    Map<String, dynamic> param = new Map();
                    param[Constant.ORDER_SALE_ID] = ctl.saleOrder!.id;
                    param[Constant.DEPT_ID] = ctl.deptId;
                    Get.toNamed(ArgUtils.map2String(
                        path: Routes.SALE_OPERATION, arguments: param));
                  } else if (value == '5') {
                    //??????
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

//??????
cancel(SaleDetailController ctl) async {
  if (!await DeptConfigUtils.checkOrderTime(DeptConfigUtils.ORDER_SALE_EDIT_1, ctl.saleOrder!.customizeTime!)) {
    toastMsg("????????????\n????????????????????????????????????");
    return;
  }
  if (ctl.saleOrder!.canceled == CanceledEnum.CANCELED) {
    toastMsg("???????????????");
    return;
  }
  SaleApi.checkCanceledSale(ctl.saleOrder!.id as int).then((v) {
    if (!v.hasDeliverySale! &&
        !v.hasSale! &&
        !v.hasStoreCustomerBalanceChange!) {
      //????????????
      showDialog(
          context: Get.context as BuildContext,
          builder: (_) {
            return CustomDialog(
              type: 1,
              confirmContent: "????????????",
              confirmTextColor: ColorConfig.color_1678ff,
              content: pText("??????????????????", ColorConfig.color_333333, 32.w,
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
      toastMsg("?????????????????????????????????");
    } else {
      showDialog(
          context: Get.context as BuildContext,
          builder: (_) {
            return CustomDialog(
              title: '??????',
              type: 1,
              confirmContent: "????????????",
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
                              "???????????????????????????????????????", ColorConfig.color_333333, 28.w),
                          pSizeBoxH(36.w),
                          Visibility(
                            visible: v.hasStoreCustomerBalanceChange!,
                            child:
                                pText("?? ????????????", ColorConfig.color_ff3715, 28.w),
                          ),
                          pSizeBoxH(24.w),
                          Visibility(
                              visible: v.hasDeliverySale!,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pText(
                                      "?? ?????????", ColorConfig.color_ff3715, 28.w),
                                  pSizeBoxH(24.w),
                                  pText("??????????????????????????????????????????",
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/delivery_detail/controller/delivery_detail_controller.dart';
import 'package:haidai_flutter_module/page/delivery_detail/widget/delivery_customer.dart';
import 'package:haidai_flutter_module/page/delivery_detail/widget/delivery_goods_list_widget.dart';
import 'package:haidai_flutter_module/page/delivery_detail/widget/delivery_order_info.dart';
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

class DeliveryDetail extends GetView<DeliveryDetailController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: GetBuilder<DeliveryDetailController>(builder: (ctl) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: Color(ColorConfig.color_ffffff),
        appBar: pAppBar("单据详情", back: true, type: 0, actions: [
          IconButton(
              icon: Container(
                padding: EdgeInsets.only(top: 5.w),
                child: Column(
                  children: [pImage("images/icon_print.png", 29.w, 28.w), pText("打印", ColorConfig.color_333333, 16.w)],
                ),
              ),
              onPressed: () {
                //处理打印
                MethodChannel(ChannelConfig.flutterToNative).invokeMethod(
                  ChannelConfig.methodPrintDelivery,
                  ctl.saleOrder?.id,
                );
              }),
          pSizeBoxW(40.w)
        ]),
        body: GetBuilder<DeliveryDetailController>(
          builder: (ctl) {
            return FutureBuilder(
                future: ctl.init(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // return pText("text", ColorConfig.color_C280FF, 35.w);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(width: double.infinity, height: double.infinity, color: Color(ColorConfig.color_ffffff));
                  } else {
                    if (ctl.saleOrder == null) {
                      return emptyWidget();
                    }
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: DeliveryCustomer(),
                        ),
                        SliverToBoxAdapter(
                          child: DeliveryorderInfo(context),
                        ),
                        DeliveryGoodsListWidget(),

                        // saleGoodsStatistic(),

                        // returnOweStatistic(),
                        // ReturnOwesListWidget(),
                        // returnGoodsStatistic(),
                        // ReturnGoodsListWidget(),
                        SliverToBoxAdapter(child: pSizeBoxH(130))
                      ],
                    );
                  }
                });
          },
          id: "orderDetail",
        ),
        // bottomSheet: orderOperation(),
      ));

    }), onWillPop: () {
      BackUtils.back();
      return new Future.value(false);
    });
  }
}



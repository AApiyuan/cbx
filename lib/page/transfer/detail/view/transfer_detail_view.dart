import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/page/transfer/detail/controller/transfer_detail_controller.dart';
import 'package:haidai_flutter_module/page/transfer/detail/widget/goods_list_widget.dart';
import 'package:haidai_flutter_module/page/transfer/detail/widget/operation_record.dart';
import 'package:haidai_flutter_module/page/transfer/detail/widget/orderStatus.dart';
import 'package:haidai_flutter_module/page/transfer/detail/widget/orderTitle.dart';
import 'package:haidai_flutter_module/page/transfer/detail/widget/order_remark.dart';
import 'package:haidai_flutter_module/page/transfer/detail/widget/static_title.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransferDetailView extends GetView<TransferDetailController> {
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<TransferDetailController>(
        id: "TransferPage",
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
                  return Scaffold(
                    backgroundColor: Color(ColorConfig.color_ffffff),
                    appBar:
                        pAppBar(ctl.barTitle, back: true, type: 0, actions: [
                      IconButton(
                          icon: Container(
                            padding: EdgeInsets.only(top:5.w),
                            child: Column(
                              children: [
                                pImage("images/icon_print.png", 30.w, 30.w),
                                pText("打印", ColorConfig.color_333333, 16.w)
                              ],
                            ),
                          ),
                          onPressed: () {
                            MethodChannel(ChannelConfig.flutterToNative)
                                .invokeMethod(
                                    ChannelConfig.methodPrintTransfer, {
                              "orderId": ctl.orderTransferId,
                            });
                          }),
                      pSizeBoxW(40.w)
                    ]),
                    body:
                    CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: orderTitle(),
                        ),
                        SliverToBoxAdapter(
                          child: orderRemark(),
                        ),
                        SliverToBoxAdapter(
                          child: orderStatus(),
                        ),
                        SliverToBoxAdapter(
                          child: operationRecord(),
                        ),
                        SliverToBoxAdapter(
                          child: staticTitle(),
                        ),
                        GoodsListWidget()
                      ],
                    )
                  );
                }
              });
        });
  }
}

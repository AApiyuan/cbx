import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/model/enum/remit_type.dart';
import 'package:haidai_flutter_module/page/gathering_detail/controller/gathering_detail_controller.dart';
import 'package:haidai_flutter_module/page/gathering_detail/widget/customer.dart';
import 'package:haidai_flutter_module/page/gathering_detail/widget/gathering_method.dart';
import 'package:haidai_flutter_module/page/gathering_detail/widget/order_check.dart';
import 'package:haidai_flutter_module/page/gathering_detail/widget/verification.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GatheringDetail extends GetView<GatheringDetailController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GetBuilder<GatheringDetailController>(
        builder: (ctl) => SafeArea(
          child: Scaffold(
            backgroundColor: Color(ColorConfig.color_ffffff),
            appBar: titleBar(),
            body: FutureBuilder(
              future: ctl.init(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Color(ColorConfig.color_ffffff),
                  );
                } else {
                  if (ctl.remitDetail == null || ctl.customer == null) {
                    return emptyWidget();
                  }
                  return CustomScrollView(
                    slivers: <Widget>[
                      line(),
                      SliverToBoxAdapter(child: customer()),
                      line(),
                      SliverToBoxAdapter(child: orderCheck()),
                      visibility(line(),
                          RemitTypeEnum.WRITE_OFF != ctl.remitDetail?.type),
                      visibility(GatheringMethod(),
                          RemitTypeEnum.WRITE_OFF != ctl.remitDetail?.type),
                      line(),
                      Verification(),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
      onWillPop: () {
        BackUtils.back();
        return new Future.value(false);
      },
    );
  }

  visibility(Widget widget, bool visible) {
    return SliverVisibility(sliver: widget, visible: visible);
  }

  line() {
    return SliverToBoxAdapter(
      child: Container(
        color: Color(ColorConfig.color_f5f5f5),
        height: 16.w,
      ),
    );
  }

  titleBar() {
    return pAppBar(
      "",
      title: GetBuilder<GatheringDetailController>(
        builder: (ctl) {
          var text = "单据详情";
          switch (ctl.remitDetail?.type) {
            case RemitTypeEnum.PAYMENT:
              text = "收款记录";
              break;
            case RemitTypeEnum.REFUND:
              text = "退款记录";
              break;
            case RemitTypeEnum.WRITE_OFF:
              text = "核销记录";
              break;
          }
          return pText(
            text,
            ColorConfig.color_333333,
            34.w,
            fontWeight: FontWeight.bold,
          );
        },
        id: GatheringDetailController.idTitle,
      ),
      back: true,
      type: 0,
      actions: [
        GetBuilder<GatheringDetailController>(
          builder: (ctl) {
            return Visibility(
              child: IconButton(
                icon: Container(
                  padding: EdgeInsets.only(top: 5.w),
                  child: Column(
                    children: [
                      pImage("images/icon_print.png", 30.w, 30.w),
                      pText("打印", ColorConfig.color_333333, 16.w)
                    ],
                  ),
                ),
                onPressed: () => MethodChannel(ChannelConfig.flutterToNative)
                    .invokeMethod(ChannelConfig.methodPrintGathering,
                        ctl.remitDetail?.id),
              ),
              visible: ctl.remitDetail?.type != RemitTypeEnum.WRITE_OFF,
            );
          },
          id: GatheringDetailController.idPrint,
        ),
        pSizeBoxW(20.w),
      ],
    );
  }
}

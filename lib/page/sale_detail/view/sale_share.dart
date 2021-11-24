import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/sale_detail/controller/sale_share_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class SaleShare extends GetView<SaleShareController> {
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      javaScriptEnabled: true,
    ),
    /// android 支持HybridComposition
    android: AndroidInAppWebViewOptions(initialScale: 1),

    ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true, pageZoom: Get.width / 750),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: GetBuilder<SaleShareController>(id: "webView",builder: (ctl) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: Color(ColorConfig.color_ffffff),
        appBar: pAppBar("分享单据图片", back: true, type: 0, actions: [
          pText('分享', ColorConfig.color_1678FF, 28.w, width: 70.w, onTap: () {
            if (ctl.img != null) {
              Uint8List bytes = base64.decoder
                  .convert(ctl.img!.replaceAll("data:image/png;base64,", ""));
              MethodChannel(ChannelConfig.flutterToNative)
                  .invokeMethod(ChannelConfig.methodShareSaleImg, bytes);
            } else {
              toastMsg("生成中..");
            }
          }),
          pSizeBoxW(20.w),
        ]),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: ctl.init(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Color(ColorConfig.color_ffffff));
                      } else {
                        return InAppWebView(
                            initialOptions: options,
                            onLoadStop: (c, _) {
                              if (Config.isAndroid && Config.isWebViewFirst) {
                                Config.isWebViewFirst = false;
                                ctl.update(["webView"]);
                              }
                            },
                            initialUrlRequest: URLRequest(
                                url: Uri.parse(
                                    "${Config.WEB_URL}/mini-app?deptId=${ctl.deptId}&saleId=${ctl.orderSaleId}&token=${ctl.accessToken}")),
                            onWebViewCreated:
                                (InAppWebViewController controller) {
                              controller.addJavaScriptHandler(
                                  handlerName: 'share',
                                  callback: (args) {
                                    ctl.img = args[0];
                                  });
                            });
                      }
                    }))
          ],
        ),
      ));
    }), onWillPop: () {
      BackUtils.back();
      return new Future.value(false);
    });
  }
}

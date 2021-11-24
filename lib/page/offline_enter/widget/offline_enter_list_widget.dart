import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/offline_enter/controller/offline_enter_controller.dart';
import 'package:haidai_flutter_module/page/transfer/detail/controller/transfer_detail_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';


class OfflineEnterListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return goodsListWidget();
  }

  Widget goodsListWidget() {
    return GetBuilder<OfflineEnterController>(builder: (ctl) {
      return Expanded(
          child: Container(
              color: Color(ColorConfig.color_ffffff),
              width: Get.width,
              child: GetBuilder<OfflineEnterController>(
                id: "transferList",
                builder: (ctl) {
                  return pText('text', ColorConfig.color_ffffff, 15.w);
                },
              )));
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_sku/controller/sku_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_sku/widget/sku.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class SkuView extends GetView<SkuController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<SkuController>(
            builder: (ctl) {
              return Scaffold(
                  backgroundColor: Color(ColorConfig.color_282940),
                  appBar: pAppBar(
                    "SKU明细",
                    type: 1,
                    backIconColor: ColorConfig.color_ffffff,
                    backgroundColor: ColorConfig.color_282940,
                  ),
                  body: sku() );
            }),
        onWillPop: () {
          BackUtils.back();
          return new Future.value(false);
        });
  }
}

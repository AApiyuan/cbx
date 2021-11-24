import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/controller/goods_profile_controller.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/widget/goods_list.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsProfileView extends GetView<GoodsProfileController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<GoodsProfileController>(
            builder: (ctl) {
              return Scaffold(
                  backgroundColor: Color(ColorConfig.color_ffffff),
                  appBar: pAppBar(
                    "货品画像",
                    type: 1,
                    backIconColor: ColorConfig.color_ffffff,
                    backgroundColor: ColorConfig.color_282940,
                  ),
                  body: Container(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w),
                    color: Color(ColorConfig.color_282940),
                    child: goodsList(),
                  ));
            }),
        onWillPop: () {
          BackUtils.back();
          return new Future.value(false);
        });
  }
}

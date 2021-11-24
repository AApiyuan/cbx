import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/help/center/controller/help_center_controller.dart';
import 'package:haidai_flutter_module/page/help/center/widget/advertisement.dart';
import 'package:haidai_flutter_module/page/help/center/widget/product.dart';
import 'package:haidai_flutter_module/page/help/center/widget/title.dart';
import 'package:haidai_flutter_module/page/help/center/widget/video_title.dart';
import 'package:haidai_flutter_module/page/help/center/widget/video_list.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class HelpCenterView extends GetView<HelpCenterController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: GetBuilder<HelpCenterController>(builder: (ctl) {
      return Scaffold(
          backgroundColor: Color(ColorConfig.color_ffffff),
          body: Container(
            color: Color(ColorConfig.color_ffffff),
            child: CustomScrollView(
              slivers: [
                //头部
                SliverToBoxAdapter(child: title()),
                SliverToBoxAdapter(child: product()),
                // SliverToBoxAdapter(child: advertisement()),
                SliverToBoxAdapter(child: videoTitle()),
                videoList()
              ],
            ),
          ));
    }), onWillPop: () {
      BackUtils.back();
      return new Future.value(false);
    });
  }
}

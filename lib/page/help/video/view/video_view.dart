import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/help/video/controller/video_controller.dart';
import 'package:haidai_flutter_module/page/help/video/widget/video.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class VideoView extends GetView<VideoController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: GetBuilder<VideoController>(builder: (ctl) {
      return Scaffold(
          backgroundColor: Color(ColorConfig.color_ffffff),
          body: Container(
            color: Color(ColorConfig.color_000000),
            child: video(),
          ));
    }), onWillPop: () {
      BackUtils.back();
      return new Future.value(false);
    });
  }
}

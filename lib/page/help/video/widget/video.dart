import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/help/video/controller/video_controller.dart';
import 'package:haidai_flutter_module/page/help/video/widget/memory_player_page.dart';

Widget video() {
  return GetBuilder<VideoController>(
      id: "video",
      builder: (ctl) {
        return PageView.builder(
            controller: ctl.pageController,
            scrollDirection: Axis.vertical,
            itemCount: ctl.videos.length,
            itemBuilder: (BuildContext context, int index) {
              return MemoryPlayerPage(
                video: ctl.videos[index],
                preVideo: index != 0 ? ctl.videos[index-1] : null,
                nextVideo: index != ctl.videos.length - 1 ? ctl.videos[index + 1] : null,
              );
            });
      });
}

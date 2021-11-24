import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/help/model/res/admin_video_do.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';

class VideoController extends SuperController {
  List<AdminVideoDo> videos = [];
  var curId;
  int? index;

  PageController pageController = new PageController();

  getVideos() {
    UserApi.selectVideo().then((value) {
      videos = value;
      for (int i = 0; i < videos.length; i++) {
        if (videos[i].id == curId) {
          index = i;
        }
      }
      pageController.jumpToPage(index!);
      update(["video"]);
    });
  }

  init() {
    getVideos();
  }

  @override
  void onInit() {
    super.onInit();
    curId = ArgUtils.getArgument2num(Constant.VIDEO_ID)?.toInt();
    init();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}

import 'package:better_video_player/better_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/help/model/res/admin_video_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import 'BetterVideoPlayerControls.dart';

// ignore: must_be_immutable
class MemoryPlayerPage extends StatefulWidget {
  AdminVideoDo video;
  AdminVideoDo? preVideo;
  AdminVideoDo? nextVideo;

  MemoryPlayerPage(
      {Key? key, required this.video, this.preVideo, this.nextVideo});

  @override
  _MemoryPlayerPageState createState() => _MemoryPlayerPageState();
}

class _MemoryPlayerPageState extends State<MemoryPlayerPage> {
  late BetterVideoPlayerController _betterPlayerController;
  // late BetterVideoPlayerDataSource _betterPlayerDataSource;

  @override
  void initState() {
    // BetterVideoPlayerConfiguration controlsConfiguration = BetterVideoPlayerConfiguration(
    //   controlBarColor: Colors.black26,
    //   iconsColor: Colors.white,
    //   playIcon: Icons.play_arrow_outlined,
    //   progressBarPlayedColor: Color(ColorConfig.color_1678ff),
    //   progressBarHandleColor: Color(ColorConfig.color_1678ff),
    //   skipBackIcon: Icons.replay_10_outlined,
    //   skipForwardIcon: Icons.forward_10_outlined,
    //   backwardSkipTimeInMilliseconds: 10000,
    //   forwardSkipTimeInMilliseconds: 10000,
    //   enableSkips: false,
    //   enableFullscreen: false,
    //   enablePip: true,
    //   enablePlayPause: true,
    //   enableMute: true,
    //   enableAudioTracks: false,
    //   enableProgressText: true,
    //   enableSubtitles: true,
    //   showControlsOnInitialize: true,
    //   enablePlaybackSpeed: true,
    //   controlBarHeight: 40,
    //   loadingColor: Colors.red,
    //   overflowModalColor: Colors.black54,
    //   overflowModalTextColor: Colors.white,
    //   overflowMenuIconsColor: Colors.white,
    // );
    // BetterVideoPlayerConfiguration betterPlayerConfiguration = BetterVideoPlayerConfiguration(
    //     autoPlay: true,
    //     controls: MyBetterVideoPlayerControls(
    //       isFullScreen: false,
    //     ));
    //
    // _betterPlayerDataSource = BetterVideoPlayerDataSource(
    //   BetterVideoPlayerDataSourceType.network,
    //   Config.CDN + widget.video.videoLdUrl!,
    // );
    _betterPlayerController = BetterVideoPlayerController();

    // _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    // _setupDataSource();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _betterPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            AspectRatio(
                aspectRatio: Get.width / (Get.height - 150.w),
                child: BetterVideoPlayer(
                  configuration: BetterVideoPlayerConfiguration(
                      autoPlay: true,
                      controls: MyBetterVideoPlayerControls(
                        isFullScreen: false,
                      )),
                  controller: _betterPlayerController,
                  dataSource: BetterVideoPlayerDataSource(
                    BetterVideoPlayerDataSourceType.network,
                    Config.CDN + widget.video.videoLdUrl!,
                  ),
                )),
            Container(
                padding: EdgeInsets.only(
                    top: 10.w, left: 24.w, right: 24.w, bottom: 30.w),
                alignment: Alignment.centerLeft,
                color: Color(ColorConfig.color_000000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pText(widget.video.title!, ColorConfig.color_ffffff, 30.w,
                        fontWeight: FontWeight.w600),
                    pSizeBoxH(10.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        pText(
                            widget.preVideo != null
                                ? "上一个 ：${widget.preVideo!.title!}"
                                : "",
                            ColorConfig.color_dcdcdc,
                            24.w,
                            width: 350.w,
                            alignment: Alignment.centerLeft),
                        pText(
                            widget.nextVideo != null
                                ? "下一个 ：${widget.nextVideo!.title!}"
                                : "",
                            ColorConfig.color_dcdcdc,
                            24.w,
                            width: 350.w,
                            alignment: Alignment.centerRight),
                      ],
                    )
                  ],
                ))
          ],
        ),
        Positioned(
            top: 80.w,
            left: 24.w,
            child: IconButton(
                iconSize: 34.w,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(ColorConfig.color_ffffff),
                ),
                onPressed: () {
                  BackUtils.back();
                }))
      ],
    );
  }
}

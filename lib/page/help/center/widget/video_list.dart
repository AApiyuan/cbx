import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/help/center/controller/help_center_controller.dart';
import 'package:haidai_flutter_module/page/help/model/res/admin_video_do.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget videoList() {
  return GetBuilder<HelpCenterController>(
      id: "video",
      builder: (ctl) {
        return SliverPadding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (ctl.videos.length == 0) {
                      return Container();
                    }
                    AdminVideoDo item = ctl.videos[index];
                    return GestureDetector(
                        onTap: () {
                          Get.toNamed(ArgUtils.map2String(path: Routes.VIDEO, arguments: {Constant.VIDEO_ID: item.id}));
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                            decoration: new BoxDecoration(
                              image: new DecorationImage(image: NetworkImage(Config.CDN + item.coverUrl!+"?x-oss-process=image/resize,w_243",),fit:BoxFit.cover),
                            ),
                            child: Column(
                              // children: [pText(item.title.toString(), ColorConfig.color_ffffff, 28.w)],
                            )));
                  },
                  childCount: ctl.videos.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2.w,
                  crossAxisSpacing: 2.w,
                  childAspectRatio: 1.33,
                )));
      });
}

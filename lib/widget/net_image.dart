import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/controller/oss_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/view_image_page.dart';

class NetImageWidget extends StatelessWidget {
  final int width;
  final int height;
  final EdgeInsetsDirectional? margin;
  final int radius;
  final String imgUrl;
  final String placeholder;
  final BoxFit fit;
  final int goodsId;
  final bool clickEnable;

  NetImageWidget(
    this.imgUrl, {
    this.width = 140,
    this.height = 140,
    this.margin,
    this.radius = 10,
    this.placeholder = "images/icon_debug_def.png",
    this.fit = BoxFit.cover,
    this.goodsId = 0,
    this.clickEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.w,
      margin: margin,
      child: GestureDetector(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius.w),
          child: GetBuilder<OssController>(
            init: OssController(),
            id: imgUrl,
            builder: (ctl) {
              if(imgUrl == "null/null"){
                return Image(
                  image: AssetImage(placeholder),
                  fit: BoxFit.contain,
                );
              }else{
              return ExtendedImage.network(
                ctl.getUrl(imgUrl),
                fit: fit,
                loadStateChanged: (state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.completed:
                      break;
                    case LoadState.failed:
                      return Image(
                        image: AssetImage(placeholder),
                        fit: BoxFit.contain,
                      );
                    case LoadState.loading:
                      return Image(
                        image: AssetImage(placeholder),
                        fit: BoxFit.contain,
                      );
                  }
                },
                mode: ExtendedImageMode.gesture,
                initGestureConfigHandler: (state) {
                  return GestureConfig(
                    minScale: 1.0,
                    maxScale: 3.0,
                    cacheGesture: false,
                  );
                },
              );}
            },
          ),
        ),
        onTap: () {
          if (clickEnable) {
            ViewImagePage.topViewImagePage(imgUrl, goodsId: goodsId);
          }
        },
      ),
    );
  }
}

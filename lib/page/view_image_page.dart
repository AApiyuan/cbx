import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';

class ViewImagePage extends StatelessWidget {
  ViewImagePage({
    Key? key,
    required this.imageUrl,
    this.goodsId,
  }) : super(key: key);

  final String imageUrl;
  final int? goodsId;

  static void topViewImagePage(
    String imageUrl, {
    int goodsId = 0,
  }) {
    /*Get.toNamed(ArgUtils.map2String(path: Routes.VIEW_IMAGE, arguments: {
      "imageUrl": imageUrl,
      "goodsId": goodsId,
    }));*/
    Get.delete<ImagePagerViewController>();
    if (Get.context != null) {
      Navigator.of(Get.context!).push(MaterialPageRoute(
          builder: (context) => ViewImagePage(
                imageUrl: imageUrl,
                goodsId: goodsId,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ImagePagerViewController(imageUrl: imageUrl, goodsId: goodsId));
    return Material(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black,
              child: GetBuilder<ImagePagerViewController>(
                id: "key_images",
                builder: (ctl) {
                  return PageView(
                    children:
                        ctl.imageUrls.map((e) => _createImageItem(e)).toList(),
                    onPageChanged: (index) => ctl.changeIndex(index),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 66.w,
            child: Container(
              width: 108.w,
              height: 108.w,
              padding: EdgeInsets.all(24.w),
              child: IconButton(
                padding: EdgeInsets.all(0.w),
                icon: Image.asset(
                  "images/del_pic.png",
                  width: 60.w,
                  height: 60.w,
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          Positioned(
            bottom: 111.w,
            right: 54.w,
            child: GetBuilder<ImagePagerViewController>(
              id: "key_index",
              builder: (ctl) {
                return Text(
                  "${ctl.index + 1}/${ctl.imageUrls.length}",
                  style: textStyle(color: ColorConfig.color_ffffff),
                );
              },
            ),
          ),
          Positioned(
            child: GestureDetector(
              child: Container(
                width: 96.w,
                height: 96.w,
                padding: EdgeInsets.all(24.w),
                child: Image(
                  image: AssetImage("images/home_pic_download.png"),
                  fit: BoxFit.contain,
                ),
              ),
              onTap: () => downloadImage(),
            ),
            bottom: 80.w,
            right: 88.w,
          ),
        ],
      ),
    );
  }

  Widget _createImageItem(String imgUrl) {
    /*return DragScaleContainer(
      doubleTapStillScale: false,
      child: NetImageWidget(
        imgUrl,
        fit: BoxFit.fitWidth,
        clickEnable: false,
      ),
    );*/
    return NetImageWidget(
      imgUrl,
      fit: BoxFit.fitWidth,
      clickEnable: false,
      radius: 0,
    );
  }

  downloadImage() {
    ImagePagerViewController controller = Get.find<ImagePagerViewController>();
    String imageUrl = controller.imageUrls[controller.index];
    MethodChannel channel = new MethodChannel(ChannelConfig.flutterToNative);
    channel.invokeMethod(ChannelConfig.methodDownloadImage, imageUrl);
  }
}

class ImagePagerViewController extends GetxController {
  final List<String> imageUrls = <String>[];
  final String imageUrl;
  final int? goodsId;

  ImagePagerViewController({
    required this.imageUrl,
    this.goodsId,
  }) : super();

  int index = 0;

  @override
  void onInit() {
    super.onInit();
    _getGoodsImages();
  }

  void _getGoodsImages() {
    imageUrls.add(imageUrl);
    if (goodsId == 0 || goodsId == null) {
      update(["key_images", "key_index"]);
      return;
    }
    GoodsApi.getGoodsImages(goodsId!).then(
      (value) {
        if (value.isNotEmpty) {
          imageUrls.clear();
          imageUrls.addAll(value);
        }
        update(["key_images", "key_index"]);
      },
      onError: (e) {
        toastMsg("$e");
      },
    );
  }

  void changeIndex(int index) {
    this.index = index;
    update(["key_index"]);
  }
}

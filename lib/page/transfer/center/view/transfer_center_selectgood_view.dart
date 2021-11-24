import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/device_utils.dart';
import 'package:haidai_flutter_module/common/utils/goods_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/transfer/center/controller/transfer_center_controller.dart';
import 'package:haidai_flutter_module/page/transfer/center/controller/transfer_center_selectgood_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_good_list_entity.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class TransferCenterSelectgoodView
    extends GetView<TransferCenterSelectGoodController> {
  final _easyRefreshController = EasyRefreshController();
  final TransferCenterController _transController =
      Get.find<TransferCenterController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          searchWidget(() {
            Get.back();
          }),
          pSizeBoxH(24.w),
          Expanded(
            child: goodsList(),
          ),

          Container(
            height: 96.w,
            child: pActionText(
                '不使用筛选', ColorConfig.color_666666, 28.w, 750.w, 96.w, () {
              _transController.selectedGoodId = null;
              _transController.update(["TransferCenterOrderListView"]);
              _transController.pageRefresh(_transController.lastListType, _transController.lastCtr, refresh: true);

              Get.back();
            }),
          )
        ],
      ),
    );
  }

  Widget searchWidget([Function? cancel]) {
    var controller = TextEditingController();
    return Container(
      margin: EdgeInsets.only(right: 24.w),
      child: Row(
        children: [
          pSizeBoxW(24.w),
          Container(
            width: (DeviceUtil.isPad()?1397.w:610.w),
            height: 64.w,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
            decoration: ShapeDecoration(
                color: Color(ColorConfig.color_efefef),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.w))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/icon_search.png",
                  width: 25.w,
                  height: 25.w,
                ),
                Expanded(
                  child: GetBuilder<TransferCenterSelectGoodController>(
                    builder: (ctl) {
                      return TextField(
                        textInputAction: TextInputAction.search,
                        controller: controller,
                        autofocus: false,
                        style: textStyle(color: ColorConfig.color_333333),
                        textAlign: TextAlign.start,
                        onChanged: (text) => ctl.updateSearchText(text),
                        onSubmitted: (text) => ctl.search(text),
                        decoration: InputDecoration(
                          hintText: "搜索品名货号",
                          contentPadding:
                              EdgeInsetsDirectional.only(start: 12.w),
                          hintStyle: textStyle(color: ColorConfig.color_999999),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GetBuilder<TransferCenterSelectGoodController>(
                  builder: (ctl) {
                    return Visibility(
                      child: InkWell(
                        child: Image.asset(
                          "images/icon_search_clear.png",
                          width: 30.w,
                          height: 30.w,
                        ),
                        onTap: () {
                          controller.clear();
                          ctl.updateSearchText("");
                        },
                      ),
                      visible: controller.text.length > 0,
                    );
                  },
                  id: 'TransferCenterSelectGoodController',
                )
              ],
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          InkWell(
            child: Container(
              width: 60.w,
              child: Text(
                "取消",
                style: textStyle(color: ColorConfig.color_666666),
              ),
            ),
            onTap: () => cancel?.call(),
          )
        ],
      ),
    );
  }

  Widget goodsList() {
    return Expanded(
      child: EasyRefresh.custom(
        slivers: [
          GetBuilder<TransferCenterSelectGoodController>(
            builder: (ctl) {
              if (ctl.goodsList.length == 0) {
                return SliverToBoxAdapter(
                  child: Center(
                      child: emptyWidget(bgColor: ColorConfig.color_00000000)),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) => listItem(_, ctl.goodsList[index]),
                  childCount: ctl.goodsList.length,
                ),
              );
            },
            id: 'TransferCenterSelectgoodListView',
          ),
        ],
        header: RefreshUtils.defaultHeader(),
        footer: RefreshUtils.defaultFooter(),
        enableControlFinishLoad: true,
        enableControlFinishRefresh: true,
        taskIndependence: true,
        onLoad: () async {
          // controller.getGoodsList(true).whenComplete(() => _easyRefreshController.finishLoad(noMore: controller.noMore, success: true));
        },
        onRefresh: () async {
          Future.wait([controller.getGoodsList(false)]).then((value) {
            _easyRefreshController.resetLoadState();
            _easyRefreshController.finishRefresh(success: true);
          });
        },
        controller: _easyRefreshController,
      ),
    );
  }

  listItem(BuildContext buildContext, TransferGoodListEntity goods) {
    return Container(
      padding: EdgeInsets.only(left: 24.w, top: 24.w),
      child: InkWell(
        onTap: () {
          _transController.selectedGoodId = goods.id;
          _transController.pageRefresh(_transController.lastListType, _transController.lastCtr, refresh: true);
          Get.back();
        },
        child: Row(
          children: [
            NetImageWidget(
              GoodsUtils.getGoodsCover(goods.imgPath, goods.cover),
              width: 56,
              height: 56,
            ),
            pSizeBoxW(10.w),
            Container(
              alignment: const Alignment(-1.0, 1.0),
              width: 600.w,
              child: pText(goods.goodsSerial! + goods.goodsName!,
                  ColorConfig.color_333333, 28.w),
            ),
          ],
        ),
      ),
    );
  }
}

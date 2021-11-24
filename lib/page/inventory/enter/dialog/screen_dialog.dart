import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/classify_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/search_screen_sort_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/classify_dialog.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

// ignore: must_be_immutable
class ScreenDialog extends Dialog {
  final _controller = Get.find<SearchScreenSortController>();
  Function(Map<String, List<int>>)? onScreenTap;
  Function? onBack;
  double top;

  ScreenDialog({this.onScreenTap, this.top = 0, this.onBack});

  @override
  Widget build(BuildContext context) {
    _controller.initScreenData();
    return Container(
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              height: top,
            ),
            behavior: HitTestBehavior.opaque,
            onTap: () => onBack?.call(),
          ),
          Expanded(
            child: _createFilterCondition(context),
          ),
          Row(
            children: [
              bottomBtn(
                ColorConfig.color_ffffff,
                "重置",
                ColorConfig.color_666666,
                () => _controller.reset(),
              ),
              bottomBtn(ColorConfig.color_efefef, "取消",
                  ColorConfig.color_1678FF, () => onBack?.call()),
              bottomBtn(
                ColorConfig.color_1678FF,
                "确定",
                ColorConfig.color_ffffff,
                () {
                  _controller.affirmSelect();
                  onScreenTap
                      ?.call(_controller.selectData ?? <String, List<int>>{});
                  // Navigator.pop(context);
                  onBack?.call();
                },
              ),
            ],
          ),
        ],
      ),
      // padding: EdgeInsetsDirectional.only(top: top),
      color: Colors.transparent,
    );
  }

  bottomBtn(int color, String text, int textColor, Function? onTap) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          height: 92.w,
          alignment: Alignment.center,
          color: Color(color),
          child: Text(text, style: textStyle(color: textColor)),
        ),
        onTap: () => onTap?.call(),
      ),
    );
  }

  Widget _createFilterCondition(BuildContext context) {
    bool brandShow = !_controller.goodsBrandEmpty;
    bool yearShow = !_controller.goodsYearEmpty;
    bool seasonShow = !_controller.goodsSeasonEmpty;
    bool labelShow = !_controller.goodsLabelEmpty;
    bool classifyShow = !_controller.goodsClassifyEmpty;
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleWidget("品牌", brandShow),
            _createConditionList(_controller.goodsBrand,
                SearchScreenSortController.bIdGoodsBrand, brandShow),
            titleWidget("年份", yearShow),
            _createConditionList(_controller.goodsYear,
                SearchScreenSortController.bIdGoodsYear, yearShow),
            titleWidget("季节", seasonShow),
            _createConditionList(_controller.goodsSeason,
                SearchScreenSortController.bIdGoodsSeason, seasonShow),
            titleWidget("货品分类", classifyShow),
            _createClassify(context, classifyShow),
            titleWidget("标签", labelShow),
            _createConditionList(_controller.goodsLabel,
                SearchScreenSortController.bIdGoodsLabel, labelShow),
          ],
        ),
      ),
    );
  }

  /// 筛选条件列表
  Widget _createConditionList(
      List<StoreDictData>? list, String conditionType, bool show) {
    return Visibility(
      child: GetBuilder<SearchScreenSortController>(
        id: conditionType,
        builder: (ctl) {
          List<Widget> children;
          if (list == null) {
            children = <Widget>[];
          } else {
            children = list
                .map((e) => _createConditionItem(e, conditionType))
                .toList();
          }
          return GridView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.only(bottom: 22.w),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220.w,
                childAspectRatio: 2.89,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 24.w,
              ),
              children: children);
        },
      ),
      visible: show,
    );
  }

  /// 筛选条件 Item
  Widget _createConditionItem(StoreDictData item, String conditionType) {
    bool selectState = _controller.hasSelect(conditionType, item.id!);
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          color: Color(selectState
              ? ColorConfig.color_E8F2FF
              : ColorConfig.color_f5f5f5),
        ),
        alignment: Alignment.center,
        child: Text(
          item.dictName!,
          style: textStyle(
              size: 24,
              bold: selectState,
              color: selectState
                  ? ColorConfig.color_1678FF
                  : ColorConfig.color_666666),
        ),
      ),
      onTap: () => _controller.saveOrRemoveSelect(conditionType, item.id!),
    );
  }

  /// 分类
  Widget _createClassify(BuildContext context, bool show) {
    return Visibility(
      child: GetBuilder<SearchScreenSortController>(
        id: SearchScreenSortController.bIdGoodsClassify,
        builder: (ctl) {
          return Container(
            padding: EdgeInsets.only(left: 30.w),
            margin: EdgeInsetsDirectional.only(bottom: 22.w),
            height: 76.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: Color(ColorConfig.color_f5f5f5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _controller.getClassifyName(),
                    style: textStyle(size: 24, color: ColorConfig.color_666666),
                  ),
                ),
                Visibility(
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(18.w, 10.w, 10.w, 10.w),
                      margin: EdgeInsets.only(right: 8.w),
                      child: Text("清除",
                          style: textStyle(
                              size: 24, color: ColorConfig.color_999999)),
                    ),
                    onTap: () => ctl.clearClassifyCondition(),
                  ),
                  visible: ctl.hasClassifyCondition(),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Row(
                      children: [
                        Text(
                          "选择",
                          style: textStyle(
                              size: 24, color: ColorConfig.color_999999),
                        ),
                        Image.asset(
                          "images/icon_goto_01.png",
                          width: 22.w,
                          height: 22.w,
                        ),
                      ],
                    ),
                  ),
                  onTap: () => _showClassifyDialog(context),
                ),
              ],
            ),
          );
        },
      ),
      visible: show,
    );
  }

  OverlayEntry? _entry;

  /// 显示分类弹窗
  void _showClassifyDialog(BuildContext context) {
    _entry = OverlayEntry(
      builder: (context) {
        Map<String, List<StoreDictData>?> classifyData = {
          ClassifyController.CLASSIFY: _controller.goodsClassify,
          ClassifyController.CLASSIFY_MIDDLE: _controller.goodsClassifyMiddle,
          ClassifyController.CLASSIFY_SMALL: _controller.goodsClassifySmall,
        };
        return ClassifyDialog(
          classifyData,
          big: _controller
              .getClassifySelect(SearchScreenSortController.bIdGoodsClassify),
          middle: _controller.getClassifySelect(
              SearchScreenSortController.bIdGoodsClassifyMiddle),
          small: _controller.getClassifySelect(
              SearchScreenSortController.bIdGoodsClassifySmall),
          onClassifyTap: (classifyData) =>
              _controller.saveClassifySelect(classifyData),
          onClose: () => hideDialog(),
        );
      },
    );
    Overlay.of(context)?.insert(_entry!);

    // showGeneralDialog(
    //   context: context,
    //   pageBuilder: (BuildContext buildContext, Animation<double> animation,
    //       Animation<double> secondaryAnimation) {
    //     Map<String, List<StoreDictData>?> classifyData = {
    //       ClassifyController.CLASSIFY: _controller.goodsClassify,
    //       ClassifyController.CLASSIFY_MIDDLE: _controller.goodsClassifyMiddle,
    //       ClassifyController.CLASSIFY_SMALL: _controller.goodsClassifySmall,
    //     };
    //     return ClassifyDialog(classifyData,
    //         big: _controller
    //             .getClassifySelect(SearchScreenSortController.bIdGoodsClassify),
    //         middle: _controller.getClassifySelect(
    //             SearchScreenSortController.bIdGoodsClassifyMiddle),
    //         small: _controller.getClassifySelect(
    //             SearchScreenSortController.bIdGoodsClassifySmall),
    //         onClassifyTap: (classifyData) =>
    //             _controller.saveClassifySelect(classifyData));
    //   },
    //   barrierDismissible: true,
    //   barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    //   barrierColor: Colors.black87,
    //   // 自定义遮罩颜色
    //   transitionDuration: const Duration(milliseconds: 300),
    //   transitionBuilder: _buildMaterialDialogTransitions,
    // );
  }

  bool hideDialog() {
    print("flutter_tag===========hideDialog=====$_entry");
    if (_entry == null) {
      return false;
    } else {
      _entry?.remove();
      _entry = null;
      return true;
    }
  }

  /// 平移动画
  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    var begin = Offset(0, 1);
    var end = Offset.zero;
    var curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(
      child: child,
      position: offsetAnimation,
    );
  }

  titleWidget(String title, bool show) {
    return Visibility(
      child: Container(
        child: Text(
          title,
          style: textStyle(bold: true),
        ),
        padding: EdgeInsetsDirectional.only(
          start: 4.w,
          top: 24.w,
          bottom: 22.w,
        ),
      ),
      visible: show,
    );
  }
}

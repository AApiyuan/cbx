import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';
import 'package:haidai_flutter_module/page/inventory/difference/controller/filter_controller.dart';
import 'package:haidai_flutter_module/page/inventory/difference/widget/classify_dialog.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

// ignore: must_be_immutable
class InventoryReportFilterBar extends StatelessWidget {
  InventoryReportFilterBar(
    Key key,
    this.type, {
    this.onFilterTap,
    this.onFilterConfirmTap,
  })  : assert(onFilterConfirmTap != null),
        super(key: key);

  final VoidCallback? onFilterTap;
  final OnConfirmCallback? onFilterConfirmTap;
  final String type;
  OverlayEntry? _overlayEntry;
  double _overlayTopMargin = 0;
  bool _isShow = false;
  late FilterController _controller;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    _controller = Get.find(tag: type);
    return WillPopScope(
      child: _createContainer(),
      onWillPop: () async {
        if (_isShow) {
          _hide();
          return false;
        }
        return true;
      },
    );
  }

  Widget _createContainer() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: BorderDirectional(
          bottom: borderSide(),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _createSortItem("盘盈数", FilterController.SORT_PROFIT),
            _createSortItem("盘亏数", FilterController.SORT_LOSS),
            _createSortItem("盘点库存", FilterController.SORT_INVENTORY_STOCK),
            _createSortItem("筛选", FilterController.SORT_FILTER),
          ],
        ),
      ),
    );
  }

  Widget _createSortItem(String text, String tag) {
    return GetBuilder<FilterController>(
      tag: type,
      id: tag,
      builder: (ctl) {
        bool isSelected = _controller.hasSelectedSort(tag);
        int color =
            isSelected ? ColorConfig.color_333333 : ColorConfig.color_666666;

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: textStyle(
                    size: 24,
                    bold: isSelected,
                    color: color,
                  ),
                ),
                Image.asset(
                  _controller.getImgAsset(tag),
                  height: 26.w,
                  width: 24.w,
                )
              ],
            ),
          ),
          onTap: () {
            if (tag == FilterController.SORT_FILTER) {
              onFilterTap?.call();
              _actionFilter();
            } else {
              _controller.changeSortCondition(tag);
              onFilterConfirmTap?.call();
            }
          },
        );
      },
    );
  }

  void _actionFilter() {
    onFilterTap?.call();
    if (_isShow) {
      _hide();
      return;
    }
    _controller.init();
    Future.delayed(Duration(milliseconds: 100), _showFilter);
  }

  void _hide() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isShow = false;
    }
  }

  void _showFilter() {
    if (_isShow) {
      return;
    }
    _isShow = true;
    GlobalKey filterKey = key as GlobalKey;
    RenderBox filterBox =
        filterKey.currentContext?.findRenderObject() as RenderBox;
    _overlayTopMargin =
        filterBox.localToGlobal(Offset(0, filterBox.size.height)).dy;
    _overlayEntry = OverlayEntry(
        builder: (context) => Positioned.fill(
              child: Listener(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    margin: EdgeInsets.only(top: _overlayTopMargin),
                    color: Colors.white,
                    child: _createFilterContainer(),
                  ),
                ),
                onPointerDown: (event) {
                  if (_isShow && _overlayTopMargin > event.position.dy) {
                    _hide();
                  }
                },
              ),
            ));
    Overlay.of(_context)?.insert(_overlayEntry!);
  }

  Widget _createFilterContainer() {
    return Column(
      children: [
        Expanded(
          child: _createFilterCondition(),
        ),
        Row(
          children: [
            Expanded(
              child: FlatButton(
                height: 92.w,
                child: Text(
                  "重置",
                  style: textStyle(color: ColorConfig.color_666666),
                ),
                onPressed: () => _controller.resetCondition(),
              ),
            ),
            Expanded(
              child: FlatButton(
                height: 92.w,
                color: Color(ColorConfig.color_efefef),
                child: Text(
                  "取消",
                  style: textStyle(color: ColorConfig.color_1678FF),
                ),
                onPressed: () {
                  _hide();
                  _controller.init();
                },
              ),
            ),
            Expanded(
              child: FlatButton(
                height: 92.w,
                color: Color(ColorConfig.color_1678FF),
                child: Text(
                  "确定",
                  style: textStyle(color: ColorConfig.color_ffffff),
                ),
                onPressed: () async {
                  _hide();
                  onFilterConfirmTap?.call().whenComplete(() {
                    _controller.saveCondition();
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _createFilterCondition() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _createTitle(FilterController.CONDITION_BRAND, topPadding: 24),
            _createConditionList(
                _controller.getGoodsBrand(), FilterController.CONDITION_BRAND),
            _createTitle(FilterController.CONDITION_YEAR),
            _createConditionList(
                _controller.getGoodsYear(), FilterController.CONDITION_YEAR),
            _createTitle(FilterController.CONDITION_SEASON),
            _createConditionList(_controller.getGoodsSeason(),
                FilterController.CONDITION_SEASON),
            _createTitle(FilterController.CONDITION_CLASSIFY),
            _createClassify(),
            _createTitle(FilterController.CONDITION_LABEL),
            _createConditionList(
                _controller.getGoodsLabel(), FilterController.CONDITION_LABEL),
            SizedBox(
              height: 24.w,
            )
          ],
        ),
      ),
    );
  }

  /// 筛选条件标题
  Widget _createTitle(String title, {double topPadding = 46}) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding.w, bottom: 24.w),
      child: Text(title, style: textStyle(bold: true)),
    );
  }

  /// 分类
  Widget _createClassify() {
    return GetBuilder<FilterController>(
      id: FilterController.CLASSIFY_BAR,
      tag: type,
      builder: (ctl) {
        return Container(
          padding: EdgeInsets.only(left: 30.w),
          height: 76.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Color(ColorConfig.color_f5f5f5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  ctl.getClassCondition(),
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
                  onTap: ctl.clearClassifyCondition,
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
                onTap: () => _showClassifyDialog(),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 显示分类弹窗
  void _showClassifyDialog() {
    OverlayEntry? entry;
    entry = OverlayEntry(builder: (context) => ClassifyDialog(type, () => entry?.remove()));
    Overlay.of(_context)?.insert(entry);
    // showGeneralDialog(
    //   context: _context,
    //   pageBuilder: (BuildContext buildContext, Animation<double> animation,
    //       Animation<double> secondaryAnimation) {
    //     return ClassifyDialog(type, () {
    //       Navigator.of(buildContext).pop(true);
    //     });
    //   },
    //   barrierDismissible: true,
    //   barrierLabel: MaterialLocalizations.of(_context).modalBarrierDismissLabel,
    //   barrierColor: Colors.black87,
    //   // 自定义遮罩颜色
    //   transitionDuration: const Duration(milliseconds: 300),
    //   transitionBuilder: _buildMaterialDialogTransitions,
    // );
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

  /// 筛选条件列表
  Widget _createConditionList(List<StoreDictData> list, String conditionType) {
    return GetBuilder<FilterController>(
      tag: this.type,
      id: conditionType,
      builder: (ctl) {
        return GridView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220.w,
              childAspectRatio: 2.89,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 24.w,
            ),
            children: list
                .map((e) => _createConditionItem(e, conditionType))
                .toList());
      },
    );
  }

  /// 筛选条件 Item
  Widget _createConditionItem(StoreDictData item, String conditionType) {
    bool isSelected = _controller.isSelected(conditionType, item.id!);
    int selectedConditionCount =
        _controller.getSelectedConditionCount(conditionType);
    bool isAll = item.id == FilterController.CONDITION_ALL_ID;
    bool selectState = (selectedConditionCount > 0 && isSelected) ||
        (selectedConditionCount == 0 && isAll);
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
}

typedef OnConfirmCallback = Future<void> Function();

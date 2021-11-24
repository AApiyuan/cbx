import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/search_screen_sort_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/screen_dialog.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/sort_dialog.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

// ignore: must_be_immutable
class SearchScreenSortWidget extends StatelessWidget {
  final _controller = Get.put(SearchScreenSortController());
  Function(OrderBy)? onSortTap;
  Function(Map<String, List<int>>)? onScreenTap;
  Function(String?)? onSearchTap;
  GlobalKey _key = GlobalKey();
  OverlayEntry? _overlayEntry;
  ScreenDialog? _screenDialog;

  SearchScreenSortWidget(
      {String? sortName, this.onSortTap, this.onScreenTap, this.onSearchTap}) {
    _controller.initSort(sortName);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _key,
      children: [
        Container(
          child: Row(
            children: [
              sortWidget(context),
              screenWidget(context),
              searchTextWidget(),
            ],
          ),
          color: Colors.white,
          height: 136.w,
        ),
        GetBuilder<SearchScreenSortController>(
          id: SearchScreenSortController.bIdGoodsSearchState,
          builder: (ctl) {
            return Visibility(
              child: Container(
                child: searchWidget(),
                color: Colors.white,
                height: 136.w,
              ),
              visible: _controller.searchShow,
            );
          },
        ),
      ],
    );
  }

  searchWidget() {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsetsDirectional.only(
                start: 24.w, end: 14.w, top: 30.w, bottom: 30.w),
            padding: EdgeInsetsDirectional.only(end: 20.w),
            decoration: ShapeDecoration(
              color: Color(ColorConfig.color_efefef),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadiusDirectional.all(Radius.circular(38.w)),
              ),
            ),
            child: GetBuilder<SearchScreenSortController>(
              id: SearchScreenSortController.bIdGoodsSearch,
              builder: (ctl) {
                TextEditingController? controller =
                    _controller.searchText.length == 0
                        ? TextEditingController()
                        : null;
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        controller: controller,
                        // controller: TextEditingController.fromValue(
                        //   TextEditingValue(
                        //     text: _controller.searchText,
                        //     // 保持光标在最后
                        //     selection: TextSelection.fromPosition(
                        //       TextPosition(
                        //           affinity: TextAffinity.downstream,
                        //           offset: _controller.searchText.length),
                        //     ),
                        //   ),
                        // ),
                        autofocus: true,
                        style: textStyle(color: ColorConfig.color_999999),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: "搜索品名货号",
                          contentPadding:
                              EdgeInsetsDirectional.only(start: 20.w),
                          hintStyle: textStyle(color: ColorConfig.color_999999),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (text) => _controller.updateSearchText(text),
                        onSubmitted: (text) => onSearchTap?.call(text),
                      ),
                    ),
                    Visibility(
                      child: GestureDetector(
                        child: Icon(
                          Icons.highlight_remove,
                          size: 34.w,
                        ),
                        onTap: () => _controller.clearSearch(),
                      ),
                      visible: _controller.searchText.length > 0,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            child: Text(
              "取消",
              style: textStyle(color: ColorConfig.color_666666),
            ),
            margin: EdgeInsetsDirectional.only(end: 24.w),
          ),
          onTap: () {
            _controller.hideSearch();
            onSearchTap?.call(null);
          },
        ),
      ],
    );
  }

  sortWidget(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 24.w),
            child: GetBuilder<SearchScreenSortController>(
              builder: (ctl) {
                return Text(
                  _controller.sortName ?? "",
                  style: textStyle(bold: true),
                );
              },
              id: SearchScreenSortController.bIdSort,
            ),
          ),
          Icon(Icons.arrow_drop_down_sharp),
        ],
      ),
      onTap: () => showSortDialog(context),
    );
  }

  screenWidget(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 27.w, end: 12.w),
              child: GetBuilder<SearchScreenSortController>(
                builder: (ctl) {
                  bool isFilter = ctl.hasFilterCondition();
                  final textColor = isFilter
                      ? ColorConfig.color_333333
                      : ColorConfig.color_666666;
                  return Text(
                    "筛选",
                    style: textStyle(color: textColor, bold: isFilter),
                  );
                },
                id: SearchScreenSortController.filterData,
              ),
            ),
            Image.asset(
              "images/icon_filtrate_off.png",
              width: 32.w,
              height: 32.w,
            ),
          ],
        ),
        onTap: () => showScreenDialog(context),
      ),
    );
  }

  searchTextWidget() {
    return Container(
      alignment: Alignment.center,
      height: 76.w,
      width: 328.w,
      margin: EdgeInsetsDirectional.only(end: 24.w),
      padding: EdgeInsetsDirectional.only(start: 20.w, end: 23.w),
      decoration: ShapeDecoration(
        color: Color(ColorConfig.color_efefef),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(38.w)),
        ),
      ),
      child: GestureDetector(
        child: Row(
          children: [
            Expanded(
              child: Text(
                "搜索品名货号",
                style: textStyle(color: ColorConfig.color_999999),
              ),
            ),
            Icon(
              Icons.qr_code_scanner_outlined,
              size: 34.w,
            ),
          ],
        ),
        onTap: () => _controller.showSearch(),
      ),
    );
  }

  showSortDialog(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => SortDialog(
        _controller.sortName ?? "",
        onTap: (orderBy, name) {
          onSortTap?.call(orderBy);
          _controller.updateSort(name);
        },
        top: _getDialogTop(),
        onBack: () => hideDialog(),
      ),
    );
    Overlay.of(context)?.insert(_overlayEntry!);
    // showModalBottomSheet(
    //   context: context,
    //   builder: (context) => SortDialog(
    //     _controller.sortName ?? "",
    //     onTap: (orderBy, name) {
    //       onSortTap?.call(orderBy);
    //       _controller.updateSort(name);
    //     },
    //     top: _getDialogTop(),
    //   ),
    //   isScrollControlled: true,
    //   enableDrag: false,
    //   barrierColor: Colors.transparent,
    //   backgroundColor: Colors.transparent,
    // );
  }

  showScreenDialog(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        if (_screenDialog == null) {
          _screenDialog = ScreenDialog(
            onScreenTap: onScreenTap,
            top: _getDialogTop(),
            onBack: () => hideDialog(),
          );
        }
        return _screenDialog!;
      },
    );
    Overlay.of(context)?.insert(_overlayEntry!);
    // showModalBottomSheet(
    //   context: context,
    //   builder: (context) => ScreenDialog(
    //     onScreenTap: onScreenTap,
    //     top: _getDialogTop(),
    //   ),
    //   isScrollControlled: true,
    //   enableDrag: false,
    //   barrierColor: Colors.transparent,
    //   backgroundColor: Colors.transparent,
    //   transitionAnimationController: AnimationController(vsync: navigator!.overlay!)
    // );
  }

  bool hideDialog() {
    if (_screenDialog?.hideDialog() ?? false) {
      return true;
    } else if (_overlayEntry == null) {
      return false;
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _screenDialog = null;
      return true;
    }
  }

  double _getDialogTop() {
    var box = _key.currentContext?.findRenderObject() as RenderBox?;
    var translation = box?.getTransformTo(null).getTranslation();
    return (translation?.y ?? 0) + (box?.paintBounds.height ?? 0);
  }
}

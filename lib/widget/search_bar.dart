import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/device_utils.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final Function? cancel; //取消
  final Function(String)? onChanged; //text更新
  final Function(String)? onSubmit; //点击搜索
  final Function? onClear; //清理
  final Function(String)? onRealTime; //实时（延时500毫秒）
  final String? hintText; //提示语

  SearchBar(
      {Key? key,
      required this.hintText,
      required this.cancel,
      this.onChanged,
      this.onClear,
      this.onSubmit,
      this.onRealTime});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }

  @override
  Size get preferredSize => new Size.fromHeight(64.w);
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController controller;
  var textValue = "".obs;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return pAppBar("",
        back: false,
        type: 0,
        backFunc: widget.cancel,
        actions: [searchWidget(controller, widget.cancel)]);
  }

  Widget searchWidget(
    TextEditingController controller, [
    Function? cancel,
  ]) {
    return Container(
      padding: EdgeInsets.only(right: 24.w),
      child: Row(
        children: [
          Container(
            width: DeviceUtil.isPad() ? 1410.w : 634.w,
            height: 64.w,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
            decoration: ShapeDecoration(
              color: Color(ColorConfig.color_efefef),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/icon_search.png",
                  width: 25.w,
                  height: 25.w,
                ),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    controller: controller,
                    autofocus: true,
                    style: textStyle(color: ColorConfig.color_333333),
                    textAlign: TextAlign.start,
                    onChanged: (text) {
                      textValue.value = text;
                      widget.onChanged?.call(text);
                      _timer?.cancel();
                      _timer = Timer(Duration(milliseconds: 500),
                          () => widget.onRealTime?.call(text));
                    },
                    //ctl.updateSearchText(text),
                    onSubmitted: (text) {
                      textValue.value = text;
                      widget.onSubmit?.call(text);
                    },
                    //ctl.search(text),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      contentPadding: EdgeInsetsDirectional.only(start: 12.w),
                      hintStyle: textStyle(color: ColorConfig.color_999999),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    child: InkWell(
                      child: Image.asset(
                        "images/icon_search_clear.png",
                        width: 30.w,
                        height: 30.w,
                      ),
                      onTap: () {
                        controller.clear();
                        textValue.value = "";
                        widget.onClear?.call();
                        // ctl.updateSearchText("");
                        // if (ctl.goodsType == GoodsListController.TYPE_SALE) {
                        //   ctl.updateFilter(GoodsListController.idFilterHot);
                        // } else {
                        //   ctl.search("");
                        // }
                      },
                    ),
                    visible: textValue.value.length > 0,
                  ),
                ),
              ],
            ),
          ),
          pSizeBoxW(20.w),
          GestureDetector(
            child: pText("取消", ColorConfig.color_666666, 28.w),
            onTap: () => cancel?.call(),
          )
        ],
      ),
    );
  }
}

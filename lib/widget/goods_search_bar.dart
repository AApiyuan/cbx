import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/common/utils/device_utils.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';

import 'p_common.dart';

class GoodsSearchBar extends StatefulWidget implements PreferredSizeWidget {
  final Map<String, dynamic> param;
  final Function? backFunction;
  final Function receiveFunc;

  GoodsSearchBar(
      {Key? key,
      required this.param,
      required this.receiveFunc,
      this.backFunction});

  @override
  State<StatefulWidget> createState() {
    return _GoodsSearchBarState();
  }

  @override
  Size get preferredSize => new Size.fromHeight(64.w);
}

class _GoodsSearchBarState extends State<GoodsSearchBar> {
  @override
  Widget build(BuildContext context) {
    return pAppBar("",
        back: true,
        type: 0,
        backFunc: widget.backFunction,
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(ArgUtils.map2String(
                      path: Routes.GOODS_LIST, arguments: widget.param))
                  ?.then((value) {
                widget.receiveFunc.call(value);
              });
            },
            child: Container(
              decoration: new BoxDecoration(
                  color: Color(ColorConfig.color_f5f5f5),
                  borderRadius: new BorderRadius.circular((10.w))),
              padding: EdgeInsets.only(left: 11.w),
              margin: EdgeInsets.only(right: 24.w),
              width: DeviceUtil.isPad() ? 1436.w : 660.w,
              alignment: Alignment.centerLeft,
              child: pText("添加货品", ColorConfig.color_999999, 28.w),
            ),
          )
        ]);
  }
}

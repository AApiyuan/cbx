import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_owe_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

oweListSort(Function update) {
  return GetBuilder<BiGoodsOweController>(
    builder: (ctl) => Container(
      alignment: Alignment.center,
      height: 44.w,
      child: Row(
        children: [
          Expanded(
            child: pText(
              "序号",
              ColorConfig.color_ffffff,
              24.w,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20.w),
            ),
          ),
          pText(
            "货品",
            ColorConfig.color_ffffff,
            24.w,
            width: 228.w,
            alignment: Alignment.centerLeft,
          ),
          sortBtn("正品库存", 130.w, "stockNum", ctl, 1, update),
          sortBtn("次品库存", 130.w, "substandardNum", ctl, 1, update),
          sortBtn("欠货", 124.w, "shortageNum", ctl, 0, update),
        ],
      ),
    ),
    id: BiGoodsOweController.idOweListSort,
  );
}

sortBtn(String title, double width, String sortType, BiGoodsOweController ctl,
    int listType, Function update) {
  String image = "images/no_sort.png";
  if (sortType == ctl.sortType) {
    if (ctl.sortByDesc) {
      image = "images/down_sort.png";
    } else {
      image = "images/up_sort.png";
    }
  }
  return GestureDetector(
    child: Container(
      child: Row(
        children: [
          pText(title, ColorConfig.color_ffffff, 24.w),
          Visibility(
            child: pImage(image, 24.w, 24.w),
            visible: ctl.oweListType == listType,
          ),
        ],
      ),
      width: width,
    ),
    onTap: () {
      if (ctl.oweListType == listType) {
        update.call();
        ctl.updateOrderBy(sortType);
      }
    },
  );
}

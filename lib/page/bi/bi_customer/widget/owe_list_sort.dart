import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/controller/bi_customer_owe_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

oweListSort(Function update) {
  return GetBuilder<BiCustomerOweController>(
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
              margin: EdgeInsets.only(left: 30.w),
            ),
          ),
          pText(
            "客户",
            ColorConfig.color_ffffff,
            24.w,
            width: 168.w,
            alignment: Alignment.centerLeft,
          ),
          sortBtn("单据结欠", 140.w, "orderOweAmount", ctl, update),
          sortBtn("客户余额", 150.w, "balance", ctl, update),
          sortBtn("欠货", 130.w, "shortageNum", ctl, update),
        ],
      ),
    ),
    id: BiCustomerOweController.idOweSort,
  );
}

sortBtn(String title, double width, String sortType,
    BiCustomerOweController ctl, Function update) {
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
          pSizeBoxW(4.w),
          pImage(image, 24.w, 24.w),
        ],
      ),
      width: width,
      padding: EdgeInsets.only(left: 10.w),
    ),
    onTap: () {
      update.call();
      ctl.updateOrderBy(sortType);
    },
  );
}

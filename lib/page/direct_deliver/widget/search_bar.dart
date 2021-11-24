import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/direct_deliver/controller/direct_deliver_controller.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget searchBar() {
  return GetBuilder<DirectDeliverController>(
    builder: (controller) => GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 36.w, right: 26.w, bottom: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pImage("images/search_icon.png", 24.w, 24.w),
            pSizeBoxW(14.w),
            pText("搜索添加货品", ColorConfig.color_999999, 24.w),
          ],
        ),
        height: 64.w,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.w),
          ),
          color: Color(ColorConfig.color_efefef),
        ),
      ),
      onTap: () => Get.toNamed(ArgUtils.map2String(path: Routes.GOODS_LIST, arguments: {
        Constant.DEPT_ID: controller.deptId,
        Constant.CUSTOMER_ID: controller.customer?.id,
        Constant.GOODS_TYPE: GoodsListController.TYPE_OWE,
        Constant.SELECT_MAP: GoodsListController.map2String(controller.selectMap),
        Constant.DELIVERY_ORDER_ID: controller.orderId,
        "level": controller.customer?.levelTag,
      }))?.then((value) => controller.addGoods(value)),
    ),
  );
}

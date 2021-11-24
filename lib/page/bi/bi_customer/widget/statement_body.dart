import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/controller/bi_customer_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

statementBody() {
  return GetBuilder<BiCustomerController>(
    builder: (ctl) => SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          return item(index, ctl.statementList[index], ctl);
        },
        childCount: ctl.statementList.length,
      ),
    ),
    id: BiCustomerController.idStatement,
  );
}

item(int index, dynamic data, BiCustomerController controller) {
  int textColor = ColorConfig.color_ffffff;
  switch (index) {
    case 0:
      textColor = ColorConfig.color_FF521F;
      break;
    case 1:
      textColor = ColorConfig.color_FF9228;
      break;
    case 2:
      textColor = ColorConfig.color_FFD02E;
      break;
  }
  return GestureDetector(
    child: Container(
      child: Row(
        children: [
          Expanded(
            child: pText(
              "${index + 1}",
              textColor,
              28.w,
              padding: EdgeInsets.only(left: 30.w),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pText(
                data.customerName ?? "",
                ColorConfig.color_ffffff,
                24.w,
                width: 268.w,
                alignment: Alignment.centerLeft,
              ),
              Visibility(
                child: pSizeBoxH(15.w),
                visible: !controller.singleDept,
              ),
              Visibility(
                child: pText(
                  data.deptName ?? "",
                  ColorConfig.color_B3FFFFFF,
                  24.w,
                  width: 268.w,
                  alignment: Alignment.centerLeft,
                ),
                visible: !controller.singleDept,
              ),
            ],
          ),
          pText(
            controller.getItemLeftData(data),
            ColorConfig.color_ffffff,
            24.w,
            width: 120.w,
            alignment: Alignment.centerLeft,
          ),
          pText(
            controller.getItemRightData(data),
            ColorConfig.color_ffffff,
            24.w,
            width: 154.w,
            alignment: Alignment.centerLeft,
          ),
          pImage("images/right.png", 16.w, 16.w),
          pSizeBoxW(30.w),
        ],
      ),
      color: Color(ColorConfig.color_393a58),
      height: 124.w,
    ),
    behavior: HitTestBehavior.opaque,
    onTap: () => Get.toNamed(
      ArgUtils.map2String(
        path: Routes.CUSTOMER_PROFILE,
        arguments: {
          Constant.TOP_DEPT_ID: controller.topDeptId,
          Constant.CUSTOMER_ID: data.customerId,
          Constant.DEPT_ID: data.deptId,
          Constant.START_TIME: controller.startTime,
          Constant.END_TIME: controller.endTime,
        },
      ),
    ),
  );
}

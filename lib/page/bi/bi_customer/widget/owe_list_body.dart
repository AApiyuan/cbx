import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/controller/bi_customer_owe_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

oweListBody() {
  return GetBuilder<BiCustomerOweController>(
    builder: (ctl) => SliverList(
      delegate: SliverChildBuilderDelegate(
        (_, index) => _item(ctl, index),
        childCount: ctl.customerDataList.length,
      ),
    ),
    id: BiCustomerOweController.idOweList,
  );
}

_item(BiCustomerOweController controller, int index) {
  var data = controller.customerDataList[index];
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
                width: 168.w,
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
                  width: 168.w,
                  alignment: Alignment.centerLeft,
                ),
                visible: !controller.singleDept,
              ),
            ],
          ),
          pText(
            PriceUtils.priceString(data.orderOweAmount),
            ColorConfig.color_ffffff,
            24.w,
            width: 140.w,
            padding: EdgeInsets.only(left: 10.w),
            alignment: Alignment.centerLeft,
          ),
          pText(
            PriceUtils.priceString(data.balance),
            ColorConfig.color_ffffff,
            24.w,
            width: 150.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.w),
          ),
          pText(
            "${data.shortageNum}",
            ColorConfig.color_ffffff,
            24.w,
            width: 84.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.w),
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
            Constant.CUSTOMER_ID: data.id,
            Constant.DEPT_ID: data.deptId,
          },
        ),
      ),
  );

  // return GestureDetector(
  //   child: Container(
  //     height: 124.w,
  //     color: Color(ColorConfig.color_393a58),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: pText(
  //             "${index + 1}",
  //             textColor,
  //             28.w,
  //             margin: EdgeInsets.only(left: 30.w),
  //           ),
  //         ),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             pText(
  //               data.customerName ?? "",
  //               ColorConfig.color_ffffff,
  //               24.w,
  //               fontWeight: FontWeight.bold,
  //               alignment: Alignment.centerLeft,
  //               width: 168.w,
  //             ),
  //             Visibility(
  //               child: pSizeBoxH(15.w),
  //               visible: !controller.singleDept,
  //             ),
  //             Visibility(
  //               child: pText(
  //                 data.deptName ?? "",
  //                 ColorConfig.color_ffffff,
  //                 24.w,
  //                 fontWeight: FontWeight.bold,
  //                 alignment: Alignment.centerLeft,
  //                 width: 168.w,
  //               ),
  //               visible: !controller.singleDept,
  //             ),
  //           ],
  //         ),
  //         _text(PriceUtils.priceString(data.orderOweAmount), 140..w),
  //         _text(PriceUtils.priceString(data.balance), 150.w),
  //         _text("${data.shortageNum}", 84.w),
  //         pImage("images/right.png", 16.w, 16.w),
  //         pSizeBoxW(30.w),
  //       ],
  //     ),
  //   ),
  //   behavior: HitTestBehavior.opaque,
  //   onTap: () => Get.toNamed(
  //     ArgUtils.map2String(
  //       path: Routes.CUSTOMER_PROFILE,
  //       arguments: {
  //         Constant.TOP_DEPT_ID: controller.topDeptId,
  //         Constant.CUSTOMER_ID: data.id,
  //         Constant.DEPT_ID: data.deptId,
  //       },
  //     ),
  //   ),
  // );
}

_text(String text, double width) {
  return pText(
    text,
    ColorConfig.color_ffffff,
    24.w,
    fontWeight: FontWeight.bold,
    alignment: Alignment.centerLeft,
    width: width,
    padding: EdgeInsets.only(left: 10.w),
  );
}

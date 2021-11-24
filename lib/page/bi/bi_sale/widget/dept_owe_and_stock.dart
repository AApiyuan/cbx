import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/controller/bi_sale_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget deptOweAndStock() {
  return GetBuilder<BiSaleController>(builder: (ctl) {
    return GestureDetector(
      child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 20.w),
          padding: EdgeInsets.fromLTRB(30.w, 40.w, 30.w, 40.w),
          decoration: BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pText("欠货", 0xb3ffffff, 24.w),
                    pSizeBoxH(10.w),
                    Obx(() => pText(ctl.ownNum.value == 0 ? '--' : ctl.ownNum.value.toString(), ColorConfig.color_ffffff, 36.w)),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pText("库存/次品", 0xb3ffffff, 24.w),
                          pSizeBoxH(10.w),
                          Obx(() => pText(
                              '${ctl.stockNum.value == 0 ? '--' : ctl.stockNum.value}/${ctl.substandardNum.value == 0 ? '--' : ctl.substandardNum.value}',
                              ColorConfig.color_ffffff,
                              36.w)),
                        ],
                      ),
                      pImage("images/circle_right.png", 38.w, 38.w)
                    ],
                  ))
            ],
          )),
      onTap: () => Get.toNamed(ArgUtils.map2String(path: Routes.BI_GOODS, arguments: {
        Constant.TOP_DEPT_ID: ctl.topDeptId,
        Constant.DEPT_ID: ctl.deptId,
        Constant.TYPE: BiGoodsController.TYPE_OWE,
        Constant.END_TIME: ctl.statisticEndTime,
        Constant.START_TIME: ctl.statisticStartTime,
      })),
    );
  });
}

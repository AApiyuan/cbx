import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/controller/bi_customer_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/controller/bi_sale_detail_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget deptDetailList() {
  return GetBuilder<BiSaleDetailController>(
      id: "deptDetailList",
      builder: (ctl) {
        return Expanded(
            child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              // width: double.infinity,
              padding: EdgeInsets.only(top: 40.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      pText("${index + 1}", ColorConfig.color_ffffff, 24.w,
                          width: 34.w,
                          height: 34.w,
                          background: ColorConfig.color_FF8A15,
                          radius: 8.w,
                          margin: EdgeInsets.only(right: 10.w)),
                      pText(ctl.deptData[index].deptName.toString(), ColorConfig.color_ffffff, 34.w,
                          fontWeight: FontWeight.w600)
                    ],
                  ),
                  pSizeBoxH(14.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 218.w,
                          width: 345.w,
                          decoration: BoxDecoration(
                              color: Color(ColorConfig.color_393a58),
                              borderRadius: BorderRadius.all(Radius.circular(16.w))),
                          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 42.w, bottom: 42.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  pText("交易", ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.w600),
                                  pImage("images/circle_right.png", 38.w, 38.w)
                                ],
                              ),
                              GetBuilder<BiSaleDetailController>(
                                  id: "sale" + ctl.deptData[index].deptId.toString(),
                                  builder: (ctl) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            pText("交易数", 0xb3ffffff, 24.w),
                                            pSizeBoxH(10.w),
                                            pText(
                                                '${ctl.deptData[index].saleGoodsNum == 0 ? '--' : ctl.deptData[index].saleGoodsNum}',
                                                ColorConfig.color_ffffff,
                                                24.w),
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            pText("交易额", 0xb3ffffff, 24.w),
                                            pSizeBoxH(10.w),
                                            pText(
                                                '${ctl.deptData[index].saleTaxAmount == 0 ? '--' : PriceUtils.getPrice(ctl.deptData[index].saleTaxAmount)}',
                                                ColorConfig.color_ffffff,
                                                24.w),
                                          ],
                                        )),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                        onTap: () => Get.toNamed(ArgUtils.map2String(path: Routes.BI_DEPT_SALE, arguments: {
                          Constant.TOP_DEPT_ID: ctl.topDeptId,
                          Constant.DEPT_ID: ctl.deptData[index].deptId,
                          Constant.START_TIME: ctl.statisticStartTime,
                          Constant.END_TIME: ctl.statisticEndTime,
                        })),
                        behavior: HitTestBehavior.opaque,
                      ),
                      GestureDetector(
                        child: Container(
                          height: 218.w,
                          width: 345.w,
                          decoration: BoxDecoration(
                              color: Color(ColorConfig.color_393a58),
                              borderRadius: BorderRadius.all(Radius.circular(16.w))),
                          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 42.w, bottom: 42.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  pText("收退", ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.w600),
                                  pImage("images/circle_right.png", 38.w, 38.w)
                                ],
                              ),
                              GetBuilder<BiSaleDetailController>(
                                  id: "remit" + ctl.deptData[index].deptId.toString(),
                                  builder: (ctl) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            pText("收款", 0xb3ffffff, 24.w),
                                            pSizeBoxH(10.w),
                                            pText(
                                                '${ctl.deptData[index].receivedAmount == 0 ? '--' : PriceUtils.getPrice(ctl.deptData[index].receivedAmount)}',
                                                ColorConfig.color_ffffff,
                                                24.w),
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            pText("退款", 0xb3ffffff, 24.w),
                                            pSizeBoxH(10.w),
                                            pText(
                                                '${ctl.deptData[index].refundAmount == 0 ? '--' : PriceUtils.getPrice(ctl.deptData[index].refundAmount)}',
                                                ColorConfig.color_ffffff,
                                                24.w),
                                          ],
                                        )),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                        onTap: () => Get.toNamed(ArgUtils.map2String(path: Routes.BI_DEPT_REMIT, arguments: {
                          Constant.TOP_DEPT_ID: ctl.topDeptId,
                          Constant.DEPT_ID: ctl.deptData[index].deptId,
                          Constant.START_TIME: ctl.statisticStartTime,
                          Constant.END_TIME: ctl.statisticEndTime,
                        })),
                        behavior: HitTestBehavior.opaque,
                      ),
                    ],
                  ),
                  pSizeBoxH(14.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 218.w,
                          width: 345.w,
                          decoration: BoxDecoration(
                              color: Color(ColorConfig.color_393a58),
                              borderRadius: BorderRadius.all(Radius.circular(16.w))),
                          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 42.w, bottom: 42.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  pText("货品", ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.w600),
                                  pImage("images/circle_right.png", 38.w, 38.w)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GetBuilder<BiSaleDetailController>(
                                      id: "stock" + ctl.deptData[index].deptId.toString(),
                                      builder: (ctl) {
                                        return Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            pText("库存/次品", 0xb3ffffff, 24.w),
                                            pSizeBoxH(10.w),
                                            pText(
                                                '${ctl.deptData[index].stockNum == 0 ? '--' : ctl.deptData[index].stockNum}/${ctl.deptData[index].substandardNum == 0 ? '--' : ctl.deptData[index].substandardNum}',
                                                ColorConfig.color_ffffff,
                                                24.w),
                                          ],
                                        ));
                                      }),
                                  GetBuilder<BiSaleDetailController>(
                                      id: "shortage" + ctl.deptData[index].deptId.toString(),
                                      builder: (ctl) {
                                        return Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            pText("欠货", 0xb3ffffff, 24.w),
                                            pSizeBoxH(10.w),
                                            pText(
                                                '${ctl.deptData[index].shortageNum == 0 ? '--' : ctl.deptData[index].shortageNum}',
                                                ColorConfig.color_ffffff,
                                                24.w),
                                          ],
                                        ));
                                      })
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () => Get.toNamed(ArgUtils.map2String(path: Routes.BI_GOODS, arguments: {
                          Constant.TOP_DEPT_ID: ctl.topDeptId,
                          Constant.DEPT_ID: ctl.deptData[index].deptId,
                          Constant.END_TIME: ctl.statisticEndTime,
                          Constant.START_TIME: ctl.statisticStartTime,
                        })),
                        behavior: HitTestBehavior.opaque,
                      ),
                      GestureDetector(
                        child: Container(
                          height: 218.w,
                          width: 345.w,
                          decoration: BoxDecoration(
                              color: Color(ColorConfig.color_393a58),
                              borderRadius: BorderRadius.all(Radius.circular(16.w))),
                          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 42.w, bottom: 42.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  pText("员工", ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.w600),
                                  pImage("images/circle_right.png", 38.w, 38.w)
                                ],
                              ),
                              GetBuilder<BiSaleDetailController>(
                                  id: "member" + ctl.deptData[index].deptId.toString(),
                                  builder: (ctl) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            pText("有成交", 0xb3ffffff, 24.w),
                                            pSizeBoxH(10.w),
                                            pText(
                                                '${ctl.deptData[index].merchandiserNum == 0 ? '--' : ctl.deptData[index].merchandiserNum}',
                                                ColorConfig.color_ffffff,
                                                24.w),
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            pText("开单数", 0xb3ffffff, 24.w),
                                            pSizeBoxH(10.w),
                                            pText(
                                                '${ctl.deptData[index].orderSaleNum == 0 ? '--' : ctl.deptData[index].orderSaleNum}',
                                                ColorConfig.color_ffffff,
                                                24.w),
                                          ],
                                        )),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                        onTap: () => Get.toNamed(ArgUtils.map2String(path: Routes.BI_DEPT_USER, arguments: {
                          Constant.TOP_DEPT_ID: ctl.topDeptId,
                          Constant.DEPT_ID: ctl.deptData[index].deptId,
                          Constant.START_TIME: ctl.statisticStartTime,
                          Constant.END_TIME: ctl.statisticEndTime,
                        })),
                        behavior: HitTestBehavior.opaque,
                      ),
                    ],
                  ),
                  pSizeBoxH(14.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 218.w,
                          width: 345.w,
                          decoration: BoxDecoration(
                              color: Color(ColorConfig.color_393a58),
                              borderRadius: BorderRadius.all(Radius.circular(16.w))),
                          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 42.w, bottom: 42.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  pText("客户", ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.w600),
                                  pImage("images/circle_right.png", 38.w, 38.w)
                                ],
                              ),
                              GetBuilder<BiSaleDetailController>(
                                  id: "customer" + ctl.deptData[index].deptId.toString(),
                                  builder: (ctl) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            pText("单据结欠", 0xb3ffffff, 24.w),
                                            pSizeBoxH(10.w),
                                            pText(
                                                '${ctl.deptData[index].orderOweAmount == 0 ? '--' : PriceUtils.getPrice(ctl.deptData[index].orderOweAmount)}',
                                                ColorConfig.color_ffffff,
                                                24.w),
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            pText("客户余额", 0xb3ffffff, 24.w),
                                            pSizeBoxH(10.w),
                                            pText(
                                                '${ctl.deptData[index].balance == 0 ? '--' : PriceUtils.getPrice(ctl.deptData[index].balance)}',
                                                ColorConfig.color_ffffff,
                                                24.w),
                                          ],
                                        )),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                        ),
                        onTap: () => Get.toNamed(ArgUtils.map2String(path: Routes.BI_CUSTOMER, arguments: {
                          Constant.TOP_DEPT_ID: ctl.topDeptId,
                          Constant.DEPT_ID: ctl.deptData[index].deptId,
                          Constant.TYPE: BiCustomerController.TYPE_OWE,
                          Constant.END_TIME: ctl.statisticEndTime,
                          Constant.START_TIME: ctl.statisticStartTime,
                        })),
                        behavior: HitTestBehavior.opaque,
                      ),
                      Container(
                        height: 218.w,
                        width: 345.w,
                        decoration: BoxDecoration(
                            color: Color(ColorConfig.color_393a58),
                            borderRadius: BorderRadius.all(Radius.circular(16.w))),
                        padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 42.w, bottom: 42.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                pText("上新", ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.w600),
                                pImage("images/circle_right.png", 38.w, 38.w)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GetBuilder<BiSaleDetailController>(
                                    id: "new" + ctl.deptData[index].deptId.toString(),
                                    builder: (ctl) {
                                      return Expanded(
                                          child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          pText("货品数", 0xb3ffffff, 24.w),
                                          pSizeBoxH(10.w),
                                          pText(
                                              '${ctl.deptData[index].newSaleNum == 0 ? '--' : ctl.deptData[index].newSaleNum}',
                                              ColorConfig.color_ffffff,
                                              24.w),
                                        ],
                                      ));
                                    }),
                                Expanded(child: Column()),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: ctl.deptData.length,
        ));
      });
}

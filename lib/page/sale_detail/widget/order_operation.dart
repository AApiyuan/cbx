import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleConfigDistributionEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/dept_config_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale_detail/controller/sale_detail_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget orderOperation() {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(ColorConfig.color_ffffff),
      border: Border(
        top: BorderSide(width: 1.w, color: Color(ColorConfig.color_efefef)),
      ),
    ),
    padding: EdgeInsets.only(top: 16.w, right: 24.w, left: 24.w),
    height: 112.w,
    child: Container(
      height: 96.w,
      decoration:
          BoxDecoration(color: Color(ColorConfig.color_1678ff), borderRadius: new BorderRadius.circular((48.w))),
      child: Row(children: [
        Expanded(
          child: pText("改/退", ColorConfig.color_ffffff, 28.w, width: 230.w, height: 96.w, onTap: () {
            showCupertinoModalBottomSheet(
                context: Get.context as BuildContext,
                animationCurve: Curves.easeIn,
                builder: (context) => editDialog());
          }),
        ),
        VerticalDivider(
          indent: 34.w,
          endIndent: 34.w,
          width: 1.w,
          color: Color.fromRGBO(255, 255, 255, 0.5),
        ),
        Expanded(
          child: GetBuilder<SaleDetailController>(
            builder: (ctl) {
              return pText(
                "继续开单",
                ColorConfig.color_ffffff,
                28.w,
                width: 230.w,
                height: 96.w,
                onTap: () => Get.offNamed(
                  ArgUtils.map2String(path: Routes.SALE_ENTER, arguments: {
                    Constant.DEPT_ID: ctl.saleOrder?.deptId,
                    Constant.LIST_TYPE: SaleEnterController.LIST_TYPE_SALE,
                  }),
                ),
              );
            },
          ),
        ),
        VerticalDivider(
          indent: 34.w,
          endIndent: 34.w,
          width: 1.w,
          color: Color.fromRGBO(255, 255, 255, 0.5),
        ),
        Expanded(
          child: GetBuilder<SaleDetailController>(
            builder: (ctl) {
              return pText("去发货", ColorConfig.color_ffffff, 28.w, width: 230.w, height: 96.w, onTap: () {
                //跳转发货
                if (ctl.saleOrder?.configDistribution ==
                    EnumCoverUtils.enumsToString(SaleConfigDistributionEnum.CONFIG_DISTRIBUTION_1_1)) {
                  Map<String, dynamic> param = new Map();
                  param[Constant.ORDER_SALE_ID] = ctl.saleOrder!.id;
                  param[Constant.STOCK_IN_DEPT_ID] = ctl.saleOrder!.deptId;
                  Get.toNamed(ArgUtils.map2String(path: Routes.TRANSFER_DISTRIBUTION_RECORD, arguments: param));
                } else {
                  Get.offNamed(ArgUtils.map2String(path: Routes.DELIVER_DIRECT, arguments: {
                    Constant.ORDER_SALE_ID: ctl.orderSaleId,
                    Constant.DEPT_ID: ctl.deptId,
                    Constant.CUSTOMER_ID: ctl.saleOrder?.customerId,
                  }));
                }
              });
            },
          ),
        ),
      ]),
    ),
  );
}

Widget editDialog() {
  return GetBuilder<SaleDetailController>(builder: (ctl) {
    return BottomSheetWidget(
        title: "改/退",
        height: 1280.w,
        showCertain: false,
        child: Container(
          padding: EdgeInsets.only(top: 20.w, left: 24.w, right: 24.w),
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _editOrder(ctl),
                child: Container(
                    margin: EdgeInsets.only(bottom: 20.w),
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                        color: Color(ColorConfig.color_FAFAFA), borderRadius: new BorderRadius.circular((10.w))),
                    child: Row(
                      children: [
                        pImage("images/ic_edit_order.png", 236.w, 236.w),
                        Container(
                          padding: EdgeInsets.only(top: 33.w, left: 12.w),
                          width: 380.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              pText('编辑单据', ColorConfig.color_666666, 28.w, fontWeight: FontWeight.w600),
                              pSizeBoxH(35.w),
                              pText('直接编辑的单据数据', ColorConfig.color_999999, 24.w),
                              pSizeBoxH(15.w),
                              pText('跨天编辑会影响财务统计，请谨慎使用', ColorConfig.color_999999, 24.w,
                                  maxLines: 2, textAlign: TextAlign.left),
                            ],
                          ),
                        ),
                        pImage("images/icon_goto2.png", 44.w, 44.w),
                      ],
                    )),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  //退欠货
                  Get.offNamed(ArgUtils.map2String(
                    path: Routes.SALE_ENTER,
                    arguments: {
                      Constant.DEPT_ID: ctl.saleOrder?.deptId,
                      Constant.TYPE: SaleEnterController.TYPE_SALE,
                      Constant.CUSTOMER_ID: ctl.saleOrder?.customerId,
                      Constant.LIST_TYPE: SaleEnterController.LIST_TYPE_OWE,
                    },
                  ));
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 20.w),
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                        color: Color(ColorConfig.color_FAFAFA), borderRadius: new BorderRadius.circular((10.w))),
                    child: Row(
                      children: [
                        pImage("images/ic_change_back_order.png", 236.w, 236.w),
                        Container(
                          padding: EdgeInsets.only(top: 33.w, left: 12.w),
                          width: 380.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              pText('退欠货（未发过货的货品）', ColorConfig.color_666666, 28.w, fontWeight: FontWeight.w600),
                              pSizeBoxH(35.w),
                              pText('退完直接生成新单据', ColorConfig.color_999999, 24.w),
                              pSizeBoxH(15.w),
                              pText('单据欠货数越少，仓库不增加库存', ColorConfig.color_999999, 24.w, maxLines: 2),
                            ],
                          ),
                        ),
                        pImage("images/icon_goto2.png", 44.w, 44.w),
                      ],
                    )),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  //退实物
                  Get.offNamed(ArgUtils.map2String(
                    path: Routes.SALE_ENTER,
                    arguments: {
                      Constant.DEPT_ID: ctl.saleOrder?.deptId,
                      Constant.TYPE: SaleEnterController.TYPE_SALE,
                      Constant.CUSTOMER_ID: ctl.saleOrder?.customerId,
                      Constant.LIST_TYPE: SaleEnterController.LIST_TYPE_RETURN,
                    },
                  ));
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 20.w),
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                        color: Color(ColorConfig.color_FAFAFA), borderRadius: new BorderRadius.circular((10.w))),
                    child: Row(
                      children: [
                        pImage("images/ic_return_goods.png", 236.w, 236.w),
                        Container(
                          padding: EdgeInsets.only(top: 33.w, left: 12.w),
                          width: 380.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              pText('退实物（已发过货的货品）', ColorConfig.color_666666, 28.w, fontWeight: FontWeight.w600),
                              pSizeBoxH(35.w),
                              pText('退完生成新单据', ColorConfig.color_999999, 24.w),
                              pSizeBoxH(15.w),
                              pText('单据欠货数不变，仓库库存增加', ColorConfig.color_999999, 24.w, maxLines: 2),
                            ],
                          ),
                        ),
                        pImage("images/icon_goto2.png", 44.w, 44.w),
                      ],
                    )),
              )
            ],
          ),
        ));
  });
}

_editOrder(SaleDetailController ctl) async {
  //编辑单据
  if (!await DeptConfigUtils.checkOrderTime(DeptConfigUtils.ORDER_SALE_EDIT_1, ctl.saleOrder!.customizeTime!)) {
    toastMsg("不能编辑\n已超店铺设置的可编辑天数");
    return;
  }
  Get.offNamed(
    ArgUtils.map2String(path: Routes.SALE_ENTER, arguments: {
      Constant.DEPT_ID: ctl.saleOrder?.deptId,
      Constant.ORDER_SALE_ID: ctl.saleOrder?.id,
      Constant.CUSTOMER_ID: ctl.saleOrder?.customerId,
      Constant.LIST_TYPE: SaleEnterController.LIST_TYPE_SALE,
    }),
  )?.then((value) {
    if (value == "update") {
      ctl.updateDetail();
    }
  });
}

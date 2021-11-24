import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/help/center/controller/help_center_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget product() {
  return GetBuilder<HelpCenterController>(
      id: "product",
      builder: (ctl) {
        return Container(
          child: Column(
            children: [
              Row(
                children: [
                  productItem(ctl.base ? "images/base_select.png" : "images/base.png", "开单流程",
                      ctl.deptDetail != null ? ctl.deptDetail!.baseExpiryDate! : "开单、库存发货", ctl.base),
                  productItem(ctl.staff ? "images/staff_select.png" : "images/staff.png", "员工管理",
                      ctl.memberTime != null ? ctl.memberTime.toString() : "最大支持100人", ctl.staff),
                  productItem(ctl.offline ? "images/offline_select.png" : "images/offline.png", "断网开单",
                      ctl.deptDetail != null ? ctl.deptDetail!.offlineExpiryDate! : "断网不错失客户", ctl.offline),
                ],
              ),
              Row(
                children: [
                  productItem(ctl.bi ? "images/phone_bi_select.png" : "images/phone_bi.png", "移动报表 ",
                      ctl.deptDetail != null ? ctl.deptDetail!.appBiExpiryDate! : "分析画像一应俱全", ctl.bi),
                  productItem(ctl.bad ? "images/bad_select.png" : "images/bad.png", "次品管理",
                      ctl.deptDetail != null ? ctl.deptDetail!.substandardStockExpiryDate! : "次品数量精准管理", ctl.bad),
                  productItem(ctl.transfer ? "images/transfer_select.png" : "images/transfer.png", "调拨配货  ",
                      ctl.deptDetail != null ? ctl.deptDetail!.transferExpiryDate! : "多店调配效率翻倍", ctl.transfer),
                ],
              ),
              Row(
                children: [
                  productItem(ctl.data ? "images/data_select.png" : "images/data.png", "数据后台",
                      ctl.deptDetail != null ? ctl.deptDetail!.dataBackgroundExpiryDate! : "店铺智能数据中心", ctl.data),
                  productItem(ctl.customer ? "images/customer_select.png" : "images/customer.png", "客户报价",
                      ctl.deptDetail != null ? ctl.deptDetail!.customerQuotationExpiryDate! : "自动生成效率200", ctl.customer),
                  Container(
                      margin: EdgeInsets.only(left: 40.w, top: 10.w),
                      child: pImageButton(ctl.deptId==null?"images/to_detail.png":"images/renewal_btn.png", 168.w, 74.w, () {
                        showDialog(
                          context: Get.context!,
                          barrierDismissible: false,
                          builder: (_) => CustomDialog(
                            type: 1,
                            width: 440,
                            content: Container(
                                child: Column(
                              children: [
                                pImage("images/vxqucode.webp", 260.w, 260.w),
                                pSizeBoxH(28.w),
                                pText("微信扫码添加您的专属顾问", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                                pSizeBoxH(24.w),
                                pText("截图保存", ColorConfig.color_999999, 28.w),
                              ],
                            )),
                            isCancel: false,
                            isConfirm: false,
                          ),
                        );
                      }))
                ],
              )
            ],
          ),
        );
      });
}

Widget productItem(String icon, String title, String subTitle, bool isActive) {
  return Container(
    width: 250.w,
    height: 152.w,
    padding: EdgeInsets.all(26.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            pImage(icon, 58.w, 58.w),
            pSizeBoxW(14.w),
            pText(title, isActive ? ColorConfig.color_804904 : ColorConfig.color_c2a47f, 24.w, fontWeight: FontWeight.w600),
          ],
        ),
        pText(subTitle, isActive ? ColorConfig.color_666666 : ColorConfig.color_999999, 24.w),
      ],
    ),
  );
}

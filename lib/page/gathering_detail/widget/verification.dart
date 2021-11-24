import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/dept_config_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/gathering_detail/controller/gathering_detail_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GatheringDetailController>(
      builder: (ctl) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => index == 0 ? header(ctl) : item(ctl, index - 1),
            childCount: (ctl.remitDetail?.storeCustomerBalanceChangeLogList?.length ?? 0) + 1,
          ),
        );
      },
      id: GatheringDetailController.idVerification,
    );
  }

  item(GatheringDetailController ctl, int index) {
    var data = ctl.remitDetail?.storeCustomerBalanceChangeLogList?[index];
    var canceled = data?.canceled == CanceledEnum.CANCELED;
    return Container(
      height: 60.w,
      alignment: Alignment.center,
      child: Row(
        children: [
          pText(
            "${PriceUtils.getPrice(data?.amount?.abs())}",
            ColorConfig.color_999999,
            28.w,
            width: 176.w,
            alignment: Alignment.centerLeft,
          ),
          GestureDetector(
            child: Row(
              children: [
                pText(
                  "销售单${data?.orderSaleSerial}",
                  ColorConfig.color_999999,
                  28.w,
                  margin: EdgeInsets.only(left: 205.w),
                ),
                pImage("images/icon_goto.png", 28.w, 28.w),
              ],
            ),
            onTap: () => Get.toNamed(ArgUtils.map2String(
                path: Routes.SALE_DETAIL,
                arguments: {Constant.DEPT_ID: data?.deptId, Constant.ORDER_SALE_ID: data?.orderSaleId})),
          ),
          Expanded(child: Container()),
          Visibility(
            child: pImage("images/icon_order_cancel.png", 84.w, 50.w),
            visible: canceled,
          ),
          Visibility(
            child: GestureDetector(
              child: pText(
                "撤销",
                ColorConfig.color_1678FF,
                28.w,
              ),
              onTap: () => showBalanceCancelDialog(ctl, () => ctl.cancelOrderBalance(index)),
            ),
            visible: !canceled,
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 24.w, right: 24.w),
    );
  }

  showBalanceCancelDialog(GatheringDetailController ctl, Function function) async {
    if (!await DeptConfigUtils.checkOrderTime(DeptConfigUtils.ORDER_REMIT_EDIT_1, ctl.remitDetail!.customizeTime!)) {
      toastMsg("不能撤销\n已超店铺设置的可编辑天数");
      return;
    }
    showDialog(
      context: Get.context as BuildContext,
      barrierDismissible: false,
      builder: (_) {
        return CustomDialog(
          title: '提示',
          type: 1,
          height: 300,
          content: pText("确定撤销该记录吗？", ColorConfig.color_333333, 28.w),
          confirmCallback: (value) => function.call(),
        );
      },
    );
  }

  header(GatheringDetailController ctl) {
    return Container(
      child: Row(
        children: [
          pImage("images/icon_verification.png", 82.w, 82.w),
          pSizeBoxW(12.w),
          pText(
            "核销 ${PriceUtils.getPrice(ctl.remitDetail?.checkSaleAmount)}",
            ColorConfig.color_333333,
            34.w,
            fontWeight: FontWeight.bold,
          ),
          Expanded(child: Container()),
          pText(
            "撤销",
            ColorConfig.color_1678FF,
            24.w,
            radius: 4.w,
            borderColor: ColorConfig.color_1678FF,
            width: 120.w,
            height: 56.w,
            onTap: () => showBalanceCancelDialog(ctl, () => ctl.cancelOrderBalance(-1)),
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 24.w, top: 22.w, bottom: 28.w, right: 24.w),
    );
  }
}

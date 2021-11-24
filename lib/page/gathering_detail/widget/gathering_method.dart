import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/dept_config_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/remit_type.dart';
import 'package:haidai_flutter_module/page/gathering_detail/controller/gathering_detail_controller.dart';
import 'package:haidai_flutter_module/page/gathering_detail/model/remit_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/gathering_detail/widget/remit_method_dialog.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/common_dialog.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GatheringMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GatheringDetailController>(
      builder: (ctl) {
        return SliverToBoxAdapter(
          child: Stack(
            children: [
              Column(
                  children:
                      (ctl.remitDetail?.remitRecordMethodList?.map<Widget>((element) => item(ctl, element)).toList()
                            ?..insert(0, header(ctl))) ??
                          []),
              Visibility(
                visible: ctl.remitDetail?.canceled == CanceledEnum.CANCELED,
                child: Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  top: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: Color(ColorConfig.color_ffffff).withAlpha((255 * 0.7).toInt()),
                      ),
                      pImage("images/icon_canceled.png", 124.w, 124.w),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      id: GatheringDetailController.idRemitMethod,
    );
  }

  item(GatheringDetailController ctl, RemitDetailDoRemitRecordMethodList recordMethod) {
    return GestureDetector(
      child: Container(
        child: Row(
          children: [
            pText(
              "${recordMethod.remitMethodName}",
              ColorConfig.color_333333,
              28.w,
            ),
            Expanded(child: Container()),
            pText(
              "${PriceUtils.getPrice(recordMethod.amount)}",
              ColorConfig.color_333333,
              28.w,
              fontWeight: FontWeight.bold,
            ),
            pSizeBoxW(10.w),
            pImage("images/icon_goto.png", 20.w, 20.w),
          ],
        ),
        padding: EdgeInsets.only(left: 24.w, top: 18.w, bottom: 18.w, right: 20.w),
      ),
      behavior: HitTestBehavior.opaque,
      onTap: () => showRemitMethod(ctl, recordMethod),
    );
  }

  header(GatheringDetailController ctl) {
    return Container(
      child: Row(
        children: [
          pImage(
            ctl.remitDetail?.type == RemitTypeEnum.PAYMENT ? "images/icon_gathering.png" : "images/icon_refund.png",
            82.w,
            82.w,
          ),
          pSizeBoxW(12.w),
          pSizeBoxW(10.w),
          pText(
            "${ctl.remitDetail?.type == RemitTypeEnum.PAYMENT ? "实收金额" : "实退金额"} ${PriceUtils.getPrice(ctl.remitDetail?.remitAmount)}",
            ColorConfig.color_333333,
            34.w,
            fontWeight: FontWeight.bold,
          ),
          Expanded(child: Container()),
          Visibility(
            child: pText(
              "撤销",
              ColorConfig.color_1678FF,
              24.w,
              radius: 4.w,
              borderColor: ColorConfig.color_1678FF,
              width: 120.w,
              height: 56.w,
              onTap: () => showRemitCancelDialog(ctl, () => ctl.cancelOrderRemit()),
            ),
            visible: ctl.remitDetail?.canceled != CanceledEnum.CANCELED,
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 24.w, top: 22.w, bottom: 26.w, right: 24.w),
    );
  }

  showRemitCancelDialog(GatheringDetailController ctl, Function function) async {
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

  showRemitMethod(GatheringDetailController ctl, RemitDetailDoRemitRecordMethodList recordMethod) {
    CommonDialog(
      "选择收款方式",
      RemitMethodDialog(
        ctl.remitDetail!.deptId!,
        selectId: recordMethod.remitMethodId,
        onSelect: (remitMethod) => ctl.updateRemitMethod(recordMethod, remitMethod),
        filterSelect: true,
      ),
    ).showBottom(Get.context!);
  }
}

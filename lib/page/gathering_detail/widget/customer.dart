import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/page/customer/widget/customer_widget.dart';
import 'package:haidai_flutter_module/page/gathering_detail/controller/gathering_detail_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget customer() {
  return GetBuilder<GatheringDetailController>(
    builder: (ctl) {
      var customer = ctl.customer;
      var name = customer?.customerName;
      if ((customer?.customerName?.length ?? 0) > 6) {
        name = "${customer?.customerName?.substring(0, 5)}...";
      }
      return Container(
        padding: EdgeInsets.fromLTRB(0.w, 25.w, 24.w, 30.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.w, color: Color(ColorConfig.color_f5f5f5)),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    customerLogo(customer?.customerName, customer?.levelTag),
                    pSizeBoxW(12.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pText(name ?? "", ColorConfig.color_333333, 28.w,
                            fontWeight: FontWeight.w600),
                        pSizeBoxH(12.w),
                        pText(
                            "欠款 ${PriceUtils.getPrice(customer!.oweAmount)}",
                            ColorConfig.color_999999,
                            24.w),
                      ],
                    )
                  ],
                ),
                // GetBuilder<GatheringDetailController>(
                //   id: "cancelIcon",
                //   builder: (ctl) {
                //     return Visibility(
                //       visible:
                //           ctl.remitDetail?.canceled == CanceledEnum.CANCELED,
                //       child: Positioned(
                //         child: pImage('images/icon_canceled.png', 124.w, 124.w),
                //         top: 138.w,
                //         right: 24.w,
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
            GetBuilder<GatheringDetailController>(
              id: GatheringDetailController.idOrderRemark,
              builder: (ctl) {
                return Visibility(
                  visible: ctl.remitDetail?.remarkList != null &&
                      ctl.remitDetail?.remarkList?.length != 0,
                  child: Container(
                    margin:
                        EdgeInsets.only(top: 35.w, left: 24.w, bottom: 20.w),
                    decoration: new BoxDecoration(
                        color: Color(ColorConfig.color_f5f5f5),
                        borderRadius: new BorderRadius.circular((10.w))),
                    child: ListView.builder(
                      itemCount: ctl.remitDetail?.remarkList?.length ?? 0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                right: 40.w,
                                top: 10.w,
                                bottom: 10.w,
                              ),
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              child: pText(
                                "${ctl.getRemarkItem(index)?.createdByName?.toString()}: ${ctl.getRemarkItem(index)?.remark?.toString()}",
                                ColorConfig.color_F3AE1F,
                                24.w,
                                softWrap: true,
                                maxLines: 3,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Visibility(
                              visible: ctl.remitDetail?.createdBy ==
                                  ctl.getRemarkItem(index)?.createdBy,
                              child: Positioned(
                                top: 10.w,
                                right: 10.w,
                                child: pImageButton(
                                  "images/del_pic.png",
                                  40.w,
                                  40.w,
                                  () {
                                    //删除单据备注
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) {
                                        return CustomDialog(
                                          title: '提示',
                                          type: 1,
                                          height: 300,
                                          confirmTextColor:
                                              ColorConfig.color_ff3715,
                                          content: pText("是否删除该备注",
                                              ColorConfig.color_333333, 28.w),
                                          confirmCallback: (value) =>
                                              ctl.deleteRemark(
                                                  ctl.getRemarkItem(index)!),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: Get.context as BuildContext,
                  barrierDismissible: false,
                  builder: (_) {
                    return CustomDialog(
                      title: '备注',
                      type: 0,
                      confirmCallback: (value) => ctl.addRemark(value),
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  pText("备注", ColorConfig.color_333333, 28.w),
                  pImage('images/icon_goto.png', 22.w, 27.w)
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}

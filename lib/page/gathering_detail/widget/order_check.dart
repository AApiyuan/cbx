import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/model/enum/CustomerUserStatusEnum.dart';
import 'package:haidai_flutter_module/page/gathering_detail/controller/gathering_detail_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/merchandiser_select.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget orderCheck() {
  return GetBuilder<GatheringDetailController>(
    builder: (ctl) {
      return Container(
        padding: EdgeInsets.fromLTRB(24.w, 0.w, 24.w, 0.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.w,
              color: Color(ColorConfig.color_f5f5f5),
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0.w, 30.w, 0.w, 30.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.w,
                    color: Color(ColorConfig.color_efefef),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pText("开单：${ctl.remitDetail?.createUserName}",
                          ColorConfig.color_333333, 28.w),
                      pSizeBoxH(18.w),
                      pText(
                          "#${int.parse(ctl.remitDetail!.orderRemitSerial!.substring(6, ctl.remitDetail!.orderRemitSerial!.length))} ${ctl.remitDetail!.customizeTime!.substring(5, ctl.remitDetail!.customizeTime!.length)}",
                          ColorConfig.color_999999,
                          28.w),
                    ],
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        context: Get.context!,
                        animationCurve: Curves.easeIn,
                        builder: (context) => MerchandiserSelect(
                          deptId: ctl.remitDetail!.deptId as int,
                          statusEnum: CustomerUserStatusEnum.ENABLE,
                          selectMerchandiserId: ctl.remitDetail!.merchandiserId,
                          callBack: (int selectMerchandiserId,
                                  String selectedMerchandiserName) =>
                              ctl.updateOrderBase(selectMerchandiserId),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        GetBuilder<GatheringDetailController>(
                          id: GatheringDetailController.idMerchandiserName,
                          builder: (ctl) {
                            return pText(
                              "跟单：${ctl.remitDetail!.merchandiserName}",
                              ColorConfig.color_999999,
                              24.w,
                            );
                          },
                        ),
                        pImage('images/icon_goto.png', 22.w, 22.w),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

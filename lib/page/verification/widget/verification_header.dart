import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/formatter/num_text_input_formatter.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_bottom.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_collection_and_refund_card.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_order_Info_card.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_select_order_list.dart';
import 'package:haidai_flutter_module/page/verification/widget/verification_user_info_card.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../verification_logic.dart';


Widget verificationHeader (){
  return GetBuilder<VerificationLogic>(
      id: "header",
      builder: (ctl) {
        if (ctl.groupValue == 1) {
          return SliverPersistentHeader(
            pinned: true,
            delegate:
            MySliverPersistentHeaderDelegate1(),
          );
        } else {
          return SliverPersistentHeader(
            pinned: false,
            delegate:
            MySliverPersistentHeaderDelegate2(),
          );
        }
      });
}


class MySliverPersistentHeaderDelegate1 extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GetBuilder<VerificationLogic>(
        id: "fifth",
        builder: (ctl) {
          return Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w),
              alignment: Alignment(0, 0),
              // height: 1000.w,
              width: 750.w,
              decoration: new BoxDecoration(
                color: Colors.white,
                //?????????????????? ??????
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //??????????????????
                border: new Border.all(width: 1, color: Colors.white),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      pText(' ??????', ColorConfig.color_333333, 28.w),
                      pText('?????????????????????????????? ', ColorConfig.color_999999, 24.w),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  Divider(),
                  pText("?????????????????????????????????????? ${ctl.afterBalance()}???",
                      ColorConfig.color_333333, 22.w, textAlign: TextAlign.left),
                  pText("${ctl.getVerification() / 100}",
                      ColorConfig.color_FA6400, 64.w,
                      textAlign: TextAlign.left),
                  Container(
                    color: Color(ColorConfig.color_ffefef),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        pActionText(
                          "${ctl.getVerificationModeTitle()}",
                          ColorConfig.color_ffa0a0,
                          22.w,
                          600.w,
                          40.w,
                              () {
                            // print('??????');
                            // ??????-??????????????????
                            Get.toNamed(ArgUtils.map2String(
                                path: Routes.VERIFICATION_MODE,
                                arguments: {
                                  'verificationMode': ctl.verificationMode,
                                  'orderSaleId': ctl.orderSaleId
                                }))?.then(
                                  (value) {
                                ctl.changeVerificationModeTitle(value);

                                ctl.dataProcessing();
                              },
                            );
                          },
                          background: ColorConfig.color_ffefef,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40.w,
                    child: Image.asset('images/payment_line.png'),
                  )
                ],
              ));
        });
  }

  @override
  double get maxExtent => 280.w;

  @override
  double get minExtent => 280.w;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      false; // ????????????????????????????????????true
}

class MySliverPersistentHeaderDelegate2 extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GetBuilder<VerificationLogic>(
        id: "fifth2",
        builder: (ctl) {
          return Container();
        });
  }

  @override
  double get maxExtent => 0.w;

  @override
  double get minExtent => 0.w;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      false; // ????????????????????????????????????true
}

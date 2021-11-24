import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/controller/goods_profile_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget goodsInfo() {
  return GetBuilder<GoodsProfileController>(
      id: "goodsInfo",
      builder: (ctl) {
        return Container(
          width: double.infinity,
          child: Row(
            children: [
              pSizeBoxW(30.w),
              NetImageWidget(
                ctl.goodsInfo != null?(ctl.goodsInfo!.imgPath ?? "") + "/" + (ctl.goodsInfo!.cover ?? ""):"",
                height: 90,
                width: 90,
              ),
              pSizeBoxW(12.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pText(
                      "${ctl.goodsInfo != null ? ctl.goodsInfo!.goodsSerial.toString() : '--'}",
                      ColorConfig.color_ffffff,
                      32.w),
                  pSizeBoxH(22.w),
                  pText("${ctl.goodsInfo != null ? ctl.goodsInfo!.goodsName.toString() : '--'}", 0xb3ffffff, 24.w,
                      width: 500.w,alignment: Alignment.centerLeft),
                ],
              )
            ],
          ),
        );
      });
}

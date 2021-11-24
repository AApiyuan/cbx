import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/common/utils/refresh_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit_record/controller/bi_remit_record_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit_record/widget/remit_statistic_title.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit_record/widget/remit_total.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget remitRecordListView() {
  return GetBuilder<BiRemitRecordController>(builder: (ctl) {
    return EasyRefresh.custom(
        enableControlFinishLoad: false,
        controller: ctl.refreshController,
        footer: RefreshUtils.defaultFooter(),
        onLoad: () async {
          await Future.delayed(Duration(seconds: 1), () {
            ctl.pageNo++;
            ctl.updateRecord();
          });
        },
        slivers: <Widget>[
          remitSaleStaticTitle(),
          SliverToBoxAdapter(child: remitTotal()),
          GetBuilder<BiRemitRecordController>(
              id: "recordList",
              builder: (ctl) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      bool showDate =
                          index == 0 || ctl.records[index].customizeTime!.substring(0, 10) != ctl.records[index - 1].customizeTime!.substring(0, 10);
                      return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Get.toNamed(ArgUtils.map2String(
                              path: Routes.GATHERING_DETAIL,
                              arguments: {
                                Constant.ORDER_ID: ctl.records[index].orderRemitId
                              },
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: showDate ? 0 : 20.w),
                            child: Column(
                              children: [
                                Visibility(
                                  visible: showDate,
                                  child: pText("${ctl.records[index].customizeTime!.substring(0, 10)}", ColorConfig.color_ffffff, 24.w,
                                      height: 84.w, alignment: Alignment.centerLeft),
                                ),
                                Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.fromLTRB(30.w, 20.w, 30.w, 20.w),
                                    decoration:
                                        BoxDecoration(color: Color(ColorConfig.color_393a58), borderRadius: BorderRadius.all(Radius.circular(20.w))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        customerLogo(ctl.records[index].customerName, ctl.records[index].levelTag,
                                            backgroundColor: ColorConfig.color_646582,
                                            borderColor: ColorConfig.color_ffffff,
                                            margin: EdgeInsets.only(right: 20.w)),
                                        Expanded(
                                          child: Container(
                                              height: 115.w,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      pText(ctl.records[index].customerName!, ColorConfig.color_ffffff, 28.w,
                                                          fontWeight: FontWeight.w600),
                                                      pText(
                                                          ctl.records[index].receivedAmount != 0
                                                              ? "${PriceUtils.getPrice(ctl.records[index].receivedAmount)}"
                                                              : "-${PriceUtils.getPrice(ctl.records[index].refundAmount)}",
                                                          ctl.records[index].receivedAmount != 0
                                                              ? ColorConfig.color_ffffff
                                                              : ColorConfig.color_ff1a43,
                                                          28.w),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      pText(
                                                          "跟单${ctl.records[index].merchandiserName} | ${ctl.records[index].customizeTime!.substring(11, 16)}",
                                                          0xb3ffffff,
                                                          24.w),
                                                      pText("${ctl.records[index].remitMethodName}", 0xb3ffffff, 24.w)
                                                    ],
                                                  ),
                                                  Visibility(
                                                      visible: ctl.records[index].remarkList != null,
                                                      child: pText(
                                                          "备注：${ctl.records[index].remarkList != null ? ctl.records[index].remarkList![0].remark : ""}",
                                                          0xb3ffffff,
                                                          24.w))
                                                ],
                                              )),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ));
                    },
                    childCount: ctl.records.length,
                  ),
                );
              })
        ]);
  });
}

Widget customerLogo(String? customerName, String? levelTag, {Function? onTap, int? backgroundColor, int? borderColor, EdgeInsetsGeometry? margin}) {
  var name = ((customerName?.length ?? 0) > 2 ? customerName?.substring(customerName.length - 2) : customerName) ?? "";
  var tagColor;
  switch (levelTag ?? "A") {
    case "B":
      tagColor = ColorConfig.color_FFBA17;
      break;
    case "A":
      tagColor = ColorConfig.color_FFA523;
      break;
    case "C":
      tagColor = ColorConfig.color_FFDA17;
      break;
  }
  return GestureDetector(
    child: Stack(
      children: [
        Container(
            width: 92.w,
            height: 92.w,
            margin: margin ?? EdgeInsets.only(top: 16.w, bottom: 16.w, left: 24.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Color(borderColor ?? ColorConfig.color_282940), borderRadius: BorderRadius.all(Radius.circular(46.w))),
            child: Container(
              width: 90.w,
              height: 90.w,
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(color: Color(backgroundColor ?? ColorConfig.color_282940), borderRadius: BorderRadius.all(Radius.circular(45.w))),
              child: pText(name, ColorConfig.color_ffffff, 28.w, fontWeight: FontWeight.bold),
            )),
        Positioned(
          child: Container(
            width: 28.w,
            height: 28.w,
            margin: EdgeInsets.only(bottom: 16.w),
            alignment: Alignment.center,
            decoration: ShapeDecoration(color: Color(tagColor), shape: CircleBorder()),
            child: pText(levelTag ?? "A", ColorConfig.color_ffffff, 18.w, fontWeight: FontWeight.bold),
          ),
          right: 10.w,
          bottom: -10.w,
        )
      ],
    ),
    onTap: () => onTap?.call(),
  );
}

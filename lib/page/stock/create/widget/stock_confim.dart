import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/common/utils/common_utils.dart';
import 'package:haidai_flutter_module/page/stock/create/controller/confim_controller.dart';
import 'package:haidai_flutter_module/page/stock/create/controller/stock_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:haidai_flutter_module/widget/date_pick.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget stockConfirmWidget() {
  return GetBuilder<StockController>(builder: (ctl) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20.w),
      color: Color(ColorConfig.color_ffffff),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: ctl.negative ? CrossAxisAlignment.end : CrossAxisAlignment.center,
            children: [
              GetBuilder<StockController>(
                  id: "stockTotal",
                  builder: (ctl) {
                    if (!ctl.negative) {
                      if (ctl.numTotal != 0) {
                        return pText(ctl.styleTotal.toString() + '款  ' + ctl.numTotal.toString() + '件',
                            ColorConfig.color_1678FF, 28.w,
                            fontWeight: FontWeight.w600);
                      } else {
                        return pText(ctl.minusStyleTotal.toString() + '款  ' + ctl.minusNumTotal.toString() + '件',
                            ColorConfig.color_1678FF, 28.w,
                            fontWeight: FontWeight.w600);
                      }
                    } else {
                      return Container(
                          height: 96.w,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              pText('加' + ctl.styleTotal.toString() + '款  ' + ctl.numTotal.toString() + '件',
                                  ColorConfig.color_1678FF, 28.w,
                                  fontWeight: FontWeight.w600),
                              pText('减' + ctl.minusStyleTotal.toString() + '款  ' + ctl.minusNumTotal.toString() + '件',
                                  ColorConfig.color_ff3715, 28.w,
                                  fontWeight: FontWeight.w600)
                            ],
                          ));
                    }
                  }),
              pSizeBoxW(26.w),
              InkWell(
                onTap: () => {eventBus.fire(new AddGoodsEvent(-1))},
                child: Row(
                  children: [pText("全部收起", ColorConfig.color_666666, 24.w), pImage("images/icon_down.png", 32.w, 32.w)],
                ),
              )
            ],
          ),
          pButton(194.w, 96.w, ctl.confirmButtonText, ColorConfig.color_ffffff, 32.w, () {
            //库存操作操作
            showCupertinoModalBottomSheet(
                context: Get.context!,
                animationCurve: Curves.easeIn,
                builder: (context) => orderInfo(ctl.confirmButtonText, () => ctl.confirm()));
          })
        ],
      ),
    );
  });
}

Widget orderInfo(String buttonTitle, Function callback) {
  return GetBuilder<ConfirmController>(builder: (ctl) {
    return BottomSheetWidget(
        title: "单据信息",
        buttonText: buttonTitle,
        height: 1400.w,
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pText('录入备注', ColorConfig.color_333333, 28.w, textAlign: TextAlign.left),
              pSizeBoxH(24.w),
              Container(
                  width: double.infinity,
                  height: 300.w,
                  padding: EdgeInsets.all(20.w),
                  margin: EdgeInsets.only(bottom: 56.w),
                  decoration: BoxDecoration(
                      color: const Color(ColorConfig.color_f5f5f5),
                      borderRadius: BorderRadius.all(Radius.circular(10.w))),
                  child: TextField(
                    controller: ctl.negative ? ctl.changeReasonController : ctl.orderRemarkController,
                    maxLines: 5,
                    inputFormatters: CommonUtils.getTextInputFormatter(50),
                    decoration: InputDecoration(
                      hintText: '请输入',
                      counterText: "",
                      hintStyle: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_999999)),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(fontSize: 28.w, color: Color(ColorConfig.color_F3AE1F)),
                  )),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pText('单据日期', ColorConfig.color_333333, 28.w),
                    GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (ctl.orderStockId != -1) {
                            return;
                          }
                          showCupertinoModalBottomSheet(
                              context: Get.context!,
                              animationCurve: Curves.easeIn,
                              builder: (context) => DatePick(
                                  initialSelectedDate: ctl.selectDate,
                                  onCertain: (v) {
                                    ctl.selectDate = v;
                                    ctl.update(['dateString']);
                                  }));
                        },
                        child: Row(
                          children: [
                            GetBuilder<ConfirmController>(
                                id: "dateString",
                                builder: (ctl) {
                                  return pText(
                                      ctl.selectDate == null ? '选择' : ctl.selectDate.toString().substring(0, 10),
                                      ColorConfig.color_333333,
                                      28.w);
                                }),
                            pImage('images/icon_goto.png', 22.w, 22.w)
                          ],
                        ))
                  ],
                ),
              ),
              pSizeBoxH(60.w),
              pText(ctl.tagName, ColorConfig.color_333333, 28.w),
              pSizeBoxH(24.w),
              FutureBuilder(
                  future: ctl.getTag(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      return GetBuilder<ConfirmController>(
                          id: "stockTag",
                          builder: (ctl) {
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: ctl.tagList.length,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 24.w,
                                mainAxisSpacing: 24.w,
                                childAspectRatio: 260.0 / 72,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return pText(
                                    ctl.tagList[index].dictName.toString(),
                                    ctl.tagList[index].id == ctl.selectTagId
                                        ? ColorConfig.color_ffffff
                                        : ColorConfig.color_666666,
                                    28.w,
                                    width: 260.w,
                                    height: 72.w, onTap: () {
                                  ctl.selectTagId = ctl.tagList[index].id;
                                  ctl.update(["stockTag"]);
                                },
                                    borderColor: ctl.tagList[index].id == ctl.selectTagId
                                        ? ColorConfig.color_1678FF
                                        : ColorConfig.color_f5f5f5,
                                    background: ctl.tagList[index].id == ctl.selectTagId
                                        ? ColorConfig.color_1678FF
                                        : ColorConfig.color_f5f5f5,
                                    radius: 10.w);
                              },
                            );
                          });
                    }
                  })
            ],
          ),
        )),
        onClose: () {},
        onCertain: () {
          callback.call();
        });
  });
}

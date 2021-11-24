import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/remit/controller/remit_method_sort_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemitMethodSort extends GetView<RemitMethodSortController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<RemitMethodSortController>(
            id: "methodsList",
            builder: (ctl) {
              return Scaffold(
                backgroundColor: Color(ColorConfig.color_ffffff),
                appBar: pAppBar("收款方式调序", backFunc: () {
                  BackUtils.back();
                }),
                body: ReorderableListView(
                    onReorder: (int oldIndex, int newIndex) {
                      StoreRemitMethodDoEntity element = ctl.remitMethods[oldIndex];
                      if (newIndex >= ctl.remitMethods.length) {
                        newIndex = ctl.remitMethods.length - 1;
                      }
                      ctl.remitMethods.removeAt(oldIndex);
                      ctl.remitMethods.insert(newIndex, element);
                      ctl.update(['methodsList']);
                    },
                    header: pText("调序后店铺人员都会变更", ColorConfig.color_ff5d1e, 24.w,
                        height: 48.w, background: ColorConfig.color_fffcd9, alignment: Alignment.center, margin: EdgeInsets.only(bottom: 20.w)),
                    children: controller.remitMethods
                        .map((e) => Container(
                              key: ValueKey(e.id),
                              child: Container(
                                height: 95.w,
                                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    pText(e.remitMethodName.toString(), ColorConfig.color_333333, 28.w),
                                    pImage("images/icon_scroll_color.png", 50.w, 50.w)
                                  ],
                                ),
                              ),
                            ))
                        .toList()),
                bottomSheet: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.w),
                    child: pButton(
                      double.infinity,
                      96.w,
                      "确定",
                      ColorConfig.color_ffffff,
                      28.w,
                      () {
                        ctl.updateMethods();
                      },
                      radius: 96.w,
                    )),
              );
            }),
        onWillPop: () {
          BackUtils.back();
          return new Future.value(false);
        });
  }
}

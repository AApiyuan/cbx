import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/transfer/create/controller/confirm_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/dept_select.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Widget deptTitle() {
  return GetBuilder<ConfirmController>(builder: (ctl) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (ctl.isEditSelectDept) {
          showCupertinoModalBottomSheet(
              context: Get.context!,
              animationCurve: Curves.easeIn,
              builder: (context) => DeptSelect(
                    deptId: ctl.deptId,
                    selectDeptId: ctl.selectDeptId,
                    callBack: (int selectDeptId, String name) {
                      ctl.selectDeptId = selectDeptId;
                      ctl.selectDeptName = name;
                      ctl.update(['orderDept']);
                    },
                  ));
        }
      },
      child: Container(
        height: 100.w,
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(ColorConfig.color_f5f5f5), width: 18.w))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Visibility(
                    visible: ctl.showImportant,
                    child: pText("*", ColorConfig.color_ff3715, 28.w),
                  ),
                  GetBuilder<ConfirmController>(
                      id: "orderDept",
                      builder: (ctl) {
                        return pText("对方店/仓：" + ctl.selectDeptName, ColorConfig.color_333333, 28.w);
                      }),
                ],
              ),
            ),
            Visibility(visible: ctl.isEditSelectDept, child: pImage('images/icon_goto.png', 22.w, 22.w))
          ],
        ),
      ),
    );
  });
}

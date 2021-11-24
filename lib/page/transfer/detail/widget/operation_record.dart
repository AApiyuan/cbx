import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/transfer/detail/controller/transfer_detail_controller.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget operationRecord() {
  return GetBuilder<TransferDetailController>(builder: (ctl) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
      height: 92.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color(ColorConfig.color_f5f5f5), width: 20.w))),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          //跳转到操作记录
          //跳转配货记录
          Map<String, dynamic> param = new Map();
          param[Constant.ORDER_TRANSFER_ID] = ctl.orderTransferId;
          param[Constant.DEPT_ID] = ctl.deptId;
          Get.toNamed(ArgUtils.map2String(path: Routes.TRANSFER_OPERATION, arguments: param));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                pText("操作记录", ColorConfig.color_999999, 24.w),
                pSizeBoxW(10.w),
                pText(
                    ctl.orderTransfer!.transferActionDo!.createdTime.toString() +
                        " " +
                        ctl.orderTransfer!.transferActionDo!.createdByName!.toString(),
                    ColorConfig.color_999999,
                    24.w),
              ],
            ),
            pImage('images/icon_goto.png', 22.w, 27.w)
          ],
        ),
      ),
    );
  });
}

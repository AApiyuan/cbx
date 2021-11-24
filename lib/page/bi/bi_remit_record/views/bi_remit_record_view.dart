import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit_record/controller/bi_remit_record_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit_record/widget/remit_record_list.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit_record/widget/select_remit_method_draw.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiRemitRecordView extends GetView<BiRemitRecordController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<BiRemitRecordController>(
            id: "BiSalePage",
            builder: (ctl) {
              return Scaffold(
                  backgroundColor: Color(ColorConfig.color_ffffff),
                  endDrawer: SelectRemitMethodDraw(
                    deptId: ctl.deptId,
                    selected: ctl.remitMethodIds,
                    callBack: (List<int> ids) {
                      ctl.remitMethodIds = ids;
                      ctl.pageNo = 1;
                      ctl.updateRemitStatistic();
                    },
                  ),
                  appBar: pAppBar(
                    '收支记录',
                    type: 1,
                    actions: [
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: Row(
                            children: [
                              pText("筛选", ColorConfig.color_ffffff, 27.w),
                              pImage("images/icon_down.png", 24.w, 24.w)
                            ],
                          ),
                        );
                      }),
                      pSizeBoxW(20.w),
                    ],
                    backIconColor: ColorConfig.color_ffffff,
                    backgroundColor: ColorConfig.color_282940,
                  ),
                  body: Container(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w),
                      color: Color(ColorConfig.color_282940),
                      child: remitRecordListView()));
            }),
        onWillPop: () {
          BackUtils.back();
          return new Future.value(false);
        });
  }
}

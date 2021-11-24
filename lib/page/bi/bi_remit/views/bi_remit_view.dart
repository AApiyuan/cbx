import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/controller/bi_remit_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/widget/remit_chart.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/widget/remit_list.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/widget/remit_method.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/widget/remit_statistic_title.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/widget/remit_total.dart';
import 'package:haidai_flutter_module/page/bi/widget/select_dept_draw.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiRemitView extends GetView<BiRemitController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<BiRemitController>(
            id: "BiSalePage",
            builder: (ctl) {
              return Scaffold(
                  backgroundColor: Color(ColorConfig.color_ffffff),
                  endDrawer: SelectDeptDraw(
                    callBack: (List<int> ids) {
                      //店铺选择
                      ctl.customerDeptIds = ids;
                      ctl.init();
                      ctl.update(['deptNum']);
                    },
                  ),
                  appBar: pAppBar(
                    '收支报表',
                    type: 1,
                    actions: [
                      GetBuilder<BiRemitController>(
                          id: "deptNum",
                          builder: (ctl) {
                            return Builder(builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).openEndDrawer();
                                },
                                child: Row(
                                  children: [
                                    pText("${ctl.customerDeptIds.length == 0 ? '全部' : ctl.customerDeptIds.length.toString() + '个'}店铺",
                                        ColorConfig.color_ffffff, 27.w),
                                    pImage("images/icon_down.png", 24.w, 24.w)
                                  ],
                                ),
                              );
                            });
                          }),
                      pSizeBoxW(20.w),
                    ],
                    backIconColor: ColorConfig.color_ffffff,
                    backgroundColor: ColorConfig.color_282940,
                  ),
                  body: Container(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w),
                      color: Color(ColorConfig.color_282940),
                      child: CustomScrollView(
                        slivers: [
                          //图表
                          SliverToBoxAdapter(child: remitChart()),
                          remitSaleStaticTitle(),
                          SliverToBoxAdapter(child: remitTotal()),
                          SliverToBoxAdapter(child: remitMethod()),
                          SliverToBoxAdapter(child: remitList()),
                        ],
                      )));
            }),
        onWillPop: () {
          BackUtils.back();
          return new Future.value(false);
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/controller/bi_sale_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_chart.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_order_owe_and_balance.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_owe_and_stock.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_sale_statatic.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_user_sale.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiOneDeptSaleView extends GetView<BiSaleController>{

@override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<BiSaleController>(
            id: "BiOneDeptSale",
            builder: (ctl) {
              return Scaffold(
                  backgroundColor: Color(ColorConfig.color_ffffff),
                  appBar: pAppBar(
                    ctl.deptName??"店铺报表",
                    type: 1,

                    backIconColor: ColorConfig.color_ffffff,
                    backgroundColor: ColorConfig.color_282940,
                  ),
                  body: Container(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w),
                    color: Color(ColorConfig.color_282940),
                    child: CustomScrollView(
                      slivers: [
                        //图表
                        SliverToBoxAdapter(child: deptChart()),
                        //欠货库存
                        SliverToBoxAdapter(child: deptOweAndStock()),
                        //单据结欠余额
                        SliverToBoxAdapter(child: deptOrderOweAndBalance()),
                        //筛选头部
                        deptSaleStaticTitle(),
                        //各种销售统计
                        SliverToBoxAdapter(child: deptSaleStaticDetail()),
                        //收款统计
                        SliverToBoxAdapter(child: deptRemitStaticDetail()),
                        //店员top10
                        SliverToBoxAdapter(child: deptUserSale()),
                      ],
                    ),
                  ));
            }),
        onWillPop: () {
          BackUtils.back();
          return new Future.value(false);
        });
  }
}

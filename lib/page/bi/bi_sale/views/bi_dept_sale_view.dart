import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_chart.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_order_owe_and_balance.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_owe_and_stock.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_sale_statatic.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_user_sale_top10.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiDeptSaleView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BiDeptSaleViewState();
  }
}

class BiDeptSaleViewState extends State<BiDeptSaleView> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SliverToBoxAdapter(child: deptUserSaleTop10()),
        ],
      ),
    );
  }
}

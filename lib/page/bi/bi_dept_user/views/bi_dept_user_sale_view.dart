import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/widget/dept_user_chart.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/widget/dept_user_sale_list.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/widget/dept_user_statistic_title.dart';

import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class BiDeptUserSaleView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BiDeptUserSaleViewState();
  }
}

class BiDeptUserSaleViewState extends State<BiDeptUserSaleView> with AutomaticKeepAliveClientMixin {
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
          SliverToBoxAdapter(child: pSizeBoxH(20.w)),
          deptUserSaleStaticTitle(),
          SliverToBoxAdapter(child: deptUserChart()),
          SliverToBoxAdapter(child: deptUserSaleList())
        ],
      ),
    );
  }
}

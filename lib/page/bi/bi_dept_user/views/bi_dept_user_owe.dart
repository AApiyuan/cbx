import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/widget/dept_user_owe_list.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/widget/dept_user_owe_statistic.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiDeptUserOweView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BiDeptUserOweViewState();
  }
}

class BiDeptUserOweViewState extends State<BiDeptUserOweView> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        color: Color(ColorConfig.color_282940),
        child: CustomScrollView(
          slivers: [SliverToBoxAdapter(child: deptUserOweStatistic()), SliverToBoxAdapter(child: deptUserOweList())],
        ),
      );
  }
}

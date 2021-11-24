import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/controller/bi_sale_detail_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_detail_list.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/widget/dept_sale_detail_title.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiDeptSaleDetailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BiDeptSaleDetailViewState();
  }
}

class BiDeptSaleDetailViewState extends State<BiDeptSaleDetailView> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BiSaleDetailController>(
        builder: (ctl) {
          return Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w),
            color: Color(ColorConfig.color_282940),
            child: Column(children: [
              deptSaleDetailTile(),
              deptDetailList()
            ],),
          );
        });
  }
}
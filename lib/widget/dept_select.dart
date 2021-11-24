import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_relation_do.dart';
import 'package:haidai_flutter_module/repository/base/store.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

import 'net_image.dart';

class DeptSelect extends StatefulWidget {
  final int deptId;
  int? selectDeptId;
  Function callBack;

  DeptSelect({Key? key, required this.deptId, this.selectDeptId, required this.callBack});

  @override
  State<StatefulWidget> createState() {
    return _DeptSelectState();
  }
}

class _DeptSelectState extends State<DeptSelect> {
  List<CustomerDeptRelationDo> deptData = [];
  String selectedDeptName = "";

  Future getData() async {}

  @override
  void initState() {
    StoreApi.getDeptRelation(widget.deptId).then((v) {
      setState(() {
        deptData = v;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWidget(
        title: "对方店仓",
        height: 1432.w,
        showCertain: false,
        child: Container(
          padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
            child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: deptData.length,
                    itemBuilder: (context, index) {
                      return deptItem(deptData[index], index);
                    })),
          ],
        )));
  }

  Widget deptItem(CustomerDeptRelationDo item, int index) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            widget.selectDeptId = item.relationDeptId;
            selectedDeptName = item.name as String;
          });
          Navigator.pop(context);
          widget.callBack(widget.selectDeptId, selectedDeptName);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 50.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  NetImageWidget(
                    (item.logo ?? ""),
                    height: 90,
                    width: 90,
                  ),
                  pSizeBoxW(20.w),
                  pText(item.name.toString(), ColorConfig.color_333333, 32.w, fontWeight: FontWeight.w600)
                ],
              ),
              pImage(widget.selectDeptId == item.relationDeptId ? 'images/checked.png' : 'images/unChecked.png', 38.w, 38.w)
            ],
          ),
        ));
  }
}

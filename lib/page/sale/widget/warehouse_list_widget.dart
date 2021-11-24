import 'package:flutter/material.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_relation_do.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/net_image.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget warehouseListContent(List<CustomerDeptRelationDo> list,
    CustomerDeptRelationDo select, Function(CustomerDeptRelationDo) function) {
  return ListView.builder(
    itemBuilder: (_, index) => listItem(list[index], select, function),
    itemCount: list.length,
  );
}

listItem(CustomerDeptRelationDo deptRelationDo, CustomerDeptRelationDo select,
    Function(CustomerDeptRelationDo) function) {
  return InkWell(
    child: Container(
      child: Row(
        children: [
          NetImageWidget(
            "${deptRelationDo.logo}",
            width: 90,
            height: 90,
            clickEnable: false,
          ),
          pSizeBoxW(20.w),
          pText(
            "${deptRelationDo.name}",
            ColorConfig.color_333333,
            32.w,
            fontWeight: FontWeight.bold,
          ),
          Expanded(child: Container()),
          pImage(
              select.relationDeptId == deptRelationDo.relationDeptId
                  ? "images/icon_select_on.png"
                  : "images/icon_select_off.png",
              38.w,
              38.w),
        ],
      ),
      padding: EdgeInsets.all(24.w),
      alignment: Alignment.center,
    ),
    onTap: () => function.call(deptRelationDo),
  );
}

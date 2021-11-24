import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/customer/controller/search_customer_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/theme/widget_theme.dart';

Widget filterCustomerWidget(Function? filterPerson) {
  return Container(
    height: 104.w,
    width: double.infinity,
    padding: EdgeInsets.only(left: 24.w, right: 24.w),
    child: Row(
      children: [
        Expanded(
          child: azSort(),
          flex: 50,
        ),
        Expanded(
          child: filterItemWidget("跟单人", SearchCustomerController.idFilterPerson, filterPerson: filterPerson),
          flex: 100,
        ),
        Expanded(
          child: filterItemWidget("欠款", SearchCustomerController.idFilterOwe),
          flex: 50,
        ),
        Expanded(
          child: filterItemWidget("欠货", SearchCustomerController.idFilterOweGoods),
          flex: 50,
        ),
      ],
    ),
  );
}

Widget filterItemWidget(String title, String id, {Function? filterPerson}) {
  return GetBuilder<SearchCustomerController>(
    id: id,
    builder: (ctl) {
      return InkWell(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: selectTextStyle(ctl.isCurrFilter(id)),
              ),
              SizedBox(
                width: id == SearchCustomerController.idFilterPerson ? 9.w : 5.w,
              ),
              Image.asset(
                getImgAsset(id, ctl.getCurrFilterState(id)),
                width: id == SearchCustomerController.idFilterPerson ? 28.w : 35.w,
                height: id == SearchCustomerController.idFilterPerson ? 28.w : 35.w,
              ),
            ],
          ),
        ),
        onTap: () => id == SearchCustomerController.idFilterPerson ? filterPerson?.call() : ctl.updateFilter(id),
      );
    },
  );
}

String getImgAsset(String tag, int state) {
  if (tag == SearchCustomerController.idFilterPerson) {
    if (state == 0) {
      return "images/icon_filtrate_off.png";
    } else {
      return "images/icon_filtrate_on.png";
    }
  } else {
    if (state == 2) {
      return "images/home_function_up.png";
    } else if (state == 1) {
      return "images/home_function_down.png";
    } else {
      return "images/home_function_null.png";
    }
  }
}

Widget azSort() {
  var id = SearchCustomerController.idAzSort;
  return GetBuilder<SearchCustomerController>(
    builder: (ctl) {
      return InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            "A-Z",
            style: selectTextStyle(ctl.isCurrFilter(id)),
          ),
        ),
        onTap: () => ctl.updateFilter(id),
      );
    },
    id: id,
  );
}

selectTextStyle(bool select) {
  return textStyle(size: 28, color: select ? ColorConfig.color_333333 : ColorConfig.color_666666, bold: select);
}

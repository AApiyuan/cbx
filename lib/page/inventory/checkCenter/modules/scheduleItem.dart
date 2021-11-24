import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/controller/checkCenterController.dart';
import 'package:haidai_flutter_module/theme/color.dart';

class ScheduleItem {
  List<Widget> schedule(CheckCenterController? ctl, int position) {
    List<String> names = <String>[];
    names.add("开始盘点");
    names.add("盘点完成");
    names.add("库存调整");
    names.add("结束");

    if (ctl != null) {
      Map<String, dynamic> status = new Map<String, dynamic>();
      status["ON"] = 1;
      status["INVENTORY_COMPLETE"] = 2;
      status["FINISH"] = 4;

      try {
        if (ctl.getEntity().status != null)
          position = status[ctl.getEntity().status];

        // print(ctl.getValue().requestId.toString());
      } catch (e) {
        print(e);
        // print(ctl.getValue().data.id);
      }

      // InventoryDoEntity inventoryDoEntity = ctl.getValue();
    }

    List<Widget> list = <Widget>[];
    for (int i = 0; i < 4; i++) {
      if (i < position) {
        list.add(Container(
          width: 165.w,
          height: 100.w,
          child: Column(
            children: [
              Text(
                names[i],
                style: TextStyle(
                    color: Color(ColorConfig.color_44D75C), fontSize: 24.w),
              ),
              SizedBox(height: 14.w),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 3.w,
                      color: Color(ColorConfig.color_44D75C),
                    ),
                  ),
                  Image(
                    image: AssetImage(
                      "images/icon_check_center_02.png",
                    ),
                    fit: BoxFit.cover,
                    width: 40.w,
                    height: 40.w,
                  ),
                  Expanded(
                    child: Container(
                      height: 3.w,
                      color: Color(ColorConfig.color_44D75C),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
      } else {
        list.add(
          Container(
            width: 165.w,
            height: 100.w,
            child: Column(
              children: [
                Text(
                  names[i],
                  style: TextStyle(
                      color: Color(ColorConfig.color_999999), fontSize: 24.w),
                ),
                SizedBox(height: 14.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 3.w,
                        color: Color(ColorConfig.color_dcdcdc),
                      ),
                    ),
                    Image(
                      image: AssetImage(
                        "images/icon_uncheck_center_02.png",
                      ),
                      fit: BoxFit.cover,
                      width: 40.w,
                      height: 40.w,
                    ),
                    Expanded(
                      child: Container(
                        height: 3.w,
                        color: Color(ColorConfig.color_dcdcdc),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }

    return list;
  }
}

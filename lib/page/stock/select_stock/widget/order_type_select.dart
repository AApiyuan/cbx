import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/enum/stock_change_type.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/controller/select_stock_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/drawer_dialog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget orderTypeSelect(Function change) {
  var _orderTypeKey = GlobalKey();

  return GetBuilder<SelectStockController>(
      builder: (ctl) {
        return GestureDetector(
          onTap: () {
            DrawerDialog(
              (dialog) => orderTypeSelectContent(dialog, change, ctl),
              autoDismiss: false,
            ).show(
              Get.context as BuildContext,
              _orderTypeKey,
            );
          },
          child: Row(key: _orderTypeKey, children: [
            pText('业务类型', ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
            pSizeBoxW(16.w),
            pImage("images/icon_down.png", 24.w, 24.w),
          ]),
        );
      });
}

Widget orderTypeSelectContent(DrawerDialog dialog, Function change, SelectStockController controller) {
  List<String> data = [
    OrderStockTypeEnum.DIRECT_IN,
    OrderStockTypeEnum.TRANSFER_IN,
    OrderStockTypeEnum.DISTRIBUTION_IN,
    OrderStockTypeEnum.BACK_IN,
    OrderStockTypeEnum.SUBSTANDARD_BACK,
    OrderStockTypeEnum.SUBSTANDARD_TRANSFER_IN
  ];
  Map<String, bool> oldSelectedOrderType = new Map.from(controller.selectedOrderType);

  return GetBuilder<SelectStockController>(
      id: "orderTypeSelect",
      builder: (ctl) {
        return Stack(children: [
          Container(
              color: Colors.white,
              height: 900.w,
              child: Column(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    //解决无限高度问题
                    physics: new NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (ctl.selectedOrderType[data[index]] == null) {
                            ctl.selectedOrderType[data[index]] = true;
                          } else {
                            ctl.selectedOrderType.remove(data[index]);
                          }
                          ctl.update(["check" + data[index]]);
                        },
                        child: Container(
                          height: 100.w,
                          padding: EdgeInsets.only(left: 24.w),
                          child: Row(
                            children: [
                              GetBuilder<SelectStockController>(
                                  id: "check" + data[index],
                                  builder: (ctl) {
                                    return pImage(ctl.selectedOrderType[data[index]] == null ? "images/unChecked.png" : "images/icon_select_on.png",
                                        38.w, 38.w);
                                  }),
                              pSizeBoxW(20.w),
                              pText(OrderStockTypeEnum.transfer(data[index]), ColorConfig.color_333333, 28.w)
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: data.length,
                  ),
                  pSizeBoxH(50.w),
                ],
              )),
          Positioned(
              bottom: 0,
              child: Row(
                children: [
                  pActionText("重置", ColorConfig.color_666666, 32.w, 250.w, 96.w, () {
                    ctl.selectedOrderType.clear();
                    ctl.update(['orderTypeSelect']);
                  }, background: ColorConfig.color_ffffff),
                  pActionText("取消", ColorConfig.color_1678ff, 32.w, 250.w, 96.w, () {
                    ctl.selectedOrderType = oldSelectedOrderType;
                    ctl.update(['orderTypeSelect']);
                    dialog.dismiss();
                  }, background: ColorConfig.color_efefef),
                  pActionText("确定", ColorConfig.color_ffffff, 32.w, 250.w, 96.w, () {
                    dialog.dismiss();
                    change.call();
                  }, background: ColorConfig.color_1678ff),
                ],
              ))
        ]);
      });
}

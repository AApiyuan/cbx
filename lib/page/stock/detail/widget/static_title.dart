import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/page/stock/detail/controller/stock_detail_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget staticTitle() {
  return GetBuilder<StockDetailController>(builder: (ctl) {
    String static = "";
    if (ctl.isAdjust) {
      int addStyleNum = 0;
      int subStyleNum = 0;
      ctl.oldStock!.goods!.forEach((e) {
        if (e.addNum != null && e.addNum != 0) {
          addStyleNum += 1;
        }
        if (e.subtractNum != null && e.subtractNum != 0) {
          subStyleNum += 1;
        }
      });
      if (addStyleNum != 0) {
        static += addStyleNum.toString() + "款增加" + ctl.oldStock!.addNum.toString() + "件";
        if (subStyleNum != 0) {
          static += "/" + subStyleNum.toString() + "款减少" + (-ctl.oldStock!.subtractNum!).toString() + "件";
        }
      } else {
        if (subStyleNum != 0) {
          static += subStyleNum.toString() + "款减少" + (-ctl.oldStock!.subtractNum!).toString() + "件";
        }
      }
    } else {
      static = ctl.oldStock!.goods!.length.toString() + "款" + (ctl.oldStock!.addNum! + ctl.oldStock!.subtractNum!).toString() + "件";
    }

    return GestureDetector(
        onTap: () {
          if (ctl.allOpenStatus) {
            //收起
            eventBus.fire(new AddGoodsEvent(-1));
          } else {
            //全部展开
            eventBus.fire(new AddGoodsEvent(-2));
          }
          ctl.allOpenStatus = !ctl.allOpenStatus;
          //设置所有goods 的状态
          List<String> goodsOpenTag = [];
          ctl.skuMap.forEach((key, value) {
            if (ctl.allOpenStatus) {
              ctl.openStatus[key] = true;
            } else {
              ctl.openStatus[key] = false;
            }
            goodsOpenTag.add("open" + key.toString());
          });
          goodsOpenTag.add('openAll');
          ctl.update(goodsOpenTag);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(24.w, 32.w, 24.w, 32.w),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: const Color(ColorConfig.color_dcdcdc), width: 1.w))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              pText(static, ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
              GetBuilder<StockDetailController>(
                  id: "openAll",
                  builder: (ctl) {
                    return Row(
                      children: [
                        pText(ctl.allOpenStatus ? "全部收起" : "全部展开", ColorConfig.color_999999, 28.w),
                        pImage(ctl.allOpenStatus ? "images/icon_up.png" : "images/icon_down.png", 32.w, 32.w)
                      ],
                    );
                  })
            ],
          ),
        ));
  });
}

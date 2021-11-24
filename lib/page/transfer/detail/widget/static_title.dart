import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/config/event_bus.dart';
import 'package:haidai_flutter_module/page/transfer/detail/controller/transfer_detail_controller.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget staticTitle() {
  return GetBuilder<TransferDetailController>(builder: (ctl) {
    String static = "";
    if (ctl.orderTransfer!.applyNum != null && ctl.orderTransfer!.applyNum != 0) {
      static += "申请" + ctl.orderTransfer!.applyStyleNum.toString() + "款" + ctl.orderTransfer!.applyNum.toString();
      if (ctl.orderTransfer!.stockOutNum != null && ctl.orderTransfer!.stockOutNum != 0) {
        static += "/";
      }
    }
    if (ctl.orderTransfer!.stockOutNum != null && ctl.orderTransfer!.stockOutNum != 0) {
      static += "出库" + ctl.orderTransfer!.stockOutStyleNum.toString() + "款" + ctl.orderTransfer!.stockOutNum.toString();
      if (ctl.orderTransfer!.stockInNum != null && ctl.orderTransfer!.stockInNum != 0) {
        static += "/";
      }
    }
    if (ctl.orderTransfer!.stockInNum != null && ctl.orderTransfer!.stockInNum != 0) {
      static += "入库" + ctl.orderTransfer!.stockInStyleNum.toString() + "款" + ctl.orderTransfer!.stockInNum.toString();
    }
    String different = "";
    if ((ctl.orderTransfer!.differanceMore != null && ctl.orderTransfer!.differanceMore != 0) ||
        (ctl.orderTransfer!.differanceLess != null && ctl.orderTransfer!.differanceLess != 0)) {
      if (ctl.orderTransfer!.differanceMore != null && ctl.orderTransfer!.differanceMore != 0) {
        different += ("(多" + ctl.orderTransfer!.differanceMore.toString());
        if (ctl.orderTransfer!.differanceLess != null && ctl.orderTransfer!.differanceLess != 0) {
          different += ("/少" + ctl.orderTransfer!.differanceLess.toString() + ")");
        } else {
          different += (")");
        }
      } else if (ctl.orderTransfer!.differanceLess != null && ctl.orderTransfer!.differanceLess != 0) {
        different += ("(少" + ctl.orderTransfer!.differanceLess.toString() + ")");
      }
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pText("合计" + static, ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                  Visibility(child: pText(different, ColorConfig.color_FA6400, 28.w, textAlign: TextAlign.left))
                ],
              ),
              GetBuilder<TransferDetailController>(
                  id: "openAll",
                  builder: (ctl) {
                    return pImage(ctl.allOpenStatus ? "images/icon_up.png" : "images/icon_down.png", 32.w, 32.w);
                  })
            ],
          ),
        ));
  });
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/stock/detail/controller/stock_detail_controller.dart';
import 'package:haidai_flutter_module/page/stock/model/req/order_stock_update_dto.dart';
import 'package:haidai_flutter_module/repository/order/stock_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget orderRemark() {
  return GetBuilder<StockDetailController>(
      id: "orderRemark",
      builder: (ctl) {
        return GestureDetector(
            onTap: () {
              showDialog(
                  context: Get.context as BuildContext,
                  barrierDismissible: false,
                  builder: (_) {
                    return CustomDialog(
                      title: ctl.isAdjust ? "原因" : "备注",
                      type: 0,
                      value: ctl.isAdjust ? (ctl.oldStock!.changeReason ?? "") : (ctl.oldStock!.remark ?? ""),
                      confirmCallback: (value) {
                        OrderStockUpdateDto param = new OrderStockUpdateDto();
                        param.id = ctl.oldStock!.id;
                        if (ctl.isAdjust) {
                          param.changeReason = value;
                        } else {
                          param.remark = value;
                        }
                        StockApi.updateRemark(param).then((v) {
                          if (ctl.isAdjust) {
                            ctl.oldStock!.changeReason = value;
                          } else {
                            ctl.oldStock!.remark = value;
                          }
                          ctl.update(['orderRemark']);
                        });
                      },
                    );
                  });
            },
            child: Container(
                padding: EdgeInsets.fromLTRB(24.w, 55.w, 24.w, 20.w),
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(ColorConfig.color_f5f5f5), width: 18.w))),
                child: Row(
                  children: [
                    pText(ctl.isAdjust ? "原因" : "备注", ColorConfig.color_333333, 28.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 44.w),
                        child: pText(ctl.isAdjust ? (ctl.oldStock!.changeReason ?? "") : (ctl.oldStock!.remark ?? ""), ColorConfig.color_999999, 28.w,
                            textAlign: TextAlign.left),
                      ),
                    ),
                    pImage('images/icon_goto.png', 22.w, 27.w)
                  ],
                )));
      });
}

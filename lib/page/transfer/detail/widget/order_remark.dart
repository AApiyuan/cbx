import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/enum/remark_order_type.dart';
import 'package:haidai_flutter_module/model/remark.dart';
import 'package:haidai_flutter_module/page/transfer/detail/controller/transfer_detail_controller.dart';
import 'package:haidai_flutter_module/repository/order/remark_api.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget orderRemark() {
  return GetBuilder<TransferDetailController>(builder: (ctl) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 20.w),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(ColorConfig.color_f5f5f5), width: 18.w))),
      child: Column(
        children: [
          pSizeBoxH(28.w),
          GetBuilder<TransferDetailController>(
              id: "orderRemark",
              builder: (ctl) {
                return Visibility(
                    visible: ctl.orderTransfer!.remarks != null && ctl.orderTransfer!.remarks!.length != 0,
                    child: Container(
                      decoration: new BoxDecoration(color: Color(ColorConfig.color_f5f5f5), borderRadius: new BorderRadius.circular((10.w))),
                      child: ListView.builder(
                          itemCount: ctl.orderTransfer!.remarks!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10.w, right: 40.w, top: 10.w, bottom: 10.w),
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  child: pText(
                                      ctl.orderTransfer!.remarks![index].createdByName.toString() +
                                          ": " +
                                          ctl.orderTransfer!.remarks![index].remark.toString(),
                                      ColorConfig.color_F3AE1F,
                                      24.w,
                                      softWrap: true,
                                      maxLines: 3,
                                      textAlign: TextAlign.left),
                                ),
                                Visibility(
                                    visible: ctl.customerUserDo!.id == ctl.orderTransfer!.remarks![index].createdBy,
                                    child: new Positioned(
                                        top: 10.w,
                                        right: 10.w,
                                        child: pImageButton("images/del_pic.png", 40.w, 40.w, () {
                                          //删除单据备注
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (_) {
                                                return CustomDialog(
                                                  title: '提示',
                                                  type: 1,
                                                  height: 300,
                                                  confirmTextColor: ColorConfig.color_ff3715,
                                                  content: pText("是否删除该备注", ColorConfig.color_333333, 28.w),
                                                  confirmCallback: (value) async {
                                                    List<int> remarkIds = [ctl.orderTransfer!.remarks![index].id as int];
                                                    var res = await RemarkApi.batchDeleteOrderRemark(remarkIds);
                                                    if (res) {
                                                      ctl.orderTransfer!.remarks!.removeAt(index);
                                                      ctl.update(['orderRemark']);
                                                    }
                                                  },
                                                );
                                              });
                                        }))),
                              ],
                            );
                          }),
                    ));
              }),
          pSizeBoxH(24.w),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: Get.context as BuildContext,
                  barrierDismissible: false,
                  builder: (_) {
                    return CustomDialog(
                      title: '备注',
                      type: 0,
                      confirmCallback: (value) {
                        //直接添加单据 备注
                        Remark remarkParam = new Remark();
                        remarkParam.orderType = RemarkOrderTypeEnum.ORDER_TRANSFER;
                        remarkParam.remark = value;
                        remarkParam.createdBy = ctl.customerUserDo!.id;
                        remarkParam.createdByName = ctl.customerUserDo!.name;
                        remarkParam.orderId = ctl.orderTransfer!.id;
                        RemarkApi.saveOrderRemark(remarkParam).then((v) {
                          RemarkApi.getRemark(ctl.orderTransfer!.id as int, RemarkOrderTypeEnum.ORDER_TRANSFER).then((value) {
                            ctl.orderTransfer!.remarks = value;
                            ctl.update(["orderRemark"]);
                          });
                        });
                      },
                    );
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [pText("备注", ColorConfig.color_333333, 28.w), pImage('images/icon_goto.png', 22.w, 27.w)],
            ),
          )
        ],
      ),
    );
  });
}

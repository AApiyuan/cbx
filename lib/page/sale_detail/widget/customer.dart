import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleConfigDistributionEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/price_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/model/enum/remark_order_type.dart';
import 'package:haidai_flutter_module/model/remark.dart';
import 'package:haidai_flutter_module/page/customer/widget/customer_widget.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/sale_detail/controller/sale_detail_controller.dart';
import 'package:haidai_flutter_module/repository/order/remark_api.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/customer_dailog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

Widget customer() {
  return GetBuilder<SaleDetailController>(builder: (ctl) {
    var customer = ctl.saleOrder!.storeCustomer;
    var name = customer?.customerName;
    if ((customer?.customerName?.length ?? 0) > 6) {
      name = "${customer?.customerName?.substring(0, 5)}...";
    }
    return Container(
      padding: EdgeInsets.fromLTRB(0.w, 25.w, 24.w, 30.w),
      decoration: BoxDecoration(border: Border(top: BorderSide(width: 1.w, color: Color(ColorConfig.color_f5f5f5)))),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (Config.isAndroid) {
                    MethodChannel(ChannelConfig.flutterToNative).invokeMethod(
                      ChannelConfig.methodCustomerDetail,
                      customer!.id,
                    );
                    MethodChannel(ChannelConfig.flutterToNative).invokeMethod(ChannelConfig.methodFinish);
                  } else {
                    MethodChannel(ChannelConfig.flutterToNative).invokeMethod(ChannelConfig.methodFinish);
                    MethodChannel(ChannelConfig.flutterToNative).invokeMethod(
                      ChannelConfig.methodCustomerDetail,
                      customer!.id,
                    );
                  }
                },
                child: Row(
                  children: [
                    customerLogo(customer?.customerName, customer?.levelTag),
                    pSizeBoxW(12.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        pText(name ?? "", ColorConfig.color_333333, 28.w, fontWeight: FontWeight.w600),
                        pSizeBoxH(12.w),
                        pText("欠款 ${PriceUtils.getPrice(customer!.oweAmount)}", ColorConfig.color_999999, 24.w),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  GetBuilder<SaleDetailController>(
                      id: "cancelIcon",
                      builder: (ctl) {
                        return Visibility(
                            visible: ctl.saleOrder!.canceled == CanceledEnum.CANCELED,
                            child: pImage('images/icon_canceled.png', 124.w, 124.w));
                      }),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      //跳转配货记录
                      Map<String, dynamic> param = new Map();
                      param[Constant.ORDER_SALE_ID] = ctl.saleOrder!.id;
                      param[Constant.STOCK_IN_DEPT_ID] = ctl.deptId;
                      Get.toNamed(ArgUtils.map2String(path: Routes.TRANSFER_DISTRIBUTION_RECORD, arguments: param));
                    },
                    child: Visibility(
                        visible: ctl.saleOrder?.configDistribution ==
                                EnumCoverUtils.enumsToString(SaleConfigDistributionEnum.CONFIG_DISTRIBUTION_1_1) &&
                            ctl.saleOrder!.normalSaleNum! > 0 &&
                            ctl.saleOrder!.canceled != CanceledEnum.CANCELED,
                        child: Row(
                          children: [
                            Visibility(
                              visible: ctl.saleOrder!.distributionNum != 0,
                              child: pText("配货未发${ctl.saleOrder!.distributionNum}", ColorConfig.color_ff7f00, 25.w,
                                  height: 38.w,
                                  background: ColorConfig.color_fff2e2,
                                  radius: 4.w,
                                  fontWeight: FontWeight.w500,
                                  padding: EdgeInsets.only(left: 10.w, right: 10.w)),
                            ),
                            pSizeBoxW(8.w),
                            pText("配货记录", ColorConfig.color_999999, 28.w),
                            pImage("images/icon_goto.png", 28.w, 28.w)
                          ],
                        )),
                  )
                ],
              )
            ],
          ),
          GetBuilder<SaleDetailController>(
              id: "orderRemark",
              builder: (ctl) {
                return Visibility(
                  visible: ctl.saleOrder!.remarkList != null && ctl.saleOrder!.remarkList!.length != 0,
                  child: Container(
                    margin: EdgeInsets.only(top: 35.w, left: 24.w, bottom: 20.w),
                    decoration: new BoxDecoration(
                        color: Color(ColorConfig.color_f5f5f5), borderRadius: new BorderRadius.circular((10.w))),
                    child: ListView.builder(
                        itemCount: ctl.saleOrder!.remarkList!.length,
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
                                    ctl.saleOrder!.remarkList![index].createdByName.toString() +
                                        ": " +
                                        ctl.saleOrder!.remarkList![index].remark.toString(),
                                    ColorConfig.color_F3AE1F,
                                    24.w,
                                    softWrap: true,
                                    maxLines: 3,
                                    textAlign: TextAlign.left),
                              ),
                              Visibility(
                                  visible: ctl.customerUserDo!.id == ctl.saleOrder!.remarkList![index].createdBy,
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
                                                  List<int> remarkIds = [ctl.saleOrder!.remarkList![index].id as int];
                                                  var res = await RemarkApi.batchDeleteOrderRemark(remarkIds);
                                                  if (res) {
                                                    ctl.saleOrder!.remarkList!.removeAt(index);
                                                    ctl.update(['orderRemark']);
                                                  }
                                                },
                                              );
                                            });
                                      }))),
                            ],
                          );
                        }),
                  ),
                );
              }),
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
                        remarkParam.orderType = RemarkOrderTypeEnum.ORDER_SALE;
                        remarkParam.remark = value;
                        remarkParam.createdBy = ctl.customerUserDo!.id;
                        remarkParam.createdByName = ctl.customerUserDo!.name;
                        remarkParam.orderId = ctl.saleOrder!.id;
                        RemarkApi.saveOrderRemark(remarkParam).then((v) {
                          RemarkApi.getRemark(ctl.saleOrder!.id as int, RemarkOrderTypeEnum.ORDER_SALE).then((value) {
                            ctl.saleOrder!.remarkList = value
                                .map<SaleDetailDoRemarkList>((e) => new SaleDetailDoRemarkList().fromJson(e.toJson()))
                                .toList();
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

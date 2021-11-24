import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:haidai_flutter_module/page/transfer/distribution/controller/transfer_distribution_controller.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/distribution_salegroup_entity.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/drawer_dialog.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget distributionShopContent(DrawerDialog dialog,
    List<DistributionSalegroupEntity> list, Function closeCallback) {
  print(Get.find<TransferDistributionController>());
  var function = () => dialog.dismiss();
  return Container(
      color: Colors.white,
      height: 800.h,
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: GetBuilder<TransferDistributionController>(builder: (ctl) {
              print(ctl);
              return ListView.builder(
                padding: EdgeInsets.all(8.w),
                itemCount: list.length,
                itemExtent: 92.w,
                itemBuilder: (BuildContext context, int index) {
                  DistributionSalegroupEntity item = list[index];
                  return distributionShopContentItem(ctl, list, index, () {
                    function();
                    closeCallback();
                    // ctl.loadTransferListCount;
                  });
                },
              );
            }),
          ),
          Divider(),
          Expanded(
              flex: 1,
              child:
              GetBuilder<TransferDistributionController>(builder: (ctl) {
                // print(ctl);
                return GestureDetector(
                  onTap: () {
                    // ctl.selectedHisShopId = null;
                    ctl.selectedShopId = null;
                    ctl.loadListCountData();
                    function.call();
                    function();
                    closeCallback();
                    // ctl.loadTransferListCount;
                  },
                  child: Center(
                    child: pText('不选择店铺', ColorConfig.color_666666, 28.w),
                  ),
                );
              }))
        ],
      ));
}

distributionShopContentItem(TransferDistributionController ctl,
    List<DistributionSalegroupEntity> list, int index, Function function) {
  // var customer = ctl.filterCustomer[index];
  // var select = ctl.isSelectCustomer(customer.customer?.id);

  DistributionSalegroupEntity item = list[index];
  String? selectedShopId = ctl.selectedShopId;
  bool isSelected = item.deptId == selectedShopId ? true : false;

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    child: Container(
        margin: EdgeInsets.only(left: 30.w),
        height: 92.w,
        alignment: Alignment.centerLeft,
        child:Row(children: [pText(
            "${item.deptName}  ",
            isSelected ? ColorConfig.color_1678FF : ColorConfig.color_333333,
            28.w,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400),pText(
            "${item.notDistributionNum}单",
            isSelected ? ColorConfig.color_1678FF : ColorConfig.color_999999,
            28.w,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400)],)
        ),
    onTap: () {
      //ctl.updateSelectCustomer(customer.customer!.id!);
      ctl.selectedShopId = item.deptId;
      ctl.loadListCountData();
      function.call();
    },
  );
}

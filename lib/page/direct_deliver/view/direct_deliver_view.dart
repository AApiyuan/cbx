import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/direct_deliver/controller/direct_deliver_controller.dart';
import 'package:haidai_flutter_module/page/direct_deliver/widget/bottom.dart';
import 'package:haidai_flutter_module/page/direct_deliver/widget/customer.dart';
import 'package:haidai_flutter_module/page/direct_deliver/widget/goods_list.dart';
import 'package:haidai_flutter_module/page/direct_deliver/widget/search_bar.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/empty_widget.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_media_query.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class DirectDeliverView extends GetView<DirectDeliverController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: KeyboardMediaQuery(
        child: WillPopScope(
            child: Scaffold(
              appBar: pAppBar("直接发货", backFunc: () => back()),
              backgroundColor: Color(ColorConfig.color_ffffff),
              body: Column(
                children: [
                  customerInfo(),
                  searchBar(),
                  empty(),
                  goodsList(),
                  bottomWidget(),
                ],
              ),
            ),
            onWillPop: () {
              back();
              return Future.value(false);
            }),
      ),
    );
  }

  back() {
    if (controller.orderId != null) {
      BackUtils.back();
    } else if (controller.orderSaleId != null) {
      Get.offNamed(ArgUtils.map2String(
          path: Routes.SALE_DETAIL,
          arguments: {Constant.ORDER_SALE_ID: controller.orderSaleId, Constant.DEPT_ID: controller.deptId}));
    } else {
      BackUtils.back();
    }
  }

  empty() {
    return GetBuilder<DirectDeliverController>(
      builder: (ctl) => Visibility(
        child: emptyWidget(),
        visible: ctl.goodsList.length <= 1,
      ),
      id: DirectDeliverController.idEmpty,
    );
  }
}

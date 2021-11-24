import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/remit/controller/remit_controller.dart';
import 'package:haidai_flutter_module/page/remit/widget/confirm.dart';
import 'package:haidai_flutter_module/page/remit/widget/customer.dart';
import 'package:haidai_flutter_module/page/remit/widget/order_check.dart';
import 'package:haidai_flutter_module/page/remit/widget/order_info.dart';
import 'package:haidai_flutter_module/page/remit/widget/remit_method.dart';
import 'package:haidai_flutter_module/page/remit/widget/sale_check_list.dart';
import 'package:haidai_flutter_module/page/remit/widget/select_sale.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_media_query.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Remit extends GetView<RemitController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: GetBuilder<RemitController>(builder: (ctl) {
      return KeyboardMediaQuery(
          child: Scaffold(
              backgroundColor: Color(ColorConfig.color_f5f5f5),
              appBar: pAppBar("收退/核销", back: true, type: 1, backIconColor: ColorConfig.color_ffffff, backgroundColor: ColorConfig.color_282940, backFunc: () => back()),
              body: CustomScrollView(slivers: <Widget>[
                SliverToBoxAdapter(
                  child: customer(),
                ),
                SliverToBoxAdapter(
                  child: remitMethod(),
                ),
                SliverToBoxAdapter(
                  child: orderInfo(),
                ),
                SliverToBoxAdapter(
                  child: orderCheck(),
                ),
                saleCheckList(),
                SliverToBoxAdapter(
                  child: selectOrder(),
                ),
                SliverToBoxAdapter(child: pSizeBoxH(120.w)),
              ]),
              bottomSheet: SafeArea(
                child: confirm(),
              )));
    }), onWillPop: () {
      back();
      return new Future.value(false);
    });
  }

  back() {
    if (controller.isSaleOrderTo ?? false) {
      Get.offNamed(ArgUtils.map2String(path: Routes.SALE_DETAIL, arguments: {
        Constant.ORDER_SALE_ID: controller.curSaleOrderId,
        Constant.DEPT_ID: controller.deptId
      }));
    } else {
      BackUtils.back();
    }
  }
}

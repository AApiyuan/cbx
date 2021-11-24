import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/sale_operation/controller/sale_operation_controller.dart';
import 'package:haidai_flutter_module/page/sale_operation/widget/sale_operation_list.dart';
import 'package:haidai_flutter_module/page/transfer/center/widget/sliding_segment.dart';
import 'package:haidai_flutter_module/page/transfer/distribution/view/transfer_distribution_record_view.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class SaleOperationView extends GetView<SaleOperationController> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<SaleOperationController>(
            builder: (ctl) {
              return Scaffold(
                  backgroundColor: Color(ColorConfig.color_f5f5f5),
                  appBar: pAppBar('操作记录'),
                  body: saleOperationList());
            }),
        onWillPop: () {
          BackUtils.back();
          return new Future.value(false);
        });

    throw UnimplementedError();
  }
}

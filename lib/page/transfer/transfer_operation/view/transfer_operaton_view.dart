import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/page/transfer/transfer_operation/controller/transfer_operation_controller.dart';
import 'package:haidai_flutter_module/page/transfer/transfer_operation/widget/transfer_operation_list.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:haidai_flutter_module/widget/p_common.dart';

class TransferOperationView extends GetView<TransferOperationController> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<TransferOperationController>(
            builder: (ctl) {
              return Scaffold(
                  backgroundColor: Color(ColorConfig.color_f5f5f5),
                  appBar: pAppBar('操作记录'),
                  body: transferOperationList());
            }),
        onWillPop: () {
          BackUtils.back();
          return new Future.value(false);
        });

    throw UnimplementedError();
  }
}

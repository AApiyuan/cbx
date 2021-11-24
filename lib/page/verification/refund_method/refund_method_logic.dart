import 'dart:convert';

import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';
import 'package:haidai_flutter_module/repository/base/store_remit_method_api.dart';

class RefundMethodLogic extends GetxController {

  List<StoreRemitMethodDoEntity> refundList = jsonDecode(ArgUtils.getArgument("refundString")!);

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();


    print('-看-看-');

    print(this.refundList);

    print('-看-看-');
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

}

import 'package:get/get.dart';

import 'refund_method_logic.dart';

class RefundMethodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RefundMethodLogic());
  }
}

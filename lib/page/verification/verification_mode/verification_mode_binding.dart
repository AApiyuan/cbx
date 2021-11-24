import 'package:get/get.dart';

import 'verification_mode_logic.dart';

class VerificationModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerificationModeLogic());
  }
}

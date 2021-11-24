import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/help/center/controller/help_center_controller.dart';

class HelpCenterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpCenterController());
  }
}
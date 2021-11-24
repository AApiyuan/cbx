import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/direct_deliver/controller/direct_deliver_controller.dart';

class DirectDeliverBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => DirectDeliverController());
  }

}
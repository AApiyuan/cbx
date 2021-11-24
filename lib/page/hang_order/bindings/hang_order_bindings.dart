import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/hang_order/controller/hang_order_controller.dart';

class HangOrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HangOrderController());
  }

}
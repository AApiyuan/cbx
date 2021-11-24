import 'package:get/get.dart';

import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:haidai_flutter_module/page/delivery_detail/controller/delivery_detail_controller.dart';

class DeliveryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeliveryDetailController());
  }
}

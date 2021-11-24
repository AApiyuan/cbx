import 'package:get/get.dart';

import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:haidai_flutter_module/page/sale_detail/controller/sale_detail_controller.dart';

class SaleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SaleDetailController());
  }
}

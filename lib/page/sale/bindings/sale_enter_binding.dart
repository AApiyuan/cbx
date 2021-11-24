

import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';

class SaleEnterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SaleEnterController());
  }

}
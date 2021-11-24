


import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/customer/controller/add_customer_controller.dart';

class AddCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCustomerController());
  }

}
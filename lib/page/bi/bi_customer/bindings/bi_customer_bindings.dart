import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_customer/controller/bi_customer_controller.dart';

class BiCustomerBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => BiCustomerController());
  }

}
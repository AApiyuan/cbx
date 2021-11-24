
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:haidai_flutter_module/page/customer/controller/search_customer_controller.dart';

class SearchCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchCustomerController());
  }

}
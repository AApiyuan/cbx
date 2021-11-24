


import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/customer_profile/controller/customer_profile_controller.dart';

class CustomerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerProfileController());
  }

}
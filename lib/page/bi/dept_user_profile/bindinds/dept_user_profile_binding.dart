


import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/dept_user_profile/controller/dept_user_profile_controller.dart';

class DeptUserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeptUserProfileController());
  }

}
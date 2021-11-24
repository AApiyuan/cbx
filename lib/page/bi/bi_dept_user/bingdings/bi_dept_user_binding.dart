
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_dept_user/controller/bi_dept_user_controller.dart';

class BiDeptUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BiDeptUserController());
  }

}
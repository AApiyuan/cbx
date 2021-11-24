


import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/goods_profile/controller/goods_profile_controller.dart';

class GoodsProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoodsProfileController());
  }

}
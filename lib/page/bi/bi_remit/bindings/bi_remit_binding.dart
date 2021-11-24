


import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit/controller/bi_remit_controller.dart';

class BiRemitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BiRemitController());
  }

}
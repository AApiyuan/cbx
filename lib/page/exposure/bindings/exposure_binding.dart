import 'package:get/get.dart';

import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:haidai_flutter_module/page/exposure/controller/exposure_controller.dart';

class ExposureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExposureController());
  }
}

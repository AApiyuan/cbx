import 'package:get/get.dart';

import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:haidai_flutter_module/page/exposure_record/controller/exposure_record_controller.dart';

class ExposureRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExposureRecordController());
  }
}

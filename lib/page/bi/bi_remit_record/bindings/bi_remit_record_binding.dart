


import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_remit_record/controller/bi_remit_record_controller.dart';

class BiRemitRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BiRemitRecordController());
  }

}
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/gathering_detail/controller/gathering_detail_controller.dart';

class GatheringDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GatheringDetailController());
  }

}
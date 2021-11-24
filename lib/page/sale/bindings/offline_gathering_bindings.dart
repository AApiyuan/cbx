import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/sale/controller/offline_gathering_controller.dart';

class OfflineGatheringBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OfflineGatheringController());
  }

}
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/offline_enter/controller/offline_enter_controller.dart';
class OfflineEnterBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies]
    Get.lazyPut(() => OfflineEnterController());
  }
}
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:haidai_flutter_module/page/transfer/center/controller/transfer_center_selectgood_controller.dart';

class TransferCenterSelectGoodBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies]
    Get.lazyPut(() => TransferCenterSelectGoodController());
  }
}
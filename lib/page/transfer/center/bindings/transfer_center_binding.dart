import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/transfer/center/controller/transfer_center_controller.dart';


class TransferCenterBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies]
    Get.lazyPut(() => TransferCenterController());
  }
}


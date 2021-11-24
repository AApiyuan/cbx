import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/transfer/create/controller/confirm_controller.dart';
import 'package:haidai_flutter_module/page/transfer/create/controller/transfer_controller.dart';

class TransferBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies]
    Get.lazyPut(() => TransferController());
    Get.lazyPut(() => ConfirmController());

  }
}
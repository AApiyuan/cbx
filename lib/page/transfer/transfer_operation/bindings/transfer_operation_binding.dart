import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/transfer/transfer_operation/controller/transfer_operation_controller.dart';

class TransferOperationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransferOperationController());
  }
}

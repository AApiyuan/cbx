import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/transfer/detail/controller/transfer_detail_controller.dart';

class TransferDetailBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies]
    Get.lazyPut(() => TransferDetailController());
  }
}
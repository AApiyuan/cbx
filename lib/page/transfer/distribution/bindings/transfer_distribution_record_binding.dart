import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/transfer/distribution/controller/transfer_distribution_record_controller.dart';

class TransferDistributionRecordBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies]
    Get.lazyPut(() => TransferDistributionRecordController());
  }
}
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/distribution/controller/distribution_controller.dart';

class DistributionBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies]
    Get.lazyPut(() => DistributionController());
  }
}
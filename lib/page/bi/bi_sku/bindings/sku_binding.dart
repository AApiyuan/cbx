
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_sku/controller/sku_controller.dart';

class SkuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SkuController());
  }

}
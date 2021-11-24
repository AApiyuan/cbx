import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/stock/select_stock/controller/select_stock_controller.dart';

class SelectStockBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies]
    Get.lazyPut(() => SelectStockController());
  }
}
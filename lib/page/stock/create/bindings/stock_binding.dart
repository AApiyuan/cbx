import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/stock/create/controller/confim_controller.dart';
import 'package:haidai_flutter_module/page/stock/create/controller/stock_controller.dart';

class StockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StockController());
    Get.lazyPut(() => ConfirmController());
  }
}

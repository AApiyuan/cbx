import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/stock/detail/controller/stock_detail_controller.dart';

class StockDetailBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies]
    Get.lazyPut(() => StockDetailController());
  }
}
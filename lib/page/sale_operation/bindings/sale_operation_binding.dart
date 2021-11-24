import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/sale_operation/controller/sale_operation_controller.dart';
import 'package:haidai_flutter_module/page/stock/create/controller/confim_controller.dart';
import 'package:haidai_flutter_module/page/stock/create/controller/stock_controller.dart';

class SaleOperationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SaleOperationController());
  }
}




import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/controller/bi_sale_controller.dart';
import 'package:haidai_flutter_module/page/bi/bi_sale/controller/bi_sale_detail_controller.dart';

class BiSaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BiSaleController());
    Get.lazyPut(() => BiSaleDetailController());
  }

}
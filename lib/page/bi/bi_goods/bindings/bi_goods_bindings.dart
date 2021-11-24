import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/bi/bi_goods/controller/bi_goods_controller.dart';

class BiGoodsBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => BiGoodsController());
  }

}
import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/goods/controller/goods_list_controller.dart';

class GoodsListBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies]
    Get.lazyPut(() => GoodsListController(), fenix: true);
  }
}

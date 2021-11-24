import 'package:get/get.dart';

import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:haidai_flutter_module/page/remit/controller/remit_method_sort_controller.dart';

class RemitMethodSortBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemitMethodSortController());
  }
}

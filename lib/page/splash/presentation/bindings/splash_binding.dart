import 'package:get/get.dart';

import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:haidai_flutter_module/page/splash/presentation/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}

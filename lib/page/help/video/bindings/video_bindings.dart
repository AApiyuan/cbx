import 'package:get/get.dart';
import 'package:haidai_flutter_module/page/help/video/controller/video_controller.dart';

class VideoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoController());
  }
}
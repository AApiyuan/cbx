import 'package:get/get.dart';

class HomeController extends GetxController {
  int counter = 0;

  void increment() {
    counter++;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    print('HomeController--onInit');
  }

  @override
  void onReady() {
    super.onReady();
    print('HomeController--onReady');
  }

  @override
  void onClose() {
    super.onClose();
    print('HomeController--onClose');
  }
}
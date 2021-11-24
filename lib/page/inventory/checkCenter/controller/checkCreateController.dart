import 'package:get/get.dart';

import 'package:haidai_flutter_module/repository/check_api.dart';

class CheckCenterController extends GetxController{
  int? value;
  static String ids = "checkCreate";

  checkCreate(int deptId){
    CheckApi.checkRecordCreate(deptId).then((value) {
      this.value = value;
      update([ids]);
    }, onError: (e) {
      print("flutter:   error1:$e");
    });
  }

  int getValue(){
    return value!;
  }

  void reset() {
    update();
  }

  @override
  void onInit() {
    super.onInit();
    print('GoodsPageController--onInit');

  }

  @override
  void onReady() {
    super.onReady();
    print('GoodsPageController--onReady');
  }

  @override
  void onClose() {
    super.onClose();
    reset();
    print('GoodsPageController--onClose');
  }
}
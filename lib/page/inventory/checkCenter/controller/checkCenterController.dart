import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/checkCenter/inventory_do_entity.dart';
import 'package:haidai_flutter_module/repository/check_api.dart';

class CheckCenterController extends GetxController {
  int _pageNo = 1; //页码
  int _pageSize = 20; //页数
  InventoryDoEntity inventoryDoEntity = new InventoryDoEntity();

  static String ids = "checkCenter";
  bool noMore = false; //是否需要加载更多
  num? deptId;

  Future checkCenter(num? deptId) async {
    return await CheckApi.checkCenter(deptId).then((value) {
      inventoryDoEntity = value;
      update([ids]);
      return value;
    });
  }

  Future checkDetail(num? hisId) async {
    return await CheckApi.checkDetail(hisId).then((value) {
      inventoryDoEntity = value;
      update([ids]);
    }, onError: (e) {
      print("flutter:   error1:$e");
    });
  }

  InventoryDoEntity getEntity() {
    return inventoryDoEntity;
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

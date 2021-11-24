import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';
import 'package:haidai_flutter_module/repository/base/store_remit_method_api.dart';

class RemitMethodSortController extends SuperController {
  var deptId;

  List<StoreRemitMethodDoEntity> remitMethods = [];

  initRemitMethod() {
    StoreRemitMethodApi.getRemitMethodByDept(deptId).then((value) {
      remitMethods = value;
      update(['methodsList']);
    });
  }

  updateMethods() {
    for (int i = 0; i < remitMethods.length; i++) {
      remitMethods[i].sort = i;
    }
    StoreRemitMethodApi.batchSave(remitMethods, showLoading: true).then((v) {
      if (v) {
        Get.back(result: "refresh");
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    initRemitMethod();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}

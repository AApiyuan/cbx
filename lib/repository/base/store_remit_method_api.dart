import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';

class StoreRemitMethodApi {
  /// 店铺收款方式
  static const _remitMethodByDept = "/base/storeRemitMethod/selectByCustomerDeptId";

  static const _batchSave = "/base/storeRemitMethod/batchSaveOrUpdateStoreDict";

  static Future<List<StoreRemitMethodDoEntity>> getRemitMethodByDept(int deptId, {bool returnUse = false}) async {
    var res = await HttpUtils.get(_remitMethodByDept,
        params: {
          "customerDeptId": deptId,
          "returnUseCustomerDeptNum": returnUse,
        },
        baseUrl: Config.BASE_API_URL,
        showLoading: false);
    return res.map<StoreRemitMethodDoEntity>((e) => new StoreRemitMethodDoEntity().fromJson(e)).toList();
  }

  static Future<bool> batchSave(List<StoreRemitMethodDoEntity> methods, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_batchSave, data: methods, baseUrl: Config.BASE_API_URL, showLoading: showLoading);
    return res;
  }
}

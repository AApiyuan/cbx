import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_do.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_relation_do.dart';

class CustomerDeptApi {
  static const _selectRelation =
      "/base/customerDept/selectRelationByCustomerDeptId";

  static const _selectCustomerDeptByDeptId =
      "/base/customerDept/selectCustomerDeptByDeptId";

  static Future<List<CustomerDeptRelationDo>> selectRelation(num deptId) async {
    var res = await HttpUtils.get(_selectRelation,
        params: {"customerDeptId": deptId},
        baseUrl: Config.BASE_API_URL,
        showLoading: true);
    return res
        .map<CustomerDeptRelationDo>(
            (e) => new CustomerDeptRelationDo().fromJson(e))
        .toList();
  }

  static Future<CustomerDeptDo> selectCustomerDeptByDeptId(int deptId) async {
    var res = await HttpUtils.get(_selectCustomerDeptByDeptId,
        params: {"customerDeptId": deptId},
        baseUrl: Config.BASE_API_URL,
        showLoading: false);
    return new CustomerDeptDo().fromJson(res);
  }
}

import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/db/sql_db.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/store/req/customer_dept_config_req.dart';
import 'package:haidai_flutter_module/model/store/req/store_discount_template_req.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_config_do.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_detail_do.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_do.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_relation_do.dart';
import 'package:haidai_flutter_module/model/store/res/store_discount_template_do.dart';
import 'package:haidai_flutter_module/model/store/res/store_remit_method_do.dart';
import 'package:haidai_flutter_module/model/store_dict_do.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/req/store_dict_req_entity.dart';

class StoreApi {
  /// 店铺配置
  static final String deptConfig = "/base/customerDept/selectCustomerDeptConfigByDeptId";

  ///  店铺 打折模板
  static final String discountTemp = "/base/storeDiscountTemplate/selectByStoreDiscountTemplateReq";

  ///  支付方式
  // static final String remitMethod = "/base/storeDiscountTemplate/selectByStoreDiscountTemplateReq";
  static final String remitMethod = "/base/storeRemitMethod/selectByCustomerDeptId";

  /// 店铺标签
  static final String selectDict = "/base/storeDict/selectByCustomerDeptIdAndType";

  /// 店铺标签
  static final String selectGroupTypeByParam = "/base/storeDict/selectGroupTypeByParam";

  /// 新增或修改店铺数据字典 v0.2.0
  static final String _saveOrUpdateStoreDict = "/base/storeDict/saveOrUpdateStoreDict";

  ///查询店铺数据字典 v0.6.0
  static final String _selectByParam = "base/storeDict/selectByParam";

  /// 获取 关联仓
  static final String relationDept = "/base/customerDept/selectRelationByCustomerDeptId";

  ///获取有权限的店铺
  static final String _selectDeptByLoginCustomerUser = "/base/customerDept/selectByLoginCustomerUser";

  ///获取店铺详情
  static final String _selectCustomerDeptDetailByDeptId = "/base/customerDept/selectCustomerDeptDetailByDeptId";

  //登录人企业 信息
  static final String _selectCompanyByLoginCustomerUser = "/base/customerDept/selectCompanyByLoginCustomerUser";

  static Future<int> saveOrUpdateStoreDict(StoreDictData param) async {
    return await HttpUtils.post(_saveOrUpdateStoreDict, data: param, baseUrl: Config.BASE_API_URL, showLoading: false);
  }

  static Future<List<StoreDictData>> selectByParam(StoreDictReqEntity param) async {
    var res = await HttpUtils.post(_selectByParam, data: param, baseUrl: Config.BASE_API_URL, showLoading: false);
    return res.map<StoreDictData>((e) => new StoreDictData().fromJson(e)).toList();
  }

  static Future<List<CustomerDeptConfigDo>> getDeptConfig(CustomerDeptConfigReq param, {bool online = true}) async {
    if (online) {
      var res = await HttpUtils.post(deptConfig, data: param, baseUrl: Config.BASE_API_URL, showLoading: false);
      return res.map<CustomerDeptConfigDo>((e) => new CustomerDeptConfigDo().fromJson(e)).toList();
    } else {
      if (param.typeList != null) {
        return DeptConfigQuery.select(param.customerDeptId as int, param.groupTypeList as List<String>,
            typeList: param.typeList as List<String>);
      } else {
        return DeptConfigQuery.select(param.customerDeptId as int, param.groupTypeList as List<String>);
      }
    }
  }

  static Future<List<StoreDiscountTemplateDo>> getDiscountTemp(StoreDiscountTemplateReq param,
      {bool online = true}) async {
    if (online) {
      var res = await HttpUtils.post(discountTemp, data: param, baseUrl: Config.BASE_API_URL, showLoading: false);
      return res.map<StoreDiscountTemplateDo>((e) => new StoreDiscountTemplateDo().fromJson(e)).toList();
    } else {
      return DiscountQuery.select(param);
    }
  }

  static Future<List<StoreRemitMethodDo>> getRemitMethod(int deptId, bool returnUseCustomerDeptNum,
      {bool online = true}) async {
    if (online) {
      var param = {
        "customerDeptId": deptId,
        "returnUseCustomerDeptNum": returnUseCustomerDeptNum,
      };

      var res = await HttpUtils.get(remitMethod, params: param, baseUrl: Config.BASE_API_URL, showLoading: false);
      return res.map<StoreRemitMethodDo>((e) => new StoreRemitMethodDo().fromJson(e)).toList();
    } else {
      return RemitQuery.select(deptId);
    }
  }

  static Future<List<StoreDictData>> getDeptDict(num customerDeptId, String dictType,
      {bool returnDisable = false}) async {
    var res = await HttpUtils.get(selectDict,
        baseUrl: Config.BASE_API_URL,
        params: {"customerDeptId": customerDeptId, "dictType": dictType, "returnDisable": returnDisable});
    return res.map<StoreDictData>((e) => new StoreDictData().fromJson(e)).toList();
  }

  static Future<Map> getDeptDictByParam(num customerDeptId, List<String> dictType,
      {String status = 'ENABLE'}) async {
    var res = await HttpUtils.post(selectGroupTypeByParam,
        baseUrl: Config.BASE_API_URL,
        data: {"customerDeptId": customerDeptId, "dictTypeList": dictType, "status": status});
    return res;
  }

  static Future<List<CustomerDeptRelationDo>> getDeptRelation(num customerDeptId, {bool showLoading = false}) async {
    var res =
        await HttpUtils.get(relationDept, baseUrl: Config.BASE_API_URL, params: {"customerDeptId": customerDeptId});
    return res.map<CustomerDeptRelationDo>((e) => new CustomerDeptRelationDo().fromJson(e)).toList();
  }

  static Future<List<CustomerDeptRelationDo>> selectDeptByLoginCustomerUser(num customerDeptId,
      {bool showLoading = false}) async {
    var res = await HttpUtils.get(_selectDeptByLoginCustomerUser,
        baseUrl: Config.BASE_API_URL, params: {"customerDeptId": customerDeptId});
    return res.map<CustomerDeptRelationDo>((e) => new CustomerDeptRelationDo().fromJson(e)).toList();
  }

  static Future<CustomerDeptDetailDo> selectDeptDetail(num customerDeptId) async {
    var res = await HttpUtils.get(_selectCustomerDeptDetailByDeptId,
        baseUrl: Config.BASE_API_URL, params: {"customerDeptId": customerDeptId});
    return new CustomerDeptDetailDo().fromJson(res);
  }

  static Future<CustomerDeptDo> selectCompanyByLoginCustomerUser() async {
    var res = await HttpUtils.get(
      _selectCompanyByLoginCustomerUser,
      baseUrl: Config.BASE_API_URL,
    );
    return new CustomerDeptDo().fromJson(res);
  }
}

import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/db/sql_db.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/page/customer/model/rep/store_customer_create_req_entity.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/exposure_record/model/customer_risk_article_entity.dart';
import 'package:haidai_flutter_module/page/verification/model/customer_statistic_entity.dart';

class CustomerApi {
  /// 跟单人列表（店铺id查询）
  static final String _page = "/base/customer/page";

  /// 创建用户
  static final String _create = "/base/customer/create";

  /// 修改客户
  static final String _update = "/base/customer/update";

  /// 获取用户
  static final String _getCustomer = "/base/customer/";

  /// 零售客
  static final String _getRetailStoreCustomer =
      "base/customer/getRetailStoreCustomer";

  // 获取客户主页的统计数据信息
  static final String _getCustomerStatistic =
      "/base/customer/getCustomerStatistic/";

  //新增客户风险文章
  static final String _addCustomerRiskArticle =
      "/base/customer/addCustomerRiskArticle/";
  //分页查询客户风险文章
  static final String _getCustomerRiskArticle =
      "/base/customer/selectCustomerRiskArticleByPage/";

  // 分页查询客户风险文章总条数信息 v0.9.5
  static final String _selectCustomerRiskArticleByPageCount =
      "/base/customer/selectCustomerRiskArticleByPageCount";

  static Future<int> selectCustomerRiskArticleByPageCount(dynamic param) async {
    return await HttpUtils.post(_selectCustomerRiskArticleByPageCount,
        data: param, baseUrl: Config.BASE_API_URL, showLoading: false);
  }

  static Future<CustomerStatisticEntity> getCustomerStatistic(dynamic param,
      {bool showLoading = false}) async {
    var res = await HttpUtils.get("$_getCustomerStatistic?customerId=$param",
        baseUrl: Config.BASE_API_URL, showLoading: showLoading);
    return CustomerStatisticEntity().fromJson(res);
  }

  static Future<List<StoreCustomerListItemDoEntity>> customerPage(dynamic param,
      {bool online = true}) async {
    if (online) {
      var res = await HttpUtils.post(_page,
          data: param, baseUrl: Config.BASE_API_URL, showLoading: false);
      return res
          .map<StoreCustomerListItemDoEntity>(
              (e) => new StoreCustomerListItemDoEntity().fromJson(e))
          .toList();
    } else {
      return CustomerQuery.select(basePage: param);
    }
  }

  static Future<int> createCustomer(StoreCustomerCreateReqEntity param,
      {bool online = true, int? customerId}) async {
    if (online) {
      var res = await HttpUtils.post(_create,
          data: param, baseUrl: Config.BASE_API_URL, showLoading: true);
      return res;
    } else {
      if (customerId != null) {
        CustomerQuery.delete(deptId: param.deptId, customerId: customerId);
      }
      var data = StoreCustomerListItemDoEntity();
      data.deptId = param.deptId;
      data.customerPhone = param.customerPhone;
      data.customerName = param.customerName;
      data.levelTag = param.levelTag;
      data.status = param.status;
      data.star = param.star;
      data.offline = 1;
      data.id = customerId ?? DateTime.now().millisecondsSinceEpoch;
      CustomerQuery.batchInsert([data]);
      return data.id!;
    }
  }

  static Future<bool> updateCustomer(StoreCustomerCreateReqEntity param) async {
    var res = await HttpUtils.post(_update,
        data: param, baseUrl: Config.BASE_API_URL, showLoading: true);
    return res;
  }

  static Future<StoreCustomerListItemDoEntity> getCustomer(dynamic param,
      {bool showLoading = false, bool online = true}) async {
    if (online) {
      var res = await HttpUtils.get("$_getCustomer$param",
          baseUrl: Config.BASE_API_URL, showLoading: showLoading);
      return StoreCustomerListItemDoEntity().fromJson(res);
    } else {
      return await CustomerQuery.select(id: param).then((value) => value[0]);
    }
  }

  static Future<StoreCustomerListItemDoEntity> getRetailStoreCustomer(
      dynamic param,
      {bool showLoading = true,
      bool online = true}) async {
    if (online) {
      var res = await HttpUtils.get(_getRetailStoreCustomer,
          params: {"customerDeptId": param},
          baseUrl: Config.BASE_API_URL,
          showLoading: showLoading);
      return StoreCustomerListItemDoEntity().fromJson(res);
    } else {
      return CustomerQuery.getRetailStoreCustomer(param);
    }
  }

  static Future<List<CustomerRiskArticleEntity>> getCustomerRiskArticle(
      dynamic param,
      {bool showLoading = true, bool online = true}) async {
    var res = await HttpUtils.post(_getCustomerRiskArticle,
        data: param,
        baseUrl: Config.BASE_API_URL,
        showLoading: showLoading);
    return res
        .map<CustomerRiskArticleEntity>(
            (e) => new CustomerRiskArticleEntity().fromJson(e))
        .toList();


  }

  static Future<bool> addCustomerRiskArticle(
      dynamic param,
      {bool showLoading = true}) async {
    var res = await HttpUtils.post(_addCustomerRiskArticle,
        data: param,
        baseUrl: Config.BASE_API_URL,
        showLoading: showLoading);
    return res;
  }
}

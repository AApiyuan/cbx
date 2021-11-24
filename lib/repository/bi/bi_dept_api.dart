import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/enum/customer_dept_status.dart';
import 'package:haidai_flutter_module/model/enum/customer_dept_type.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/store/req/dept_and_relation_req.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_detail_and_role_do.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_customer_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_goods_shortage_page_req_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_total_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_goods_shortage_group_dept_do_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_goods_stock_do_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_goods_stock_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_group_customer_do_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_dept_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_dept_user_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_time_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_sum_do.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';

class BiDeptApi {
  static final String _selectSaleGroupTime = "/bi/sale/selectSaleGroupTime";
  static final String _selectStockByPageSum = "/bi/goods/selectStockByPageSum";
  static final String _selectShortageByPageSum = "/bi/goods/selectShortageByPageSum";
  static final String _selectStockByPage = "/bi/goods/selectStockByPage"; //BI 分页查询商品库存信息
  static final String _selectShortageByPage = "/bi/goods/selectShortageByPage"; //BI 分页查询欠货商品信息
  static final String _selectCustomerTotal = "/bi/customer/selectTotal";
  static final String _selectSaleByPageSum = "/bi/sale/selectSaleByPageSum";
  static final String _selectRemitByPageSum = "/bi/remit/selectRemitByPageSum";
  static final String _selectSaleGroupDeptUser = "/bi/sale/selectSaleGroupDeptUser";
  static final String _getDeptSelected = "/bi/config/getDeptSelected";
  static final String _setDeptSelected = "/bi/config/setDeptSelected";
  static final String _selectSaleGroupDept = "/bi/sale/selectSaleGroupDept"; //查询销售单按店铺汇总
  static final String _selectRemitGroupDept = "/bi/remit/selectRemitGroupDept"; //查询收支按店铺汇总
  static final String _selectCustomerGroupDept = "/bi/customer/selectCustomerGroupDept"; //客户欠款
  static final String _selectStockGroupDept = "/bi/goods/selectStockGroupDept"; //库存
  static final String _selectShortageGroupDept = "/bi/goods/selectShortageGroupDept"; //BI 查询欠货商品按店铺汇总信息
  static final String _selectGoodsNewSaleNumGroupDept = "/bi/goods/selectGoodsNewSaleNumGroupDept"; //上新

  static final String _selectRemitGroupCustomerByPage = "/bi/remit/selectRemitGroupCustomerByPage"; //BI 分页查询收退款单按客户汇总

  //BI 分页查询收退款单按客户汇总
  static Future<List<BiRemitGroupCustomerDoEntity>> selectRemitGroupCustomerByPage(BasePage param) async {
    var res = await HttpUtils.post(_selectRemitGroupCustomerByPage, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiRemitGroupCustomerDoEntity>((e) => new BiRemitGroupCustomerDoEntity().fromJson(e)).toList();
  }

  //BI 查询销售单按时间汇总
  static Future<List<BiSaleGroupTimeDo>> selectSaleGroupTime(dynamic param) async {
    var res = await HttpUtils.post(_selectSaleGroupTime, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGroupTimeDo>((e) => new BiSaleGroupTimeDo().fromJson(e)).toList();
  }

  //获取库存
  static Future<BiGoodsStockSumDo> selectStockByPageSum(BasePage param) async {
    var res = await HttpUtils.post(_selectStockByPageSum, data: param, baseUrl: Config.BI_API_URL);
    return new BiGoodsStockSumDo().fromJson(res);
  }

  //获取欠货
  static Future<int> selectShortageByPageSum(BasePage param) async {
    var res = await HttpUtils.post(_selectShortageByPageSum, data: param, baseUrl: Config.BI_API_URL);
    return res;
  }

  //BI 分页查询商品库存信息
  static Future<List<BiGoodsStockDoEntity>> selectStockByPage(BasePage param) async {
    var res = await HttpUtils.post(_selectStockByPage, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiGoodsStockDoEntity>((e) => new BiGoodsStockDoEntity().fromJson(e)).toList();
  }

  //BI 分页查询欠货商品信息
  static Future<List<BiGoodsStockDoEntity>> selectShortageByPage(BasePage param) async {
    var res = await HttpUtils.post(_selectShortageByPage, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiGoodsStockDoEntity>((e) => new BiGoodsStockDoEntity().fromJson(e)).toList();
  }

  //获取客户统计信息
  static Future<BiCustomerTotalDo> selectCustomerTotal(BiCustomerPageReq param) async {
    var res = await HttpUtils.post(_selectCustomerTotal, data: param, baseUrl: Config.BI_API_URL);
    return new BiCustomerTotalDo().fromJson(res);
  }

  //查询销售单汇总信息
  static Future<BiSaleSumDo> selectSaleByPageSum(BasePage param) async {
    var res = await HttpUtils.post(_selectSaleByPageSum, data: param, baseUrl: Config.BI_API_URL);
    return new BiSaleSumDo().fromJson(res);
  }

  //查询收款汇总信息
  static Future<BiRemitSumDo> selectRemitByPageSum(BasePage param) async {
    var res = await HttpUtils.post(_selectRemitByPageSum, data: param, baseUrl: Config.BI_API_URL);
    return new BiRemitSumDo().fromJson(res);
  }

  //员工销售
  static Future<List<BiSaleGroupDeptUserDo>> selectSaleGroupDeptUser(dynamic param) async {
    var res = await HttpUtils.post(_selectSaleGroupDeptUser, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGroupDeptUserDo>((e) => new BiSaleGroupDeptUserDo().fromJson(e)).toList();
  }

  //获取选择的店铺
  static Future<List<int>> getDeptSelected({bool showOnlyHasAuth = true, bool showLoading = false}) async {
    if (showOnlyHasAuth) {
      DeptAndRelationReq deptAndRelationReq = new DeptAndRelationReq();
      deptAndRelationReq.deptTypes = [CustomerDeptTypeEnum.SHOP_AND_STOREHOUSE];
      deptAndRelationReq.returnRelation = false;
      deptAndRelationReq.returnRoleName = false;
      deptAndRelationReq.status = CustomerDeptStatusEnum.ENABLE;
      List<CustomerDeptDetailAndRoleDo> depts = await UserApi.selectByLoginCustomerUserAndAppBi(deptAndRelationReq);

      List<int> deptIds = [];
      if (depts.length == 0) {
        return [];
      } else {
        depts.forEach((element) {
          deptIds.add(element.id as int) ;
        });
      }

      var res = await HttpUtils.post(_getDeptSelected, baseUrl: Config.BI_API_URL);
      List<int> selectedDeptIds = res.map<int>((e) => e as int).toList();

      return deptIds.where((element) => selectedDeptIds.contains(element)).toList() as List<int>;
    } else {
      var res = await HttpUtils.post(_getDeptSelected, baseUrl: Config.BI_API_URL);
      return res.map<int>((e) => e as int).toList();
    }
  }

  static Future<bool> setDeptSelected(List<int> ids, {bool showLoading = false}) async {
    String str = "";
    for (int i = 0; i < ids.length; i++) {
      if (i != ids.length - 1) {
        str += ids[i].toString() + ",";
      } else {
        str += ids[i].toString();
      }
    }
    var res = await HttpUtils.get(_setDeptSelected, params: {"deptIds": str}, baseUrl: Config.BI_API_URL);
    return res;
  }

  //查询销售单按店铺汇总
  static Future<List<BiSaleGroupDeptDo>> selectSaleGroupDept(dynamic param) async {
    var res = await HttpUtils.post(_selectSaleGroupDept, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGroupDeptDo>((e) => new BiSaleGroupDeptDo().fromJson(e)).toList();
  }

  //查询收支按店铺汇总
  static Future<List<BiSaleGroupDeptDo>> selectRemitGroupDept(dynamic param) async {
    var res = await HttpUtils.post(_selectRemitGroupDept, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGroupDeptDo>((e) => new BiSaleGroupDeptDo().fromJson(e)).toList();
  }

  //查询客户余额
  static Future<List<BiSaleGroupDeptDo>> selectCustomerGroupDept(dynamic param) async {
    var res = await HttpUtils.post(_selectCustomerGroupDept, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGroupDeptDo>((e) => new BiSaleGroupDeptDo().fromJson(e)).toList();
  }

  //查询店铺库存
  static Future<List<BiSaleGroupDeptDo>> selectStockGroupDept(dynamic param) async {
    var res = await HttpUtils.post(_selectStockGroupDept, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGroupDeptDo>((e) => new BiSaleGroupDeptDo().fromJson(e)).toList();
  }

  //BI 查询欠货商品按店铺汇总信息
  static Future<List<BiGoodsShortageGroupDeptDoEntity>> selectShortageGroupDept(BiGoodsShortagePageReqEntity param) async {
    var res = await HttpUtils.post(_selectShortageGroupDept, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiGoodsShortageGroupDeptDoEntity>((e) => new BiGoodsShortageGroupDeptDoEntity().fromJson(e)).toList();
  }

  //查询店铺库存
  static Future<List<BiSaleGroupDeptDo>> selectGoodsNewSaleNumGroupDept(dynamic param) async {
    var res = await HttpUtils.post(_selectGoodsNewSaleNumGroupDept, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGroupDeptDo>((e) => new BiSaleGroupDeptDo().fromJson(e)).toList();
  }
}

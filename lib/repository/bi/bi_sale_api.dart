import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_goods_page_req.dart';
import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_goods_page_req_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_customer_do_entity.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_dept_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_goods_classify_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_goods_id_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_time_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_sum_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_sum_do.dart';

class BiSaleApi {
  static final String _selectSaleByPageSum = "/bi/sale/selectSaleByPageSum"; //BI 分页查询销售单汇总信息
  static final String _selectSaleGoodsGroupCustomerByPage = "/bi/sale/selectSaleGoodsGroupCustomerByPage"; //BI 分页查询销售单货品按客户汇总
  static final String _selectSaleGoodsGroupGoodsIdByPage = "/bi/sale/selectSaleGoodsGroupGoodsIdByPage"; //BI 分页查询销售单货品信息 按货品ID分组
  static final String _selectSaleGoodsGroupTime = "/bi/sale/selectSaleGoodsGroupTime"; //BI 查询销售单货品按时间汇总
  static final String _selectSaleGoodsByPageSum = "/bi/sale/selectSaleGoodsByPageSum"; //BI 分页查询销售单货品汇总信息
  static final String _selectSaleGoodsGroupDept = "/bi/sale/selectSaleGoodsGroupDept"; //BI 分页查询销售单货品汇总信息
  static final String _selectSaleGoodsGroupGoodsClassify = "/bi/sale/selectSaleGoodsGroupGoodsClassify"; //BI 分页查询销售单货品汇总信息

  //BI 分页查询销售单汇总信息
  static Future<BiSaleSumDo> selectSaleByPageSum(BasePage param) async {
    var res = await HttpUtils.post(_selectSaleByPageSum, data: param, baseUrl: Config.BI_API_URL);
    return BiSaleSumDo().fromJson(res);
  }

  //BI 分页查询销售单货品按客户汇总
  static Future<List<BiSaleGoodsGroupCustomerDoEntity>> selectSaleGoodsGroupCustomerByPage(BasePage param) async {
    var res = await HttpUtils.post(_selectSaleGoodsGroupCustomerByPage, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGoodsGroupCustomerDoEntity>((e) => new BiSaleGoodsGroupCustomerDoEntity().fromJson(e)).toList();
  }

  //BI 分页查询销售单货品信息 按货品ID分组
  static Future<List<BiSaleGoodsGroupGoodsIdDo>> selectSaleGoodsGroupGoodsIdByPage(BasePage param) async {
    var res = await HttpUtils.post(_selectSaleGoodsGroupGoodsIdByPage, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGoodsGroupGoodsIdDo>((e) => new BiSaleGoodsGroupGoodsIdDo().fromJson(e)).toList();
  }

  static Future<List<BiSaleGoodsGroupTimeDo>> selectSaleGoodsGroupTime(BiSaleGoodsPageReq param) async {
    var res = await HttpUtils.post(_selectSaleGoodsGroupTime, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGoodsGroupTimeDo>((e) => new BiSaleGoodsGroupTimeDo().fromJson(e)).toList();
  }

  //BI 分页查询销售单货品汇总信息
  static Future<BiSaleGoodsSumDo> selectSaleGoodsByPageSum(BasePage param) async {
    var res = await HttpUtils.post(_selectSaleGoodsByPageSum, data: param, baseUrl: Config.BI_API_URL);
    return BiSaleGoodsSumDo().fromJson(res);
  }

  static Future<List<BiSaleGoodsGroupDeptDo>> selectSaleGoodsGroupDept(BiSaleGoodsPageReq param) async {
    var res = await HttpUtils.post(_selectSaleGoodsGroupDept, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGoodsGroupDeptDo>((e) => new BiSaleGoodsGroupDeptDo().fromJson(e)).toList();
  }

  static Future<List<BiSaleGoodsGroupGoodsClassifyDo>> selectSaleGoodsGroupGoodsClassify(BiSaleGoodsPageReqEntity param) async {
    var res = await HttpUtils.post(_selectSaleGoodsGroupGoodsClassify, data: param, baseUrl: Config.BI_API_URL);
    return res.map<BiSaleGoodsGroupGoodsClassifyDo>((e) => new BiSaleGoodsGroupGoodsClassifyDo().fromJson(e)).toList();
  }
}

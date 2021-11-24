import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/page/stock/model/req/batch_stock_rep.dart';
import 'package:haidai_flutter_module/page/stock/model/req/order_stock_update_dto.dart';
import 'package:haidai_flutter_module/page/stock/model/res/order_stock_new_do.dart';

class StockApi {
  /// ===
  static final String _detail = "/order/stock/detail";
  static final String _list = "/order/stock/page";
  static final String _create = "order/stock/create";
  static final String _update = "order/stock/update";
  static final String _updateRemark = "/order/stock/updateInfo";
  static final String _cancel = "/order/stock/cancel/";

  static Future<OrderStockNewDo> orderStockDetail(int id, {bool getAllSku = false, bool toPositive = false, bool showLoading = false}) async {
    Map<String, dynamic> param = new Map();
    param['id'] = id;
    param['getAllSku'] = getAllSku;
    param['toPositive'] = toPositive;
    var res = await HttpUtils.get(_detail, params: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return OrderStockNewDo().fromJson(res);
  }

  //库存单列表
  static Future<List<OrderStockNewDo>> page(BasePage param, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_list, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res.map<OrderStockNewDo>((e) => new OrderStockNewDo().fromJson(e)).toList();
  }

  //创建库存单
  static Future<int> createStock(BatchStockRep param, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_create, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res;
  }

  //撤销库存单
  static Future<bool> cancel(int id, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_cancel + id.toString(), baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res;
  }

  //创建或者修改库存单
  static Future<int> updateStock(BatchStockRep param, {bool showLoading = false}) async {
    var res;
    if (param.id != null) {
      res = await HttpUtils.post(_update, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    } else {
      res = await HttpUtils.post(_create, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    }
    return res;
  }

  //修改备注
  static Future<bool> updateRemark(OrderStockUpdateDto param, {bool showLoading = false}) async {
    var res = await HttpUtils.post(_updateRemark, data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoading);
    return res;
  }
}

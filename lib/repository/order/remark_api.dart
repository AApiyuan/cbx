import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/customer_user_do.dart';
import 'package:haidai_flutter_module/model/remark.dart';
import 'package:haidai_flutter_module/model/store/req/store_discount_template_req.dart';
import 'package:haidai_flutter_module/model/store/res/store_discount_template_do.dart';

class RemarkApi {
  /// 批量删除单据备注
  static final String _batchDeleteOrderRemark = "/order/remark/batchDelete";

  ///  新增单据备注
  static final String _saveOrderRemark = "/order/remark/save";

  /// 查询订单单据
  static final String _getRemark = "/order/remark/selectByOrderIdAndOrderType";

  static Future<bool> batchDeleteOrderRemark(List<int> remarkIds) async {
    var res = await HttpUtils.post(_batchDeleteOrderRemark, data: remarkIds, baseUrl: Config.ORDER_API_URL, showLoading: false);
    return res;
  }

  static Future<bool> saveOrderRemark(Remark param) async {
    var res = await HttpUtils.post(_saveOrderRemark, data: param, baseUrl: Config.ORDER_API_URL, showLoading: false);
    return res;
  }

  static Future<List<Remark>> getRemark(int orderId, String orderType) async {
    Map<String, Object> param = new Map();
    param['orderId'] = orderId;
    param['orderType'] = orderType;
    var res = await HttpUtils.get(_getRemark, params: param, baseUrl: Config.ORDER_API_URL, showLoading: false);
    return res.map<Remark>((e) => new Remark().fromJson(e)).toList();
  }
}

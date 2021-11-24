import 'package:dio_log/dio_log.dart';
import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/req/delivery_create_delivery_req_entity.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/res/delivery_detail_do_entity.dart';

class DeliveryApi {
  /// 创建发货单 v0.3.0 -> v0.8.0
  static final String _createDelivery = "/order/delivery/createDelivery";

  /// 修改发货单
  static final String _updateDelivery = "/order/delivery/updateDelivery";

  /// 检测是否超库存
  static final String _batchCheckDeliveryStock = "/order/delivery/batchCheckDeliveryStock";

  static Future<bool> batchCheckDeliveryStock(
      DeliveryCreateDeliveryReqEntity param) async {
    var res = await HttpUtils.post(
      _batchCheckDeliveryStock,
      data: [param.toJson()],
      baseUrl: Config.ORDER_API_URL,
      showLoading: true,
    );
    return res;
  }

  static Future<int> createDelivery(
      DeliveryCreateDeliveryReqEntity param) async {
    return await HttpUtils.post(
      _createDelivery,
      data: param,
      baseUrl: Config.ORDER_API_URL,
      showLoading: true,
    );
  }

  static Future<DeliveryDetailDoEntity> updateDelivery(
      DeliveryCreateDeliveryReqEntity param) async {
    var res = await HttpUtils.post(
      _updateDelivery,
      data: param,
      baseUrl: Config.ORDER_API_URL,
      showLoading: true,
    );
    return DeliveryDetailDoEntity().fromJson(res);
  }
}

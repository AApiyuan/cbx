import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/page/gathering_detail/model/remit_detail_do_entity.dart';
import 'package:haidai_flutter_module/page/gathering_detail/model/req/remit_method_update_req_entity.dart';
import 'package:haidai_flutter_module/page/gathering_detail/model/req/update_remit_base_req_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/remit_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/req/create_remit_req_entity.dart';

class RemitApi {
  /// 创建收退款单 v0.4.0
  static const _createRemit = "/order/remit/createRemit";
  /// 查看单个发货单详情 v0.3.0
  static const _getRemitDetail = "/order/remit/selectDetailById";
  /// 撤销收退款单 v0.4.0
  static const _cancelRemit = "/order/remit/canceledRemit";
  /// 更新收退款支付方式
  static const _updateRemitMethod = "/order/remit/updateStoreRemitMethod";
  /// 收退款单修改基础信息 v0.4.0
  static const _updateRemitBase = "/order/remit/updateRemitBase";

  static Future<RemitDoEntity> createRemit(
      CreateRemitReqEntity param,{bool showLoading = false}) async {
    var res = await HttpUtils.post(
      _createRemit,
      data: param,
      baseUrl: Config.ORDER_API_URL,
      showLoading: showLoading,
    );
    return RemitDoEntity().fromJson(res);
  }

  static Future<bool> updateRemitBase(UpdateRemitBaseReqEntity param) async {
    return await HttpUtils.post(
      _updateRemitBase,
      data: param,
      baseUrl: Config.ORDER_API_URL,
      showLoading: true,
    );
  }

  static Future<bool> updateRemitMethod(RemitMethodUpdateReqEntity param) async {
    return await HttpUtils.post(
      _updateRemitMethod,
      data: param,
      baseUrl: Config.ORDER_API_URL,
      showLoading: true,
    );
  }

  static Future<RemitDetailDoEntity> getRemitDetail(int orderRemitId) async {
    var res = await HttpUtils.get(
      _getRemitDetail,
      params: {"orderRemitId": orderRemitId},
      baseUrl: Config.ORDER_API_URL,
      showLoading: true,
    );
    return RemitDetailDoEntity().fromJson(res);
  }

  static Future<bool> cancelRemit(int orderRemitId) async {
    var res = await HttpUtils.get(
      _cancelRemit,
      params: {"orderRemitId": orderRemitId},
      baseUrl: Config.ORDER_API_URL,
      showLoading: true,
    );
    return res;
  }
}

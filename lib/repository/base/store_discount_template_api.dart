import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/store/req/store_discount_template_req.dart';
import 'package:haidai_flutter_module/model/store/res/store_discount_template_do.dart';

class StoreDiscountTemplateApi {
  /// 查询店铺优惠模板 v0.4.0
  static final String _selectByStoreDiscountTemplateReq =
      "/base/storeDiscountTemplate/selectByStoreDiscountTemplateReq";

  static Future<List<StoreDiscountTemplateDo>> getDiscountTemplate(StoreDiscountTemplateReq param) async {
    var res = await HttpUtils.post(_selectByStoreDiscountTemplateReq,
        data: param, baseUrl: Config.BASE_API_URL, showLoading: false);
    return res
        .map<StoreDiscountTemplateDo>(
            (e) => new StoreDiscountTemplateDo().fromJson(e))
        .toList();
  }
}

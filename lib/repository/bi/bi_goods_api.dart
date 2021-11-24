import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_goods_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_group_remit_method_id_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_group_time_do.dart';
import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_group_dept_user_do.dart';

class BiGoodsApi {
  static final String _selectGoodsSkuByParam = "/bi/goods/selectGoodsSkuByParam"; //BIBI 查询商品以及商品SKU信息

  //员工销售
  static Future<BiGoodsDo> selectGoodsSkuByParam(int topDeptId, int goodsId, {List<int>? customerDeptIds}) async {
    Map<String, Object> param = new Map();
    param['topDeptId'] = topDeptId;
    param['goodsId'] = goodsId;
    if (customerDeptIds!= null) {
      param['customerDeptIds'] = customerDeptIds;
    }
    var res = await HttpUtils.post(_selectGoodsSkuByParam, data: param, baseUrl: Config.BI_API_URL);
    return new BiGoodsDo().fromJson(res);
  }
}

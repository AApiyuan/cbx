import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class InventoryGoodsSkuReqEntity with JsonConvert<InventoryGoodsSkuReqEntity> {
  int? orderInventoryId;
  int? goodsId;
  String? orderGoodsType;
  bool? getAllSku;
}

import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class InventoryRecordUpdateReqEntity with JsonConvert<InventoryRecordUpdateReqEntity> {
	int? id;
	late List<InventoryRecordUpdateReqGoodsList> goodsList;
}

class InventoryRecordUpdateReqGoodsList with JsonConvert<InventoryRecordUpdateReqGoodsList> {
	int? goodsId;
	int? id;
	late List<InventoryRecordUpdateReqGoodsListSkuList> skuList;
}

class InventoryRecordUpdateReqGoodsListSkuList with JsonConvert<InventoryRecordUpdateReqGoodsListSkuList> {
	int? skuId;
	int? id;
	int? goodsNum;
}

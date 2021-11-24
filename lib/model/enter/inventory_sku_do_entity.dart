import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class InventorySkuDoEntity with JsonConvert<InventorySkuDoEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	dynamic updatedBy;
	dynamic createdByName;
	dynamic updatedByName;
	int? orderInventoryId;
	int? orderInventoryRecordId;
	int? goodsId;
	int? skuId;
	int? goodsNum;
	String? orderGoodsType;
	int? stockNum;
	int? substandardNum;
}

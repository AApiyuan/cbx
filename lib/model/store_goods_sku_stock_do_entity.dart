import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class StoreGoodsSkuStockDoEntity with JsonConvert<StoreGoodsSkuStockDoEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? deptId;
	int? topDeptId;
	int? goodsId;
	int? skuId;
	int? stockNum;
	int? substandardNum;
}

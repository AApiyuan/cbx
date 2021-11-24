import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class InventoryGoodsSku with JsonConvert<InventoryGoodsSku> {
	int? orderInventoryId;
	int? goodsId;
	String? orderGoodsType;
	bool? getAllSku;
}

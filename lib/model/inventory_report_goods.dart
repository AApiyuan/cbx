import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class InventoryReportGoods with JsonConvert<InventoryReportGoods> {
	int? id;
	int? orderInventoryId;
	InventoryReportGoodsStoreGoodsBaseDo? storeGoodsBaseDo;
	int? goodsId;
	int? snapStock;
	int? inventoryStock;
	int? loss;
	int? profit;
}

class InventoryReportGoodsStoreGoodsBaseDo with JsonConvert<InventoryReportGoodsStoreGoodsBaseDo> {
	int? id;
	String? goodsSerial;
	String? goodsNameSerial;
	String? imgPath;
	String? cover;
	String? goodsName;
}

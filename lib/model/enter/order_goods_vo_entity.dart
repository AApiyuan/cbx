import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class OrderGoodsVoEntity with JsonConvert<OrderGoodsVoEntity> {
	OrderGoodsVoGoodsColor? goodsColor;
	List<OrderGoodsVoSize>? sizes;
}

class OrderGoodsVoGoodsColor with JsonConvert<OrderGoodsVoGoodsColor> {
	int? id;
	String? name;
	String? code;
	int? sort;
}

class OrderGoodsVoSize with JsonConvert<OrderGoodsVoSize> {
	late OrderGoodsVoSizesGoodsSize goodsSize;
	late OrderGoodsVoSizesData data;
}

class OrderGoodsVoSizesGoodsSize with JsonConvert<OrderGoodsVoSizesGoodsSize> {
	int? id;
	String? name;
	String? code;
	int? sort;
}

class OrderGoodsVoSizesData with JsonConvert<OrderGoodsVoSizesData> {
	int? goodsId;
	int? skuId;
	int? snapStock;
	dynamic inventoryStock;
}

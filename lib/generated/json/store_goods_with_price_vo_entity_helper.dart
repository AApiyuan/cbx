import 'package:haidai_flutter_module/page/sale/model/store_goods_with_price_vo_entity.dart';

storeGoodsWithPriceVoEntityFromJson(StoreGoodsWithPriceVoEntity data, Map<String, dynamic> json) {
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['sailingPrice'] != null) {
		data.sailingPrice = json['sailingPrice'] is String
				? int.tryParse(json['sailingPrice'])
				: json['sailingPrice'].toInt();
	}
	if (json['takingPrice'] != null) {
		data.takingPrice = json['takingPrice'] is String
				? int.tryParse(json['takingPrice'])
				: json['takingPrice'].toInt();
	}
	if (json['packagePrice'] != null) {
		data.packagePrice = json['packagePrice'] is String
				? int.tryParse(json['packagePrice'])
				: json['packagePrice'].toInt();
	}
	if (json['costPrice'] != null) {
		data.costPrice = json['costPrice'] is String
				? int.tryParse(json['costPrice'])
				: json['costPrice'].toInt();
	}
	if (json['price'] != null) {
		data.price = json['price'] is String
				? int.tryParse(json['price'])
				: json['price'].toInt();
	}
	return data;
}

Map<String, dynamic> storeGoodsWithPriceVoEntityToJson(StoreGoodsWithPriceVoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsId'] = entity.goodsId;
	data['sailingPrice'] = entity.sailingPrice;
	data['takingPrice'] = entity.takingPrice;
	data['packagePrice'] = entity.packagePrice;
	data['costPrice'] = entity.costPrice;
	data['price'] = entity.price;
	return data;
}
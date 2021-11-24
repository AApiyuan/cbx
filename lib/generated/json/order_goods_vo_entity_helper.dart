import 'package:haidai_flutter_module/model/enter/order_goods_vo_entity.dart';

orderGoodsVoEntityFromJson(OrderGoodsVoEntity data, Map<String, dynamic> json) {
	if (json['goodsColor'] != null) {
		data.goodsColor = OrderGoodsVoGoodsColor().fromJson(json['goodsColor']);
	}
	if (json['sizes'] != null) {
		data.sizes = (json['sizes'] as List).map((v) => OrderGoodsVoSize().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> orderGoodsVoEntityToJson(OrderGoodsVoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsColor'] = entity.goodsColor?.toJson();
	data['sizes'] =  entity.sizes?.map((v) => v.toJson())?.toList();
	return data;
}

orderGoodsVoGoodsColorFromJson(OrderGoodsVoGoodsColor data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	return data;
}

Map<String, dynamic> orderGoodsVoGoodsColorToJson(OrderGoodsVoGoodsColor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	return data;
}

orderGoodsVoSizeFromJson(OrderGoodsVoSize data, Map<String, dynamic> json) {
	if (json['goodsSize'] != null) {
		data.goodsSize = OrderGoodsVoSizesGoodsSize().fromJson(json['goodsSize']);
	}
	if (json['data'] != null) {
		data.data = OrderGoodsVoSizesData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> orderGoodsVoSizeToJson(OrderGoodsVoSize entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsSize'] = entity.goodsSize.toJson();
	data['data'] = entity.data.toJson();
	return data;
}

orderGoodsVoSizesGoodsSizeFromJson(OrderGoodsVoSizesGoodsSize data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	return data;
}

Map<String, dynamic> orderGoodsVoSizesGoodsSizeToJson(OrderGoodsVoSizesGoodsSize entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	return data;
}

orderGoodsVoSizesDataFromJson(OrderGoodsVoSizesData data, Map<String, dynamic> json) {
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['skuId'] != null) {
		data.skuId = json['skuId'] is String
				? int.tryParse(json['skuId'])
				: json['skuId'].toInt();
	}
	if (json['snapStock'] != null) {
		data.snapStock = json['snapStock'] is String
				? int.tryParse(json['snapStock'])
				: json['snapStock'].toInt();
	}
	if (json['inventoryStock'] != null) {
		data.inventoryStock = json['inventoryStock'];
	}
	return data;
}

Map<String, dynamic> orderGoodsVoSizesDataToJson(OrderGoodsVoSizesData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsId'] = entity.goodsId;
	data['skuId'] = entity.skuId;
	data['snapStock'] = entity.snapStock;
	data['inventoryStock'] = entity.inventoryStock;
	return data;
}
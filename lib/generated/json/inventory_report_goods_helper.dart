import 'package:haidai_flutter_module/model/inventory_report_goods.dart';

inventoryReportGoodsFromJson(InventoryReportGoods data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['orderInventoryId'] != null) {
		data.orderInventoryId = json['orderInventoryId'] is String
				? int.tryParse(json['orderInventoryId'])
				: json['orderInventoryId'].toInt();
	}
	if (json['storeGoodsBaseDo'] != null) {
		data.storeGoodsBaseDo = InventoryReportGoodsStoreGoodsBaseDo().fromJson(json['storeGoodsBaseDo']);
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['snapStock'] != null) {
		data.snapStock = json['snapStock'] is String
				? int.tryParse(json['snapStock'])
				: json['snapStock'].toInt();
	}
	if (json['inventoryStock'] != null) {
		data.inventoryStock = json['inventoryStock'] is String
				? int.tryParse(json['inventoryStock'])
				: json['inventoryStock'].toInt();
	}
	if (json['loss'] != null) {
		data.loss = json['loss'] is String
				? int.tryParse(json['loss'])
				: json['loss'].toInt();
	}
	if (json['profit'] != null) {
		data.profit = json['profit'] is String
				? int.tryParse(json['profit'])
				: json['profit'].toInt();
	}
	return data;
}

Map<String, dynamic> inventoryReportGoodsToJson(InventoryReportGoods entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['orderInventoryId'] = entity.orderInventoryId;
	data['storeGoodsBaseDo'] = entity.storeGoodsBaseDo?.toJson();
	data['goodsId'] = entity.goodsId;
	data['snapStock'] = entity.snapStock;
	data['inventoryStock'] = entity.inventoryStock;
	data['loss'] = entity.loss;
	data['profit'] = entity.profit;
	return data;
}

inventoryReportGoodsStoreGoodsBaseDoFromJson(InventoryReportGoodsStoreGoodsBaseDo data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['goodsNameSerial'] != null) {
		data.goodsNameSerial = json['goodsNameSerial'].toString();
	}
	if (json['imgPath'] != null) {
		data.imgPath = json['imgPath'].toString();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	return data;
}

Map<String, dynamic> inventoryReportGoodsStoreGoodsBaseDoToJson(InventoryReportGoodsStoreGoodsBaseDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsSerial'] = entity.goodsSerial;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['imgPath'] = entity.imgPath;
	data['cover'] = entity.cover;
	data['goodsName'] = entity.goodsName;
	return data;
}
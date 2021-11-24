import 'package:haidai_flutter_module/model/enter/inventory_sku_do_entity.dart';

inventorySkuDoEntityFromJson(InventorySkuDoEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'];
	}
	if (json['createdByName'] != null) {
		data.createdByName = json['createdByName'];
	}
	if (json['updatedByName'] != null) {
		data.updatedByName = json['updatedByName'];
	}
	if (json['orderInventoryId'] != null) {
		data.orderInventoryId = json['orderInventoryId'] is String
				? int.tryParse(json['orderInventoryId'])
				: json['orderInventoryId'].toInt();
	}
	if (json['orderInventoryRecordId'] != null) {
		data.orderInventoryRecordId = json['orderInventoryRecordId'] is String
				? int.tryParse(json['orderInventoryRecordId'])
				: json['orderInventoryRecordId'].toInt();
	}
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
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['stockNum'] != null) {
		data.stockNum = json['stockNum'] is String
				? int.tryParse(json['stockNum'])
				: json['stockNum'].toInt();
	}
	if (json['substandardNum'] != null) {
		data.substandardNum = json['substandardNum'] is String
				? int.tryParse(json['substandardNum'])
				: json['substandardNum'].toInt();
	}
	return data;
}

Map<String, dynamic> inventorySkuDoEntityToJson(InventorySkuDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['orderInventoryId'] = entity.orderInventoryId;
	data['orderInventoryRecordId'] = entity.orderInventoryRecordId;
	data['goodsId'] = entity.goodsId;
	data['skuId'] = entity.skuId;
	data['goodsNum'] = entity.goodsNum;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['stockNum'] = entity.stockNum;
	data['substandardNum'] = entity.substandardNum;
	return data;
}
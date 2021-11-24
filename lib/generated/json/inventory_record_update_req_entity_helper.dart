import 'package:haidai_flutter_module/model/rep/inventory_record_update_req_entity.dart';

inventoryRecordUpdateReqEntityFromJson(InventoryRecordUpdateReqEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['goodsList'] != null) {
		data.goodsList = (json['goodsList'] as List).map((v) => InventoryRecordUpdateReqGoodsList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> inventoryRecordUpdateReqEntityToJson(InventoryRecordUpdateReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsList'] =  entity.goodsList.map((v) => v.toJson()).toList();
	return data;
}

inventoryRecordUpdateReqGoodsListFromJson(InventoryRecordUpdateReqGoodsList data, Map<String, dynamic> json) {
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['skuList'] != null) {
		data.skuList = (json['skuList'] as List).map((v) => InventoryRecordUpdateReqGoodsListSkuList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> inventoryRecordUpdateReqGoodsListToJson(InventoryRecordUpdateReqGoodsList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsId'] = entity.goodsId;
	data['id'] = entity.id;
	data['skuList'] =  entity.skuList.map((v) => v.toJson()).toList();
	return data;
}

inventoryRecordUpdateReqGoodsListSkuListFromJson(InventoryRecordUpdateReqGoodsListSkuList data, Map<String, dynamic> json) {
	if (json['skuId'] != null) {
		data.skuId = json['skuId'] is String
				? int.tryParse(json['skuId'])
				: json['skuId'].toInt();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	return data;
}

Map<String, dynamic> inventoryRecordUpdateReqGoodsListSkuListToJson(InventoryRecordUpdateReqGoodsListSkuList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['skuId'] = entity.skuId;
	data['id'] = entity.id;
	data['goodsNum'] = entity.goodsNum;
	return data;
}
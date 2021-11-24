import 'package:haidai_flutter_module/model/enter/inventory_record_create_req_entity.dart';

inventoryRecordCreateReqEntityFromJson(InventoryRecordCreateReqEntity data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
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
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['recordImg'] != null) {
		data.recordImg = json['recordImg'].toString();
	}
	if (json['goodsList'] != null) {
		data.goodsList = (json['goodsList'] as List).map((v) => InventoryGoodsReq().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> inventoryRecordCreateReqEntityToJson(InventoryRecordCreateReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['id'] = entity.id;
	data['orderInventoryId'] = entity.orderInventoryId;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['recordImg'] = entity.recordImg;
	data['goodsList'] =  entity.goodsList?.map((v) => v.toJson())?.toList();
	return data;
}

inventoryGoodsReqFromJson(InventoryGoodsReq data, Map<String, dynamic> json) {
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
		data.skuList = (json['skuList'] as List).map((v) => InventorySkuReq().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> inventoryGoodsReqToJson(InventoryGoodsReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsId'] = entity.goodsId;
	data['id'] = entity.id;
	data['skuList'] =  entity.skuList?.map((v) => v.toJson())?.toList();
	return data;
}

inventorySkuReqFromJson(InventorySkuReq data, Map<String, dynamic> json) {
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

Map<String, dynamic> inventorySkuReqToJson(InventorySkuReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['skuId'] = entity.skuId;
	data['id'] = entity.id;
	data['goodsNum'] = entity.goodsNum;
	return data;
}
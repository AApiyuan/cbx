import 'package:haidai_flutter_module/model/rep/inventory_record_do_entity.dart';
import 'package:haidai_flutter_module/model/enter/inventory_sku_do_entity.dart';
import 'package:haidai_flutter_module/model/enter/store_goods_base_do_entity.dart';
// import '../sku_info_entity.dart';

inventoryRecordDoEntityFromJson(InventoryRecordDoEntity data, Map<String, dynamic> json) {
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
		data.createdByName = json['createdByName'].toString();
	}
	if (json['updatedByName'] != null) {
		data.updatedByName = json['updatedByName'];
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['orderInventoryId'] != null) {
		data.orderInventoryId = json['orderInventoryId'] is String
				? int.tryParse(json['orderInventoryId'])
				: json['orderInventoryId'].toInt();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['goods'] != null) {
		data.goods = (json['goods'] as List).map((v) => InventoryRecordGoods().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> inventoryRecordDoEntityToJson(InventoryRecordDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['orderInventoryId'] = entity.orderInventoryId;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['goods'] =  entity.goods.map((v) => v.toJson()).toList();
	return data;
}

inventoryRecordGoodsFromJson(InventoryRecordGoods data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
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
	if (json['storeGoodsBaseDo'] != null) {
		data.storeGoodsBaseDo = StoreGoodsBaseDoEntity().fromJson(json['storeGoodsBaseDo']);
	}
	if (json['orderGoodsVoList'] != null) {
		data.orderGoodsVoList = (json['orderGoodsVoList'] as List).map((v) => OrderGoodsVo().fromJson(v)).toList();
	}
	if (json['skus'] != null) {
		data.skus = (json['skus'] as List).map((v) => InventorySkuDoEntity().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> inventoryRecordGoodsToJson(InventoryRecordGoods entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsId'] = entity.goodsId;
	data['stockNum'] = entity.stockNum;
	data['substandardNum'] = entity.substandardNum;
	data['storeGoodsBaseDo'] = entity.storeGoodsBaseDo.toJson();
	data['orderGoodsVoList'] =  entity.orderGoodsVoList.map((v) => v.toJson()).toList();
	data['skus'] =  entity.skus.map((v) => v.toJson()).toList();
	return data;
}

orderGoodsVoFromJson(OrderGoodsVo data, Map<String, dynamic> json) {
	if (json['goodsColor'] != null) {
		data.goodsColor = StoreGoodsStyleBaseDo().fromJson(json['goodsColor']);
	}
	if (json['sizes'] != null) {
		data.sizes = (json['sizes'] as List).map((v) => OrderGoodsSize().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> orderGoodsVoToJson(OrderGoodsVo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsColor'] = entity.goodsColor.toJson();
	data['sizes'] =  entity.sizes.map((v) => v.toJson()).toList();
	return data;
}

storeGoodsStyleBaseDoFromJson(StoreGoodsStyleBaseDo data, Map<String, dynamic> json) {
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

Map<String, dynamic> storeGoodsStyleBaseDoToJson(StoreGoodsStyleBaseDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	return data;
}

orderGoodsSizeFromJson(OrderGoodsSize data, Map<String, dynamic> json) {
	if (json['goodsSize'] != null) {
		data.goodsSize = StoreGoodsStyleBaseDo().fromJson(json['goodsSize']);
	}
	if (json['data'] != null) {
		data.data = OrderGoodsSkuData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> orderGoodsSizeToJson(OrderGoodsSize entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsSize'] = entity.goodsSize?.toJson();
	data['data'] = entity.data?.toJson();
	return data;
}

inventoryRecordDoGoodsOrderGoodsVoListSizesGoodsSizeFromJson(InventoryRecordDoGoodsOrderGoodsVoListSizesGoodsSize data, Map<String, dynamic> json) {
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

Map<String, dynamic> inventoryRecordDoGoodsOrderGoodsVoListSizesGoodsSizeToJson(InventoryRecordDoGoodsOrderGoodsVoListSizesGoodsSize entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	return data;
}

orderGoodsSkuDataFromJson(OrderGoodsSkuData data, Map<String, dynamic> json) {
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
		data.stockNum = json['stockNum'];
	}
	if (json['substandardNum'] != null) {
		data.substandardNum = json['substandardNum'];
	}
	return data;
}

Map<String, dynamic> orderGoodsSkuDataToJson(OrderGoodsSkuData entity) {
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
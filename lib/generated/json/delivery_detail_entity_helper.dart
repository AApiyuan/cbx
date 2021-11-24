import 'package:haidai_flutter_module/page/delivery_detail/models/delivery_detail_entity.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';

deliveryDetailEntityFromJson(DeliveryDetailEntity data, Map<String, dynamic> json) {
	if (json['merchandiserName'] != null) {
		data.merchandiserName = json['merchandiserName'].toString();
	}
	if (json['storeGoodsList'] != null) {
		data.storeGoodsList = (json['storeGoodsList'] as List).map((v) => DeliveryDetailStoreGoodsList().fromJson(v)).toList();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['updatedByName'] != null) {
		data.updatedByName = json['updatedByName'].toString();
	}
	if (json['warehouseName'] != null) {
		data.warehouseName = json['warehouseName'].toString();
	}
	if (json['deliveryGoodsList'] != null) {
		data.deliveryGoodsList = (json['deliveryGoodsList'] as List).map((v) => DeliveryDetailDeliveryGoodsList().fromJson(v)).toList();
	}
	if (json['goodsStyleNum'] != null) {
		data.goodsStyleNum = json['goodsStyleNum'] is String
				? int.tryParse(json['goodsStyleNum'])
				: json['goodsStyleNum'].toInt();
	}
	if (json['taxAmount'] != null) {
		data.taxAmount = json['taxAmount'] is String
				? int.tryParse(json['taxAmount'])
				: json['taxAmount'].toInt();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['createUserName'] != null) {
		data.createUserName = json['createUserName'].toString();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['createdByName'] != null) {
		data.createdByName = json['createdByName'].toString();
	}
	if (json['receivableAmount'] != null) {
		data.receivableAmount = json['receivableAmount'] is String
				? int.tryParse(json['receivableAmount'])
				: json['receivableAmount'].toInt();
	}
	if (json['orderSerial'] != null) {
		data.orderSerial = json['orderSerial'].toString();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? int.tryParse(json['updatedBy'])
				: json['updatedBy'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['logisticsCompanyId'] != null) {
		data.logisticsCompanyId = json['logisticsCompanyId'].toString();
	}
	if (json['logisticsCompanyName'] != null) {
		data.logisticsCompanyName = json['logisticsCompanyName'].toString();
	}
	if (json['logisticsNo'] != null) {
		data.logisticsNo = json['logisticsNo'].toString();
	}
	if (json['consigneeImg'] != null) {
		data.consigneeImg = json['consigneeImg'].toString();
	}
	if (json['customer'] != null) {
		data.customer = DeliveryDetailCustomer().fromJson(json['customer']);
	}
	if (json['taxReceivableAmount'] != null) {
		data.taxReceivableAmount = json['taxReceivableAmount'] is String
				? int.tryParse(json['taxReceivableAmount'])
				: json['taxReceivableAmount'].toInt();
	}
	if (json['merchandiserId'] != null) {
		data.merchandiserId = json['merchandiserId'] is String
				? int.tryParse(json['merchandiserId'])
				: json['merchandiserId'].toInt();
	}
	if (json['createUserId'] != null) {
		data.createUserId = json['createUserId'] is String
				? int.tryParse(json['createUserId'])
				: json['createUserId'].toInt();
	}
	if (json['orderStock'] != null) {
		data.orderStock = DeliveryDetailOrderStock().fromJson(json['orderStock']);
	}
	return data;
}

Map<String, dynamic> deliveryDetailEntityToJson(DeliveryDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['merchandiserName'] = entity.merchandiserName;
	data['storeGoodsList'] =  entity.storeGoodsList?.map((v) => v.toJson())?.toList();
	data['updatedTime'] = entity.updatedTime;
	data['updatedByName'] = entity.updatedByName;
	data['warehouseName'] = entity.warehouseName;
	data['deliveryGoodsList'] =  entity.deliveryGoodsList?.map((v) => v.toJson())?.toList();
	data['goodsStyleNum'] = entity.goodsStyleNum;
	data['taxAmount'] = entity.taxAmount;
	data['warehouseId'] = entity.warehouseId;
	data['deptId'] = entity.deptId;
	data['customerId'] = entity.customerId;
	data['createUserName'] = entity.createUserName;
	data['createdTime'] = entity.createdTime;
	data['id'] = entity.id;
	data['createdBy'] = entity.createdBy;
	data['createdByName'] = entity.createdByName;
	data['receivableAmount'] = entity.receivableAmount;
	data['orderSerial'] = entity.orderSerial;
	data['updatedBy'] = entity.updatedBy;
	data['topDeptId'] = entity.topDeptId;
	data['goodsNum'] = entity.goodsNum;
	data['customizeTime'] = entity.customizeTime;
	data['deptName'] = entity.deptName;
	data['canceled'] = entity.canceled;
	data['remark'] = entity.remark;
	data['logisticsCompanyId'] = entity.logisticsCompanyId;
	data['logisticsCompanyName'] = entity.logisticsCompanyName;
	data['logisticsNo'] = entity.logisticsNo;
	data['consigneeImg'] = entity.consigneeImg;
	data['customer'] = entity.customer?.toJson();
	data['taxReceivableAmount'] = entity.taxReceivableAmount;
	data['merchandiserId'] = entity.merchandiserId;
	data['createUserId'] = entity.createUserId;
	data['orderStock'] = entity.orderStock?.toJson();
	return data;
}

deliveryDetailStoreGoodsListFromJson(DeliveryDetailStoreGoodsList data, Map<String, dynamic> json) {
	if (json['imgPath'] != null) {
		data.imgPath = json['imgPath'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['goodsNameSerial'] != null) {
		data.goodsNameSerial = json['goodsNameSerial'].toString();
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['deliveryGoodsList'] != null) {
		data.deliveryGoodsList = (json['deliveryGoodsList'] as List).map((v) => DeliveryDetailStoreGoodsListDeliveryGoodsList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> deliveryDetailStoreGoodsListToJson(DeliveryDetailStoreGoodsList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['imgPath'] = entity.imgPath;
	data['id'] = entity.id;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['goodsName'] = entity.goodsName;
	data['goodsNum'] = entity.goodsNum;
	data['cover'] = entity.cover;
	data['goodsSerial'] = entity.goodsSerial;
	data['deliveryGoodsList'] =  entity.deliveryGoodsList?.map((v) => v.toJson())?.toList();
	return data;
}

deliveryDetailStoreGoodsListDeliveryGoodsListFromJson(DeliveryDetailStoreGoodsListDeliveryGoodsList data, Map<String, dynamic> json) {
	if (json['orderSaleCustomizeTime'] != null) {
		data.orderSaleCustomizeTime = json['orderSaleCustomizeTime'].toString();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	if (json['deliveryGoodsSkuList'] != null) {
		data.deliveryGoodsSkuList = (json['deliveryGoodsSkuList'] as List).map((v) => DeliveryDetailStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList().fromJson(v)).toList();
	}
	if (json['storeGoodsBaseDo'] != null) {
		data.storeGoodsBaseDo = DeliveryDetailStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo().fromJson(json['storeGoodsBaseDo']);
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['taxAmount'] != null) {
		data.taxAmount = json['taxAmount'] is String
				? int.tryParse(json['taxAmount'])
				: json['taxAmount'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['taxPrice'] != null) {
		data.taxPrice = json['taxPrice'] is String
				? int.tryParse(json['taxPrice'])
				: json['taxPrice'].toInt();
	}
	if (json['receivableAmount'] != null) {
		data.receivableAmount = json['receivableAmount'] is String
				? int.tryParse(json['receivableAmount'])
				: json['receivableAmount'].toInt();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? int.tryParse(json['updatedBy'])
				: json['updatedBy'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['taxReceivableAmount'] != null) {
		data.taxReceivableAmount = json['taxReceivableAmount'] is String
				? int.tryParse(json['taxReceivableAmount'])
				: json['taxReceivableAmount'].toInt();
	}
	if (json['price'] != null) {
		data.price = json['price'] is String
				? int.tryParse(json['price'])
				: json['price'].toInt();
	}
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['orderGoodsVoList'] != null) {
		data.orderGoodsVoList = (json['orderGoodsVoList'] as List).map((v) => SkuInfoEntity().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> deliveryDetailStoreGoodsListDeliveryGoodsListToJson(DeliveryDetailStoreGoodsListDeliveryGoodsList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderSaleCustomizeTime'] = entity.orderSaleCustomizeTime;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	data['deliveryGoodsSkuList'] =  entity.deliveryGoodsSkuList?.map((v) => v.toJson())?.toList();
	data['storeGoodsBaseDo'] = entity.storeGoodsBaseDo?.toJson();
	data['updatedTime'] = entity.updatedTime;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderSaleId'] = entity.orderSaleId;
	data['warehouseId'] = entity.warehouseId;
	data['deptId'] = entity.deptId;
	data['goodsId'] = entity.goodsId;
	data['taxAmount'] = entity.taxAmount;
	data['createdTime'] = entity.createdTime;
	data['id'] = entity.id;
	data['createdBy'] = entity.createdBy;
	data['taxPrice'] = entity.taxPrice;
	data['receivableAmount'] = entity.receivableAmount;
	data['updatedBy'] = entity.updatedBy;
	data['topDeptId'] = entity.topDeptId;
	data['goodsNum'] = entity.goodsNum;
	data['taxReceivableAmount'] = entity.taxReceivableAmount;
	data['price'] = entity.price;
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['orderGoodsVoList'] =  entity.orderGoodsVoList?.map((v) => v.toJson())?.toList();
	return data;
}

deliveryDetailStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuListFromJson(DeliveryDetailStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['orderSaleGoodsSkuId'] != null) {
		data.orderSaleGoodsSkuId = json['orderSaleGoodsSkuId'] is String
				? int.tryParse(json['orderSaleGoodsSkuId'])
				: json['orderSaleGoodsSkuId'].toInt();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['skuId'] != null) {
		data.skuId = json['skuId'] is String
				? int.tryParse(json['skuId'])
				: json['skuId'].toInt();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	if (json['orderDeliveryGoodsId'] != null) {
		data.orderDeliveryGoodsId = json['orderDeliveryGoodsId'] is String
				? int.tryParse(json['orderDeliveryGoodsId'])
				: json['orderDeliveryGoodsId'].toInt();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? int.tryParse(json['updatedBy'])
				: json['updatedBy'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuListToJson(DeliveryDetailStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['orderSaleGoodsSkuId'] = entity.orderSaleGoodsSkuId;
	data['updatedTime'] = entity.updatedTime;
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['goodsNum'] = entity.goodsNum;
	data['orderSaleId'] = entity.orderSaleId;
	data['skuId'] = entity.skuId;
	data['createdBy'] = entity.createdBy;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	data['orderDeliveryGoodsId'] = entity.orderDeliveryGoodsId;
	data['updatedBy'] = entity.updatedBy;
	data['topDeptId'] = entity.topDeptId;
	data['goodsId'] = entity.goodsId;
	return data;
}

deliveryDetailStoreGoodsListDeliveryGoodsListStoreGoodsBaseDoFromJson(DeliveryDetailStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo data, Map<String, dynamic> json) {
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['goodsNameSerial'] != null) {
		data.goodsNameSerial = json['goodsNameSerial'].toString();
	}
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['imgPath'] != null) {
		data.imgPath = json['imgPath'].toString();
	}
	return data;
}

Map<String, dynamic> deliveryDetailStoreGoodsListDeliveryGoodsListStoreGoodsBaseDoToJson(DeliveryDetailStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cover'] = entity.cover;
	data['id'] = entity.id;
	data['goodsName'] = entity.goodsName;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['goodsSerial'] = entity.goodsSerial;
	data['imgPath'] = entity.imgPath;
	return data;
}

deliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListFromJson(DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoList data, Map<String, dynamic> json) {
	if (json['sizes'] != null) {
		data.sizes = (json['sizes'] as List).map((v) => DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes().fromJson(v)).toList();
	}
	if (json['goodsColor'] != null) {
		data.goodsColor = DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor().fromJson(json['goodsColor']);
	}
	return data;
}

Map<String, dynamic> deliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListToJson(DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sizes'] =  entity.sizes?.map((v) => v.toJson())?.toList();
	data['goodsColor'] = entity.goodsColor?.toJson();
	return data;
}

deliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesFromJson(DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes data, Map<String, dynamic> json) {
	if (json['goodsSize'] != null) {
		data.goodsSize = DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize().fromJson(json['goodsSize']);
	}
	if (json['data'] != null) {
		data.data = DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> deliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesToJson(DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsSize'] = entity.goodsSize?.toJson();
	data['data'] = entity.data?.toJson();
	return data;
}

deliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSizeFromJson(DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['styleGroupId'] != null) {
		data.styleGroupId = json['styleGroupId'] is String
				? int.tryParse(json['styleGroupId'])
				: json['styleGroupId'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSizeToJson(DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['styleGroupId'] = entity.styleGroupId;
	data['name'] = entity.name;
	data['sort'] = entity.sort;
	return data;
}

deliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesDataFromJson(DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['orderSaleGoodsSkuId'] != null) {
		data.orderSaleGoodsSkuId = json['orderSaleGoodsSkuId'] is String
				? int.tryParse(json['orderSaleGoodsSkuId'])
				: json['orderSaleGoodsSkuId'].toInt();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['skuId'] != null) {
		data.skuId = json['skuId'] is String
				? int.tryParse(json['skuId'])
				: json['skuId'].toInt();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	if (json['orderDeliveryGoodsId'] != null) {
		data.orderDeliveryGoodsId = json['orderDeliveryGoodsId'] is String
				? int.tryParse(json['orderDeliveryGoodsId'])
				: json['orderDeliveryGoodsId'].toInt();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? int.tryParse(json['updatedBy'])
				: json['updatedBy'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesDataToJson(DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['orderSaleGoodsSkuId'] = entity.orderSaleGoodsSkuId;
	data['updatedTime'] = entity.updatedTime;
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['goodsNum'] = entity.goodsNum;
	data['orderSaleId'] = entity.orderSaleId;
	data['skuId'] = entity.skuId;
	data['createdBy'] = entity.createdBy;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	data['orderDeliveryGoodsId'] = entity.orderDeliveryGoodsId;
	data['updatedBy'] = entity.updatedBy;
	data['topDeptId'] = entity.topDeptId;
	data['goodsId'] = entity.goodsId;
	return data;
}

deliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColorFromJson(DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColorToJson(DeliveryDetailStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['sort'] = entity.sort;
	return data;
}

deliveryDetailDeliveryGoodsListFromJson(DeliveryDetailDeliveryGoodsList data, Map<String, dynamic> json) {
	if (json['orderSaleCustomizeTime'] != null) {
		data.orderSaleCustomizeTime = json['orderSaleCustomizeTime'].toString();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	if (json['deliveryGoodsSkuList'] != null) {
		data.deliveryGoodsSkuList = (json['deliveryGoodsSkuList'] as List).map((v) => DeliveryDetailDeliveryGoodsListDeliveryGoodsSkuList().fromJson(v)).toList();
	}
	if (json['storeGoodsBaseDo'] != null) {
		data.storeGoodsBaseDo = DeliveryDetailDeliveryGoodsListStoreGoodsBaseDo().fromJson(json['storeGoodsBaseDo']);
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['taxAmount'] != null) {
		data.taxAmount = json['taxAmount'] is String
				? int.tryParse(json['taxAmount'])
				: json['taxAmount'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['taxPrice'] != null) {
		data.taxPrice = json['taxPrice'] is String
				? int.tryParse(json['taxPrice'])
				: json['taxPrice'].toInt();
	}
	if (json['receivableAmount'] != null) {
		data.receivableAmount = json['receivableAmount'] is String
				? int.tryParse(json['receivableAmount'])
				: json['receivableAmount'].toInt();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? int.tryParse(json['updatedBy'])
				: json['updatedBy'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['taxReceivableAmount'] != null) {
		data.taxReceivableAmount = json['taxReceivableAmount'] is String
				? int.tryParse(json['taxReceivableAmount'])
				: json['taxReceivableAmount'].toInt();
	}
	if (json['price'] != null) {
		data.price = json['price'] is String
				? int.tryParse(json['price'])
				: json['price'].toInt();
	}
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['orderGoodsVoList'] != null) {
		data.orderGoodsVoList = (json['orderGoodsVoList'] as List).map((v) => DeliveryDetailDeliveryGoodsListOrderGoodsVoList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDeliveryGoodsListToJson(DeliveryDetailDeliveryGoodsList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderSaleCustomizeTime'] = entity.orderSaleCustomizeTime;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	data['deliveryGoodsSkuList'] =  entity.deliveryGoodsSkuList?.map((v) => v.toJson())?.toList();
	data['storeGoodsBaseDo'] = entity.storeGoodsBaseDo?.toJson();
	data['updatedTime'] = entity.updatedTime;
	data['remark'] = entity.remark;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderSaleId'] = entity.orderSaleId;
	data['warehouseId'] = entity.warehouseId;
	data['deptId'] = entity.deptId;
	data['goodsId'] = entity.goodsId;
	data['taxAmount'] = entity.taxAmount;
	data['createdTime'] = entity.createdTime;
	data['id'] = entity.id;
	data['createdBy'] = entity.createdBy;
	data['taxPrice'] = entity.taxPrice;
	data['receivableAmount'] = entity.receivableAmount;
	data['updatedBy'] = entity.updatedBy;
	data['topDeptId'] = entity.topDeptId;
	data['goodsNum'] = entity.goodsNum;
	data['taxReceivableAmount'] = entity.taxReceivableAmount;
	data['price'] = entity.price;
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['orderGoodsVoList'] =  entity.orderGoodsVoList?.map((v) => v.toJson())?.toList();
	return data;
}

deliveryDetailDeliveryGoodsListDeliveryGoodsSkuListFromJson(DeliveryDetailDeliveryGoodsListDeliveryGoodsSkuList data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['orderSaleGoodsSkuId'] != null) {
		data.orderSaleGoodsSkuId = json['orderSaleGoodsSkuId'] is String
				? int.tryParse(json['orderSaleGoodsSkuId'])
				: json['orderSaleGoodsSkuId'].toInt();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['skuId'] != null) {
		data.skuId = json['skuId'] is String
				? int.tryParse(json['skuId'])
				: json['skuId'].toInt();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	if (json['orderDeliveryGoodsId'] != null) {
		data.orderDeliveryGoodsId = json['orderDeliveryGoodsId'] is String
				? int.tryParse(json['orderDeliveryGoodsId'])
				: json['orderDeliveryGoodsId'].toInt();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? int.tryParse(json['updatedBy'])
				: json['updatedBy'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDeliveryGoodsListDeliveryGoodsSkuListToJson(DeliveryDetailDeliveryGoodsListDeliveryGoodsSkuList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['orderSaleGoodsSkuId'] = entity.orderSaleGoodsSkuId;
	data['updatedTime'] = entity.updatedTime;
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['goodsNum'] = entity.goodsNum;
	data['orderSaleId'] = entity.orderSaleId;
	data['skuId'] = entity.skuId;
	data['createdBy'] = entity.createdBy;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	data['orderDeliveryGoodsId'] = entity.orderDeliveryGoodsId;
	data['updatedBy'] = entity.updatedBy;
	data['topDeptId'] = entity.topDeptId;
	data['goodsId'] = entity.goodsId;
	return data;
}

deliveryDetailDeliveryGoodsListStoreGoodsBaseDoFromJson(DeliveryDetailDeliveryGoodsListStoreGoodsBaseDo data, Map<String, dynamic> json) {
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['goodsNameSerial'] != null) {
		data.goodsNameSerial = json['goodsNameSerial'].toString();
	}
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['imgPath'] != null) {
		data.imgPath = json['imgPath'].toString();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDeliveryGoodsListStoreGoodsBaseDoToJson(DeliveryDetailDeliveryGoodsListStoreGoodsBaseDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['cover'] = entity.cover;
	data['id'] = entity.id;
	data['goodsName'] = entity.goodsName;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['goodsSerial'] = entity.goodsSerial;
	data['imgPath'] = entity.imgPath;
	return data;
}

deliveryDetailDeliveryGoodsListOrderGoodsVoListFromJson(DeliveryDetailDeliveryGoodsListOrderGoodsVoList data, Map<String, dynamic> json) {
	if (json['sizes'] != null) {
		data.sizes = (json['sizes'] as List).map((v) => DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizes().fromJson(v)).toList();
	}
	if (json['goodsColor'] != null) {
		data.goodsColor = DeliveryDetailDeliveryGoodsListOrderGoodsVoListGoodsColor().fromJson(json['goodsColor']);
	}
	return data;
}

Map<String, dynamic> deliveryDetailDeliveryGoodsListOrderGoodsVoListToJson(DeliveryDetailDeliveryGoodsListOrderGoodsVoList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sizes'] =  entity.sizes?.map((v) => v.toJson())?.toList();
	data['goodsColor'] = entity.goodsColor?.toJson();
	return data;
}

deliveryDetailDeliveryGoodsListOrderGoodsVoListSizesFromJson(DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizes data, Map<String, dynamic> json) {
	if (json['goodsSize'] != null) {
		data.goodsSize = DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesGoodsSize().fromJson(json['goodsSize']);
	}
	if (json['data'] != null) {
		data.data = DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> deliveryDetailDeliveryGoodsListOrderGoodsVoListSizesToJson(DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsSize'] = entity.goodsSize?.toJson();
	data['data'] = entity.data?.toJson();
	return data;
}

deliveryDetailDeliveryGoodsListOrderGoodsVoListSizesGoodsSizeFromJson(DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesGoodsSize data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['styleGroupId'] != null) {
		data.styleGroupId = json['styleGroupId'] is String
				? int.tryParse(json['styleGroupId'])
				: json['styleGroupId'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDeliveryGoodsListOrderGoodsVoListSizesGoodsSizeToJson(DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesGoodsSize entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['styleGroupId'] = entity.styleGroupId;
	data['name'] = entity.name;
	data['sort'] = entity.sort;
	return data;
}

deliveryDetailDeliveryGoodsListOrderGoodsVoListSizesDataFromJson(DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesData data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['orderSaleGoodsSkuId'] != null) {
		data.orderSaleGoodsSkuId = json['orderSaleGoodsSkuId'] is String
				? int.tryParse(json['orderSaleGoodsSkuId'])
				: json['orderSaleGoodsSkuId'].toInt();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['skuId'] != null) {
		data.skuId = json['skuId'] is String
				? int.tryParse(json['skuId'])
				: json['skuId'].toInt();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	if (json['orderDeliveryGoodsId'] != null) {
		data.orderDeliveryGoodsId = json['orderDeliveryGoodsId'] is String
				? int.tryParse(json['orderDeliveryGoodsId'])
				: json['orderDeliveryGoodsId'].toInt();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? int.tryParse(json['updatedBy'])
				: json['updatedBy'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDeliveryGoodsListOrderGoodsVoListSizesDataToJson(DeliveryDetailDeliveryGoodsListOrderGoodsVoListSizesData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['orderSaleGoodsSkuId'] = entity.orderSaleGoodsSkuId;
	data['updatedTime'] = entity.updatedTime;
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['goodsNum'] = entity.goodsNum;
	data['orderSaleId'] = entity.orderSaleId;
	data['skuId'] = entity.skuId;
	data['createdBy'] = entity.createdBy;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	data['orderDeliveryGoodsId'] = entity.orderDeliveryGoodsId;
	data['updatedBy'] = entity.updatedBy;
	data['topDeptId'] = entity.topDeptId;
	data['goodsId'] = entity.goodsId;
	return data;
}

deliveryDetailDeliveryGoodsListOrderGoodsVoListGoodsColorFromJson(DeliveryDetailDeliveryGoodsListOrderGoodsVoListGoodsColor data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDeliveryGoodsListOrderGoodsVoListGoodsColorToJson(DeliveryDetailDeliveryGoodsListOrderGoodsVoListGoodsColor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['sort'] = entity.sort;
	return data;
}

deliveryDetailCustomerFromJson(DeliveryDetailCustomer data, Map<String, dynamic> json) {
	if (json['orderOweAmount'] != null) {
		data.orderOweAmount = json['orderOweAmount'] is String
				? int.tryParse(json['orderOweAmount'])
				: json['orderOweAmount'].toInt();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['levelTag'] != null) {
		data.levelTag = json['levelTag'].toString();
	}
	if (json['oweAmount'] != null) {
		data.oweAmount = json['oweAmount'] is String
				? int.tryParse(json['oweAmount'])
				: json['oweAmount'].toInt();
	}
	if (json['balance'] != null) {
		data.balance = json['balance'] is String
				? int.tryParse(json['balance'])
				: json['balance'].toInt();
	}
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	return data;
}

Map<String, dynamic> deliveryDetailCustomerToJson(DeliveryDetailCustomer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderOweAmount'] = entity.orderOweAmount;
	data['id'] = entity.id;
	data['levelTag'] = entity.levelTag;
	data['oweAmount'] = entity.oweAmount;
	data['balance'] = entity.balance;
	data['customerName'] = entity.customerName;
	return data;
}

deliveryDetailOrderStockFromJson(DeliveryDetailOrderStock data, Map<String, dynamic> json) {
	if (json['orderOweAmount'] != null) {
		data.orderOweAmount = json['orderOweAmount'] is String
				? int.tryParse(json['orderOweAmount'])
				: json['orderOweAmount'].toInt();
	}
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
	if (json['orderSerial'] != null) {
		data.orderSerial = json['orderSerial'].toString();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['orderType'] != null) {
		data.orderType = json['orderType'].toString();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? int.tryParse(json['updatedBy'])
				: json['updatedBy'].toInt();
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
	if (json['addNum'] != null) {
		data.addNum = json['addNum'] is String
				? int.tryParse(json['addNum'])
				: json['addNum'].toInt();
	}
	if (json['subtractNum'] != null) {
		data.subtractNum = json['subtractNum'] is String
				? int.tryParse(json['subtractNum'])
				: json['subtractNum'].toInt();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
	}
	if (json['addAmount'] != null) {
		data.addAmount = json['addAmount'] is String
				? int.tryParse(json['addAmount'])
				: json['addAmount'].toInt();
	}
	if (json['subtractAmount'] != null) {
		data.subtractAmount = json['subtractAmount'] is String
				? int.tryParse(json['subtractAmount'])
				: json['subtractAmount'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailOrderStockToJson(DeliveryDetailOrderStock entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderOweAmount'] = entity.orderOweAmount;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['orderSerial'] = entity.orderSerial;
	data['customizeTime'] = entity.customizeTime;
	data['orderType'] = entity.orderType;
	data['canceled'] = entity.canceled;
	data['status'] = entity.status;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['addNum'] = entity.addNum;
	data['subtractNum'] = entity.subtractNum;
	data['amount'] = entity.amount;
	data['addAmount'] = entity.addAmount;
	data['subtractAmount'] = entity.subtractAmount;
	data['customerId'] = entity.customerId;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	return data;
}
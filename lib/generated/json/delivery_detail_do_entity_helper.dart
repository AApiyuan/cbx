import 'package:haidai_flutter_module/page/direct_deliver/model/res/delivery_detail_do_entity.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';

deliveryDetailDoEntityFromJson(DeliveryDetailDoEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
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
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['goodsStyleNum'] != null) {
		data.goodsStyleNum = json['goodsStyleNum'] is String
				? int.tryParse(json['goodsStyleNum'])
				: json['goodsStyleNum'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['warehouseName'] != null) {
		data.warehouseName = json['warehouseName'].toString();
	}
	if (json['consigneeImg'] != null) {
		data.consigneeImg = json['consigneeImg'].toString();
	}
	if (json['logisticsCompanyId'] != null) {
		data.logisticsCompanyId = json['logisticsCompanyId'] is String
				? int.tryParse(json['logisticsCompanyId'])
				: json['logisticsCompanyId'].toInt();
	}
	if (json['logisticsCompanyName'] != null) {
		data.logisticsCompanyName = json['logisticsCompanyName'].toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['logisticsNo'] != null) {
		data.logisticsNo = json['logisticsNo'].toString();
	}
	if (json['customer'] != null) {
		data.customer = DeliveryDetailDoCustomer().fromJson(json['customer']);
	}
	if (json['taxReceivableAmount'] != null) {
		data.taxReceivableAmount = json['taxReceivableAmount'] is String
				? int.tryParse(json['taxReceivableAmount'])
				: json['taxReceivableAmount'].toInt();
	}
	if (json['receivableAmount'] != null) {
		data.receivableAmount = json['receivableAmount'] is String
				? int.tryParse(json['receivableAmount'])
				: json['receivableAmount'].toInt();
	}
	if (json['taxAmount'] != null) {
		data.taxAmount = json['taxAmount'] is String
				? int.tryParse(json['taxAmount'])
				: json['taxAmount'].toInt();
	}
	if (json['storeGoodsList'] != null) {
		data.storeGoodsList = (json['storeGoodsList'] as List).map((v) => DeliveryDetailDoStoreGoodsList().fromJson(v)).toList();
	}
	if (json['deliveryGoodsList'] != null) {
		data.deliveryGoodsList = (json['deliveryGoodsList'] as List).map((v) => DeliveryDetailDoDeliveryGoodsList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDoEntityToJson(DeliveryDetailDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['topDeptId'] = entity.topDeptId;
	data['goodsStyleNum'] = entity.goodsStyleNum;
	data['goodsNum'] = entity.goodsNum;
	data['customerId'] = entity.customerId;
	data['canceled'] = entity.canceled;
	data['deptName'] = entity.deptName;
	data['warehouseName'] = entity.warehouseName;
	data['consigneeImg'] = entity.consigneeImg;
	data['logisticsCompanyId'] = entity.logisticsCompanyId;
	data['logisticsCompanyName'] = entity.logisticsCompanyName;
	data['remark'] = entity.remark;
	data['customizeTime'] = entity.customizeTime;
	data['logisticsNo'] = entity.logisticsNo;
	data['customer'] = entity.customer?.toJson();
	data['taxReceivableAmount'] = entity.taxReceivableAmount;
	data['receivableAmount'] = entity.receivableAmount;
	data['taxAmount'] = entity.taxAmount;
	data['storeGoodsList'] =  entity.storeGoodsList?.map((v) => v.toJson())?.toList();
	data['deliveryGoodsList'] =  entity.deliveryGoodsList?.map((v) => v.toJson())?.toList();
	return data;
}

deliveryDetailDoCustomerFromJson(DeliveryDetailDoCustomer data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	if (json['levelTag'] != null) {
		data.levelTag = json['levelTag'].toString();
	}
	if (json['balance'] != null) {
		data.balance = json['balance'] is String
				? int.tryParse(json['balance'])
				: json['balance'].toInt();
	}
	if (json['oweAmount'] != null) {
		data.oweAmount = json['oweAmount'] is String
				? int.tryParse(json['oweAmount'])
				: json['oweAmount'].toInt();
	}
	if (json['orderOweAmount'] != null) {
		data.orderOweAmount = json['orderOweAmount'] is String
				? int.tryParse(json['orderOweAmount'])
				: json['orderOweAmount'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDoCustomerToJson(DeliveryDetailDoCustomer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['customerName'] = entity.customerName;
	data['levelTag'] = entity.levelTag;
	data['balance'] = entity.balance;
	data['oweAmount'] = entity.oweAmount;
	data['orderOweAmount'] = entity.orderOweAmount;
	return data;
}

deliveryDetailDoStoreGoodsListFromJson(DeliveryDetailDoStoreGoodsList data, Map<String, dynamic> json) {
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
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['deliveryGoodsList'] != null) {
		data.deliveryGoodsList = (json['deliveryGoodsList'] as List).map((v) => DeliveryDetailDoStoreGoodsListDeliveryGoodsList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDoStoreGoodsListToJson(DeliveryDetailDoStoreGoodsList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsSerial'] = entity.goodsSerial;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['imgPath'] = entity.imgPath;
	data['cover'] = entity.cover;
	data['goodsName'] = entity.goodsName;
	data['goodsNum'] = entity.goodsNum;
	data['deliveryGoodsList'] =  entity.deliveryGoodsList?.map((v) => v.toJson())?.toList();
	return data;
}

deliveryDetailDoStoreGoodsListDeliveryGoodsListFromJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsList data, Map<String, dynamic> json) {
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
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
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['storeGoodsBaseDo'] != null) {
		data.storeGoodsBaseDo = DeliveryDetailDoStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo().fromJson(json['storeGoodsBaseDo']);
	}
	if (json['price'] != null) {
		data.price = json['price'] is String
				? int.tryParse(json['price'])
				: json['price'].toInt();
	}
	if (json['taxPrice'] != null) {
		data.taxPrice = json['taxPrice'] is String
				? int.tryParse(json['taxPrice'])
				: json['taxPrice'].toInt();
	}
	if (json['taxReceivableAmount'] != null) {
		data.taxReceivableAmount = json['taxReceivableAmount'] is String
				? int.tryParse(json['taxReceivableAmount'])
				: json['taxReceivableAmount'].toInt();
	}
	if (json['receivableAmount'] != null) {
		data.receivableAmount = json['receivableAmount'] is String
				? int.tryParse(json['receivableAmount'])
				: json['receivableAmount'].toInt();
	}
	if (json['taxAmount'] != null) {
		data.taxAmount = json['taxAmount'] is String
				? int.tryParse(json['taxAmount'])
				: json['taxAmount'].toInt();
	}
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['orderSaleCustomizeTime'] != null) {
		data.orderSaleCustomizeTime = json['orderSaleCustomizeTime'].toString();
	}
	if (json['orderGoodsVoList'] != null) {
		data.orderGoodsVoList = (json['orderGoodsVoList'] as List).map((v) => DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoList().fromJson(v)).toList();
	}
	if (json['deliveryGoodsSkuList'] != null) {
		data.deliveryGoodsSkuList = (json['deliveryGoodsSkuList'] as List).map((v) => DeliveryDetailDoStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDoStoreGoodsListDeliveryGoodsListToJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderSaleId'] = entity.orderSaleId;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['topDeptId'] = entity.topDeptId;
	data['goodsId'] = entity.goodsId;
	data['goodsNum'] = entity.goodsNum;
	data['storeGoodsBaseDo'] = entity.storeGoodsBaseDo?.toJson();
	data['price'] = entity.price;
	data['taxPrice'] = entity.taxPrice;
	data['taxReceivableAmount'] = entity.taxReceivableAmount;
	data['receivableAmount'] = entity.receivableAmount;
	data['taxAmount'] = entity.taxAmount;
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['orderSaleCustomizeTime'] = entity.orderSaleCustomizeTime;
	data['orderGoodsVoList'] =  entity.orderGoodsVoList?.map((v) => v.toJson())?.toList();
	data['deliveryGoodsSkuList'] =  entity.deliveryGoodsSkuList?.map((v) => v.toJson())?.toList();
	return data;
}

deliveryDetailDoStoreGoodsListDeliveryGoodsListStoreGoodsBaseDoFromJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo data, Map<String, dynamic> json) {
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

Map<String, dynamic> deliveryDetailDoStoreGoodsListDeliveryGoodsListStoreGoodsBaseDoToJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListStoreGoodsBaseDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsSerial'] = entity.goodsSerial;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['imgPath'] = entity.imgPath;
	data['cover'] = entity.cover;
	data['goodsName'] = entity.goodsName;
	return data;
}

deliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListFromJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoList data, Map<String, dynamic> json) {
	if (json['goodsColor'] != null) {
		data.goodsColor = DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor().fromJson(json['goodsColor']);
	}
	if (json['sizes'] != null) {
		data.sizes = (json['sizes'] as List).map((v) => DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListToJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsColor'] = entity.goodsColor?.toJson();
	data['sizes'] =  entity.sizes?.map((v) => v.toJson())?.toList();
	return data;
}

deliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColorFromJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor data, Map<String, dynamic> json) {
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

Map<String, dynamic> deliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColorToJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListGoodsColor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	return data;
}

deliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesFromJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes data, Map<String, dynamic> json) {
	if (json['goodsSize'] != null) {
		data.goodsSize = DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize().fromJson(json['goodsSize']);
	}
	if (json['data'] != null) {
		data.data = DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> deliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesToJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsSize'] = entity.goodsSize?.toJson();
	data['data'] = entity.data?.toJson();
	return data;
}

deliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSizeFromJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize data, Map<String, dynamic> json) {
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
	if (json['styleGroupId'] != null) {
		data.styleGroupId = json['styleGroupId'] is String
				? int.tryParse(json['styleGroupId'])
				: json['styleGroupId'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSizeToJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesGoodsSize entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	data['styleGroupId'] = entity.styleGroupId;
	return data;
}

deliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesDataFromJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData data, Map<String, dynamic> json) {
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
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['orderSaleGoodsSkuId'] != null) {
		data.orderSaleGoodsSkuId = json['orderSaleGoodsSkuId'] is String
				? int.tryParse(json['orderSaleGoodsSkuId'])
				: json['orderSaleGoodsSkuId'].toInt();
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
	return data;
}

Map<String, dynamic> deliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesDataToJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListOrderGoodsVoListSizesData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['topDeptId'] = entity.topDeptId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderSaleGoodsSkuId'] = entity.orderSaleGoodsSkuId;
	data['goodsId'] = entity.goodsId;
	data['skuId'] = entity.skuId;
	data['goodsNum'] = entity.goodsNum;
	return data;
}

deliveryDetailDoStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuListFromJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList data, Map<String, dynamic> json) {
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
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['orderSaleGoodsSkuId'] != null) {
		data.orderSaleGoodsSkuId = json['orderSaleGoodsSkuId'] is String
				? int.tryParse(json['orderSaleGoodsSkuId'])
				: json['orderSaleGoodsSkuId'].toInt();
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
	return data;
}

Map<String, dynamic> deliveryDetailDoStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuListToJson(DeliveryDetailDoStoreGoodsListDeliveryGoodsListDeliveryGoodsSkuList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['topDeptId'] = entity.topDeptId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderSaleGoodsSkuId'] = entity.orderSaleGoodsSkuId;
	data['goodsId'] = entity.goodsId;
	data['skuId'] = entity.skuId;
	data['goodsNum'] = entity.goodsNum;
	return data;
}

deliveryDetailDoDeliveryGoodsListFromJson(DeliveryDetailDoDeliveryGoodsList data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
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
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['storeGoods'] != null) {
		data.storeGoods = DeliveryDetailDoDeliveryGoodsListStoreGoodsBaseDo().fromJson(json['storeGoods']);
	}
	if (json['price'] != null) {
		data.price = json['price'] is String
				? int.tryParse(json['price'])
				: json['price'].toInt();
	}
	if (json['taxPrice'] != null) {
		data.taxPrice = json['taxPrice'] is String
				? int.tryParse(json['taxPrice'])
				: json['taxPrice'].toInt();
	}
	if (json['taxReceivableAmount'] != null) {
		data.taxReceivableAmount = json['taxReceivableAmount'] is String
				? int.tryParse(json['taxReceivableAmount'])
				: json['taxReceivableAmount'].toInt();
	}
	if (json['receivableAmount'] != null) {
		data.receivableAmount = json['receivableAmount'] is String
				? int.tryParse(json['receivableAmount'])
				: json['receivableAmount'].toInt();
	}
	if (json['taxAmount'] != null) {
		data.taxAmount = json['taxAmount'] is String
				? int.tryParse(json['taxAmount'])
				: json['taxAmount'].toInt();
	}
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['orderSaleCustomizeTime'] != null) {
		data.orderSaleCustomizeTime = json['orderSaleCustomizeTime'].toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['stockNum'] != null) {
		data.stockNum = json['stockNum'] is String
				? int.tryParse(json['stockNum'])
				: json['stockNum'].toInt();
	}
	if (json['orderGoodsVoList'] != null) {
		data.orderGoodsVoList = (json['orderGoodsVoList'] as List).map((v) => SkuInfoEntity().fromJson(v)).toList();
	}
	if (json['deliveryGoodsSkuList'] != null) {
		data.deliveryGoodsSkuList = (json['deliveryGoodsSkuList'] as List).map((v) => DeliveryDetailDoDeliveryGoodsListDeliveryGoodsSkuList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDoDeliveryGoodsListToJson(DeliveryDetailDoDeliveryGoodsList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['topDeptId'] = entity.topDeptId;
	data['goodsId'] = entity.goodsId;
	data['goodsNum'] = entity.goodsNum;
	data['storeGoods'] = entity.storeGoods?.toJson();
	data['price'] = entity.price;
	data['taxPrice'] = entity.taxPrice;
	data['taxReceivableAmount'] = entity.taxReceivableAmount;
	data['receivableAmount'] = entity.receivableAmount;
	data['taxAmount'] = entity.taxAmount;
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['orderSaleCustomizeTime'] = entity.orderSaleCustomizeTime;
	data['remark'] = entity.remark;
	data['shortageNum'] = entity.shortageNum;
	data['stockNum'] = entity.stockNum;
	data['orderGoodsVoList'] =  entity.orderGoodsVoList?.map((v) => v.toJson())?.toList();
	data['deliveryGoodsSkuList'] =  entity.deliveryGoodsSkuList?.map((v) => v.toJson())?.toList();
	return data;
}

deliveryDetailDoDeliveryGoodsListStoreGoodsBaseDoFromJson(DeliveryDetailDoDeliveryGoodsListStoreGoodsBaseDo data, Map<String, dynamic> json) {
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

Map<String, dynamic> deliveryDetailDoDeliveryGoodsListStoreGoodsBaseDoToJson(DeliveryDetailDoDeliveryGoodsListStoreGoodsBaseDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsSerial'] = entity.goodsSerial;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['imgPath'] = entity.imgPath;
	data['cover'] = entity.cover;
	data['goodsName'] = entity.goodsName;
	return data;
}

deliveryDetailDoDeliveryGoodsListOrderGoodsVoListFromJson(DeliveryDetailDoDeliveryGoodsListOrderGoodsVoList data, Map<String, dynamic> json) {
	if (json['goodsColor'] != null) {
		data.goodsColor = DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListGoodsColor().fromJson(json['goodsColor']);
	}
	if (json['sizes'] != null) {
		data.sizes = (json['sizes'] as List).map((v) => DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizes().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDoDeliveryGoodsListOrderGoodsVoListToJson(DeliveryDetailDoDeliveryGoodsListOrderGoodsVoList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsColor'] = entity.goodsColor?.toJson();
	data['sizes'] =  entity.sizes?.map((v) => v.toJson())?.toList();
	return data;
}

deliveryDetailDoDeliveryGoodsListOrderGoodsVoListGoodsColorFromJson(DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListGoodsColor data, Map<String, dynamic> json) {
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

Map<String, dynamic> deliveryDetailDoDeliveryGoodsListOrderGoodsVoListGoodsColorToJson(DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListGoodsColor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	return data;
}

deliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesFromJson(DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizes data, Map<String, dynamic> json) {
	if (json['goodsSize'] != null) {
		data.goodsSize = DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesGoodsSize().fromJson(json['goodsSize']);
	}
	if (json['data'] != null) {
		data.data = DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> deliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesToJson(DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsSize'] = entity.goodsSize?.toJson();
	data['data'] = entity.data?.toJson();
	return data;
}

deliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesGoodsSizeFromJson(DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesGoodsSize data, Map<String, dynamic> json) {
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
	if (json['styleGroupId'] != null) {
		data.styleGroupId = json['styleGroupId'] is String
				? int.tryParse(json['styleGroupId'])
				: json['styleGroupId'].toInt();
	}
	return data;
}

Map<String, dynamic> deliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesGoodsSizeToJson(DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesGoodsSize entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	data['styleGroupId'] = entity.styleGroupId;
	return data;
}

deliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesDataFromJson(DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesData data, Map<String, dynamic> json) {
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
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['orderSaleGoodsSkuId'] != null) {
		data.orderSaleGoodsSkuId = json['orderSaleGoodsSkuId'] is String
				? int.tryParse(json['orderSaleGoodsSkuId'])
				: json['orderSaleGoodsSkuId'].toInt();
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
	return data;
}

Map<String, dynamic> deliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesDataToJson(DeliveryDetailDoDeliveryGoodsListOrderGoodsVoListSizesData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['topDeptId'] = entity.topDeptId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderSaleGoodsSkuId'] = entity.orderSaleGoodsSkuId;
	data['goodsId'] = entity.goodsId;
	data['skuId'] = entity.skuId;
	data['goodsNum'] = entity.goodsNum;
	return data;
}

deliveryDetailDoDeliveryGoodsListDeliveryGoodsSkuListFromJson(DeliveryDetailDoDeliveryGoodsListDeliveryGoodsSkuList data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
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
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['orderSaleGoodsSkuId'] != null) {
		data.orderSaleGoodsSkuId = json['orderSaleGoodsSkuId'] is String
				? int.tryParse(json['orderSaleGoodsSkuId'])
				: json['orderSaleGoodsSkuId'].toInt();
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
	return data;
}

Map<String, dynamic> deliveryDetailDoDeliveryGoodsListDeliveryGoodsSkuListToJson(DeliveryDetailDoDeliveryGoodsListDeliveryGoodsSkuList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['topDeptId'] = entity.topDeptId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['orderSaleGoodsSkuId'] = entity.orderSaleGoodsSkuId;
	data['goodsId'] = entity.goodsId;
	data['skuId'] = entity.skuId;
	data['goodsNum'] = entity.goodsNum;
	return data;
}
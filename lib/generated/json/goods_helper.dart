import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';

goodsFromJson(Goods data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
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
	if (json['saleNum'] != null) {
		data.saleNum = json['saleNum'] is String
				? int.tryParse(json['saleNum'])
				: json['saleNum'].toInt();
	}
	if (json['oweNum'] != null) {
		data.oweNum = json['oweNum'] is String
				? int.tryParse(json['oweNum'])
				: json['oweNum'].toInt();
	}
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['onSaleTime'] != null) {
		data.onSaleTime = json['onSaleTime'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'];
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
	if (json['lastBuyPrice'] != null) {
		data.lastBuyPrice = json['lastBuyPrice'] is String
				? int.tryParse(json['lastBuyPrice'])
				: json['lastBuyPrice'].toInt();
	}
	if (json['goodsClassify'] != null) {
		data.goodsClassify = json['goodsClassify'] is String
				? int.tryParse(json['goodsClassify'])
				: json['goodsClassify'].toInt();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['imgPath'] != null) {
		data.imgPath = json['imgPath'].toString();
	}
	if (json['supplierId'] != null) {
		data.supplierId = json['supplierId'] is String
				? int.tryParse(json['supplierId'])
				: json['supplierId'].toInt();
	}
	if (json['goodsBrand'] != null) {
		data.goodsBrand = json['goodsBrand'] is String
				? int.tryParse(json['goodsBrand'])
				: json['goodsBrand'].toInt();
	}
	if (json['goodsYear'] != null) {
		data.goodsYear = json['goodsYear'] is String
				? int.tryParse(json['goodsYear'])
				: json['goodsYear'].toInt();
	}
	if (json['goodsSeason'] != null) {
		data.goodsSeason = json['goodsSeason'] is String
				? int.tryParse(json['goodsSeason'])
				: json['goodsSeason'].toInt();
	}
	if (json['goodsLabel'] != null) {
		data.goodsLabel = json['goodsLabel'] is String
				? int.tryParse(json['goodsLabel'])
				: json['goodsLabel'].toInt();
	}
	if (json['customerDeliveryNum'] != null) {
		data.customerDeliveryNum = json['customerDeliveryNum'] is String
				? int.tryParse(json['customerDeliveryNum'])
				: json['customerDeliveryNum'].toInt();
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
	if (json['createdByName'] != null) {
		data.createdByName = json['createdByName'].toString();
	}
	if (json['updatedByName'] != null) {
		data.updatedByName = json['updatedByName'].toString();
	}
	if (json['storeGoodsSkuList'] != null) {
		data.storeGoodsSkuList = (json['storeGoodsSkuList'] as List).map((v) => SkuInfoEntity().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> goodsToJson(Goods entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['stockNum'] = entity.stockNum;
	data['substandardNum'] = entity.substandardNum;
	data['saleNum'] = entity.saleNum;
	data['oweNum'] = entity.oweNum;
	data['goodsSerial'] = entity.goodsSerial;
	data['onSaleTime'] = entity.onSaleTime;
	data['status'] = entity.status;
	data['sailingPrice'] = entity.sailingPrice;
	data['takingPrice'] = entity.takingPrice;
	data['packagePrice'] = entity.packagePrice;
	data['costPrice'] = entity.costPrice;
	data['lastBuyPrice'] = entity.lastBuyPrice;
	data['goodsClassify'] = entity.goodsClassify;
	data['cover'] = entity.cover;
	data['goodsName'] = entity.goodsName;
	data['imgPath'] = entity.imgPath;
	data['supplierId'] = entity.supplierId;
	data['goodsBrand'] = entity.goodsBrand;
	data['goodsYear'] = entity.goodsYear;
	data['goodsSeason'] = entity.goodsSeason;
	data['goodsLabel'] = entity.goodsLabel;
	data['customerDeliveryNum'] = entity.customerDeliveryNum;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['storeGoodsSkuList'] =  entity.storeGoodsSkuList?.map((v) => v.toJson())?.toList();
	return data;
}
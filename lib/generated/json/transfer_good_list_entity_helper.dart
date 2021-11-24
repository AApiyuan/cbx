import 'package:haidai_flutter_module/page/transfer/model/res/transfer_good_list_entity.dart';

transferGoodListEntityFromJson(TransferGoodListEntity data, Map<String, dynamic> json) {
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
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['onSaleTime'] != null) {
		data.onSaleTime = json['onSaleTime'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
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
	if (json['customerDeliveryNum'] != null) {
		data.customerDeliveryNum = json['customerDeliveryNum'] is String
				? int.tryParse(json['customerDeliveryNum'])
				: json['customerDeliveryNum'].toInt();
	}
	return data;
}

Map<String, dynamic> transferGoodListEntityToJson(TransferGoodListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['deptId'] = entity.deptId;
	data['goodsSerial'] = entity.goodsSerial;
	data['onSaleTime'] = entity.onSaleTime;
	data['status'] = entity.status;
	data['sailingPrice'] = entity.sailingPrice;
	data['takingPrice'] = entity.takingPrice;
	data['packagePrice'] = entity.packagePrice;
	data['goodsClassify'] = entity.goodsClassify;
	data['cover'] = entity.cover;
	data['goodsName'] = entity.goodsName;
	data['imgPath'] = entity.imgPath;
	data['customerDeliveryNum'] = entity.customerDeliveryNum;
	return data;
}
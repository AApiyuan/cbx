import 'package:haidai_flutter_module/page/stock/model/req/stock_page_req.dart';

stockPageReqFromJson(StockPageReq data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['createdBys'] != null) {
		data.createdBys = (json['createdBys'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['supplierId'] != null) {
		data.supplierId = json['supplierId'] is String
				? int.tryParse(json['supplierId'])
				: json['supplierId'].toInt();
	}
	if (json['startTime'] != null) {
		data.startTime = json['startTime'].toString();
	}
	if (json['endTime'] != null) {
		data.endTime = json['endTime'].toString();
	}
	if (json['orderType'] != null) {
		data.orderType = json['orderType'].toString();
	}
	if (json['orderTypes'] != null) {
		data.orderTypes = (json['orderTypes'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	return data;
}

Map<String, dynamic> stockPageReqToJson(StockPageReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['createdBy'] = entity.createdBy;
	data['createdBys'] = entity.createdBys;
	data['goodsId'] = entity.goodsId;
	data['canceled'] = entity.canceled;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['customerId'] = entity.customerId;
	data['supplierId'] = entity.supplierId;
	data['startTime'] = entity.startTime;
	data['endTime'] = entity.endTime;
	data['orderType'] = entity.orderType;
	data['orderTypes'] = entity.orderTypes;
	return data;
}
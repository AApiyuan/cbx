import 'package:haidai_flutter_module/page/transfer/model/res/transfer_count_param_entity.dart';

transferCountParamEntityFromJson(TransferCountParamEntity data, Map<String, dynamic> json) {
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
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
	if (json['stockOutDeptId'] != null) {
		data.stockOutDeptId = json['stockOutDeptId'] is String
				? int.tryParse(json['stockOutDeptId'])
				: json['stockOutDeptId'].toInt();
	}
	if (json['stockInDeptId'] != null) {
		data.stockInDeptId = json['stockInDeptId'] is String
				? int.tryParse(json['stockInDeptId'])
				: json['stockInDeptId'].toInt();
	}
	if (json['orderSerial'] != null) {
		data.orderSerial = json['orderSerial'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['statusEnumList'] != null) {
		data.statusEnumList = (json['statusEnumList'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['difference'] != null) {
		data.difference = json['difference'].toString();
	}
	if (json['orderType'] != null) {
		data.orderType = json['orderType'] is String
				? int.tryParse(json['orderType'])
				: json['orderType'].toInt();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['substandard'] != null) {
		data.substandard = json['substandard'] is String
				? int.tryParse(json['substandard'])
				: json['substandard'].toInt();
	}
	if (json['startDate'] != null) {
		data.startDate = json['startDate'].toString();
	}
	if (json['endDate'] != null) {
		data.endDate = json['endDate'].toString();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['otherDeptId'] != null) {
		data.otherDeptId = json['otherDeptId'] is String
				? int.tryParse(json['otherDeptId'])
				: json['otherDeptId'].toInt();
	}
	return data;
}

Map<String, dynamic> transferCountParamEntityToJson(TransferCountParamEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['createdBy'] = entity.createdBy;
	data['deptId'] = entity.deptId;
	data['goodsId'] = entity.goodsId;
	data['stockOutDeptId'] = entity.stockOutDeptId;
	data['stockInDeptId'] = entity.stockInDeptId;
	data['orderSerial'] = entity.orderSerial;
	data['status'] = entity.status;
	data['statusEnumList'] = entity.statusEnumList;
	data['difference'] = entity.difference;
	data['orderType'] = entity.orderType;
	data['canceled'] = entity.canceled;
	data['substandard'] = entity.substandard;
	data['startDate'] = entity.startDate;
	data['endDate'] = entity.endDate;
	data['orderSaleId'] = entity.orderSaleId;
	data['otherDeptId'] = entity.otherDeptId;
	return data;
}
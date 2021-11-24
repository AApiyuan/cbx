import 'package:haidai_flutter_module/page/sale/model/req/create_remit_req_entity.dart';

createRemitReqEntityFromJson(CreateRemitReqEntity data, Map<String, dynamic> json) {
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['remitAmount'] != null) {
		data.remitAmount = json['remitAmount'] is String
				? int.tryParse(json['remitAmount'])
				: json['remitAmount'].toInt();
	}
	if (json['remitRecordMethodDoList'] != null) {
		data.remitRecordMethodDoList = (json['remitRecordMethodDoList'] as List).map((v) => CreateRemitReqRemitRecordMethodDoList().fromJson(v)).toList();
	}
	if (json['reqList'] != null) {
		data.reqList = (json['reqList'] as List).map((v) => CreateRemitReqReqList().fromJson(v)).toList();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	return data;
}

Map<String, dynamic> createRemitReqEntityToJson(CreateRemitReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerId'] = entity.customerId;
	data['deptId'] = entity.deptId;
	data['orderSaleId'] = entity.orderSaleId;
	data['remitAmount'] = entity.remitAmount;
	data['remitRecordMethodDoList'] =  entity.remitRecordMethodDoList?.map((v) => v.toJson())?.toList();
	data['reqList'] =  entity.reqList?.map((v) => v.toJson())?.toList();
	data['type'] = entity.type;
	data['customizeTime'] = entity.customizeTime;
	data['remark'] = entity.remark;
	return data;
}

createRemitReqRemitRecordMethodDoListFromJson(CreateRemitReqRemitRecordMethodDoList data, Map<String, dynamic> json) {
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
	}
	if (json['remitMethodId'] != null) {
		data.remitMethodId = json['remitMethodId'] is String
				? int.tryParse(json['remitMethodId'])
				: json['remitMethodId'].toInt();
	}
	return data;
}

Map<String, dynamic> createRemitReqRemitRecordMethodDoListToJson(CreateRemitReqRemitRecordMethodDoList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['amount'] = entity.amount;
	data['remitMethodId'] = entity.remitMethodId;
	return data;
}

createRemitReqReqListFromJson(CreateRemitReqReqList data, Map<String, dynamic> json) {
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	return data;
}

Map<String, dynamic> createRemitReqReqListToJson(CreateRemitReqReqList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['amount'] = entity.amount;
	data['customerId'] = entity.customerId;
	data['orderSaleId'] = entity.orderSaleId;
	return data;
}
import 'package:haidai_flutter_module/page/sale/model/store_remit_method_do_entity.dart';

storeRemitMethodDoEntityFromJson(StoreRemitMethodDoEntity data, Map<String, dynamic> json) {
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
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['remitMethodName'] != null) {
		data.remitMethodName = json['remitMethodName'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['xPaymentAmount'] != null) {
		data.xPaymentAmount = json['xPaymentAmount'].toString();
	}
	if (json['xRefundAmount'] != null) {
		data.xRefundAmount = json['xRefundAmount'].toString();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'].toString();
	}
	if (json['selected'] != null) {
		data.selected = json['selected'];
	}
	return data;
}

Map<String, dynamic> storeRemitMethodDoEntityToJson(StoreRemitMethodDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['remitMethodName'] = entity.remitMethodName;
	data['sort'] = entity.sort;
	data['status'] = entity.status;
	data['xPaymentAmount'] = entity.xPaymentAmount;
	data['xRefundAmount'] = entity.xRefundAmount;
	data['amount'] = entity.amount;
	data['selected'] = entity.selected;
	return data;
}
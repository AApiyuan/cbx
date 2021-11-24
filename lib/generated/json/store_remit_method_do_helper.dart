import 'package:haidai_flutter_module/model/store/res/store_remit_method_do.dart';

storeRemitMethodDoFromJson(StoreRemitMethodDo data, Map<String, dynamic> json) {
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
	if (json['color'] != null) {
		data.color = json['color'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['useCustomerDeptNum'] != null) {
		data.useCustomerDeptNum = json['useCustomerDeptNum'] is String
				? int.tryParse(json['useCustomerDeptNum'])
				: json['useCustomerDeptNum'].toInt();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	return data;
}

Map<String, dynamic> storeRemitMethodDoToJson(StoreRemitMethodDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['remitMethodName'] = entity.remitMethodName;
	data['sort'] = entity.sort;
	data['color'] = entity.color;
	data['status'] = entity.status;
	data['useCustomerDeptNum'] = entity.useCustomerDeptNum;
	data['id'] = entity.id;
	return data;
}
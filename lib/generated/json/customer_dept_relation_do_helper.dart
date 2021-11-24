import 'package:haidai_flutter_module/model/store/res/customer_dept_relation_do.dart';

customerDeptRelationDoFromJson(CustomerDeptRelationDo data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['relationDeptId'] != null) {
		data.relationDeptId = json['relationDeptId'] is String
				? int.tryParse(json['relationDeptId'])
				: json['relationDeptId'].toInt();
	}
	if (json['selfUse'] != null) {
		data.selfUse = json['selfUse'];
	}
	if (json['deptType'] != null) {
		data.deptType = json['deptType'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['logo'] != null) {
		data.logo = json['logo'].toString();
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
	if (json['selected'] != null) {
		data.selected = json['selected'];
	}
	return data;
}

Map<String, dynamic> customerDeptRelationDoToJson(CustomerDeptRelationDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['relationDeptId'] = entity.relationDeptId;
	data['selfUse'] = entity.selfUse;
	data['deptType'] = entity.deptType;
	data['status'] = entity.status;
	data['name'] = entity.name;
	data['logo'] = entity.logo;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['selected'] = entity.selected;
	return data;
}
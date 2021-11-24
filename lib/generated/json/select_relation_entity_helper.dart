import 'package:haidai_flutter_module/page/transfer/model/req/select_relation_entity.dart';

selectRelationEntityFromJson(SelectRelationEntity data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? double.tryParse(json['deptId'])
				: json['deptId'].toDouble();
	}
	if (json['deptType'] != null) {
		data.deptType = json['deptType'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? double.tryParse(json['createdBy'])
				: json['createdBy'].toDouble();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? double.tryParse(json['updatedBy'])
				: json['updatedBy'].toDouble();
	}
	if (json['relationDeptId'] != null) {
		data.relationDeptId = json['relationDeptId'] is String
				? double.tryParse(json['relationDeptId'])
				: json['relationDeptId'].toDouble();
	}
	if (json['selfUse'] != null) {
		data.selfUse = json['selfUse'];
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['logo'] != null) {
		data.logo = json['logo'].toString();
	}
	return data;
}

Map<String, dynamic> selectRelationEntityToJson(SelectRelationEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['deptType'] = entity.deptType;
	data['status'] = entity.status;
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['createdTime'] = entity.createdTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['relationDeptId'] = entity.relationDeptId;
	data['selfUse'] = entity.selfUse;
	data['updatedTime'] = entity.updatedTime;
	data['logo'] = entity.logo;
	return data;
}
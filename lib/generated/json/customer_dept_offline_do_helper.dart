import 'package:haidai_flutter_module/model/customer_dept_offline_do.dart';

customerDeptOfflineDoFromJson(CustomerDeptOfflineDo data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'];
	}
	if (json['offlineTime'] != null) {
		data.offlineTime = json['offlineTime'].toString();
	}
	if (json['offlineFile'] != null) {
		data.offlineFile = json['offlineFile'].toString();
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
	return data;
}

Map<String, dynamic> customerDeptOfflineDoToJson(CustomerDeptOfflineDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['type'] = entity.type;
	data['offlineTime'] = entity.offlineTime;
	data['offlineFile'] = entity.offlineFile;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}
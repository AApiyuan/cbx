import 'package:haidai_flutter_module/model/store/res/customer_dept_do.dart';

customerDeptDoFromJson(CustomerDeptDo data, Map<String, dynamic> json) {
	if (json['bossId'] != null) {
		data.bossId = json['bossId'] is String
				? int.tryParse(json['bossId'])
				: json['bossId'].toInt();
	}
	if (json['parentDeptId'] != null) {
		data.parentDeptId = json['parentDeptId'] is String
				? int.tryParse(json['parentDeptId'])
				: json['parentDeptId'].toInt();
	}
	if (json['path'] != null) {
		data.path = json['path'].toString();
	}
	if (json['deptType'] != null) {
		data.deptType = json['deptType'];
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['paidStaffNum'] != null) {
		data.paidStaffNum = json['paidStaffNum'] is String
				? int.tryParse(json['paidStaffNum'])
				: json['paidStaffNum'].toInt();
	}
	if (json['customerNum'] != null) {
		data.customerNum = json['customerNum'] is String
				? int.tryParse(json['customerNum'])
				: json['customerNum'].toInt();
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

Map<String, dynamic> customerDeptDoToJson(CustomerDeptDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['bossId'] = entity.bossId;
	data['parentDeptId'] = entity.parentDeptId;
	data['path'] = entity.path;
	data['deptType'] = entity.deptType;
	data['status'] = entity.status;
	data['name'] = entity.name;
	data['paidStaffNum'] = entity.paidStaffNum;
	data['customerNum'] = entity.customerNum;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}
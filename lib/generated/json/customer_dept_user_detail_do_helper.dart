import 'package:haidai_flutter_module/model/store/res/customer_dept_user_detail_do.dart';

customerDeptUserDetailDoFromJson(CustomerDeptUserDetailDo data, Map<String, dynamic> json) {
	if (json['customerUserDo'] != null) {
		data.customerUserDo = CustomerDeptUserDetailDoCustomerUserDo().fromJson(json['customerUserDo']);
	}
	if (json['customerDeptUserDoList'] != null) {
		data.customerDeptUserDoList = (json['customerDeptUserDoList'] as List).map((v) => CustomerDeptUserDetailDoCustomerDeptUserDoList().fromJson(v)).toList();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
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
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['entryTime'] != null) {
		data.entryTime = json['entryTime'] is String
				? int.tryParse(json['entryTime'])
				: json['entryTime'].toInt();
	}
	if (json['roleId'] != null) {
		data.roleId = json['roleId'] is String
				? int.tryParse(json['roleId'])
				: json['roleId'].toInt();
	}
	if (json['jobNumber'] != null) {
		data.jobNumber = json['jobNumber'].toString();
	}
	if (json['factoryDeptId'] != null) {
		data.factoryDeptId = json['factoryDeptId'] is String
				? int.tryParse(json['factoryDeptId'])
				: json['factoryDeptId'].toInt();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['roleName'] != null) {
		data.roleName = json['roleName'].toString();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['factoryDeptName'] != null) {
		data.factoryDeptName = json['factoryDeptName'].toString();
	}
	if (json['userName'] != null) {
		data.userName = json['userName'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'] is String
				? int.tryParse(json['createdTime'])
				: json['createdTime'].toInt();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'] is String
				? int.tryParse(json['updatedTime'])
				: json['updatedTime'].toInt();
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

Map<String, dynamic> customerDeptUserDetailDoToJson(CustomerDeptUserDetailDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerUserDo'] = entity.customerUserDo?.toJson();
	data['customerDeptUserDoList'] =  entity.customerDeptUserDoList?.map((v) => v.toJson())?.toList();
	data['userId'] = entity.userId;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['status'] = entity.status;
	data['entryTime'] = entity.entryTime;
	data['roleId'] = entity.roleId;
	data['jobNumber'] = entity.jobNumber;
	data['factoryDeptId'] = entity.factoryDeptId;
	data['remark'] = entity.remark;
	data['roleName'] = entity.roleName;
	data['deptName'] = entity.deptName;
	data['factoryDeptName'] = entity.factoryDeptName;
	data['userName'] = entity.userName;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

customerDeptUserDetailDoCustomerUserDoFromJson(CustomerDeptUserDetailDoCustomerUserDo data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['bindPhone'] != null) {
		data.bindPhone = json['bindPhone'].toString();
	}
	if (json['wx'] != null) {
		data.wx = json['wx'].toString();
	}
	if (json['customerUserId'] != null) {
		data.customerUserId = json['customerUserId'] is String
				? int.tryParse(json['customerUserId'])
				: json['customerUserId'].toInt();
	}
	if (json['entryTime'] != null) {
		data.entryTime = json['entryTime'] is String
				? int.tryParse(json['entryTime'])
				: json['entryTime'].toInt();
	}
	if (json['noSelectedDepts'] != null) {
		data.noSelectedDepts = json['noSelectedDepts'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'] is String
				? int.tryParse(json['createdTime'])
				: json['createdTime'].toInt();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'] is String
				? int.tryParse(json['updatedTime'])
				: json['updatedTime'].toInt();
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

Map<String, dynamic> customerDeptUserDetailDoCustomerUserDoToJson(CustomerDeptUserDetailDoCustomerUserDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['avatar'] = entity.avatar;
	data['bindPhone'] = entity.bindPhone;
	data['wx'] = entity.wx;
	data['customerUserId'] = entity.customerUserId;
	data['entryTime'] = entity.entryTime;
	data['noSelectedDepts'] = entity.noSelectedDepts;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

customerDeptUserDetailDoCustomerDeptUserDoListFromJson(CustomerDeptUserDetailDoCustomerDeptUserDoList data, Map<String, dynamic> json) {
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
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
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['entryTime'] != null) {
		data.entryTime = json['entryTime'] is String
				? int.tryParse(json['entryTime'])
				: json['entryTime'].toInt();
	}
	if (json['roleId'] != null) {
		data.roleId = json['roleId'] is String
				? int.tryParse(json['roleId'])
				: json['roleId'].toInt();
	}
	if (json['jobNumber'] != null) {
		data.jobNumber = json['jobNumber'].toString();
	}
	if (json['factoryDeptId'] != null) {
		data.factoryDeptId = json['factoryDeptId'] is String
				? int.tryParse(json['factoryDeptId'])
				: json['factoryDeptId'].toInt();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['roleName'] != null) {
		data.roleName = json['roleName'].toString();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['factoryDeptName'] != null) {
		data.factoryDeptName = json['factoryDeptName'].toString();
	}
	if (json['userName'] != null) {
		data.userName = json['userName'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'] is String
				? int.tryParse(json['createdTime'])
				: json['createdTime'].toInt();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'] is String
				? int.tryParse(json['updatedTime'])
				: json['updatedTime'].toInt();
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

Map<String, dynamic> customerDeptUserDetailDoCustomerDeptUserDoListToJson(CustomerDeptUserDetailDoCustomerDeptUserDoList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['userId'] = entity.userId;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['status'] = entity.status;
	data['entryTime'] = entity.entryTime;
	data['roleId'] = entity.roleId;
	data['jobNumber'] = entity.jobNumber;
	data['factoryDeptId'] = entity.factoryDeptId;
	data['remark'] = entity.remark;
	data['roleName'] = entity.roleName;
	data['deptName'] = entity.deptName;
	data['factoryDeptName'] = entity.factoryDeptName;
	data['userName'] = entity.userName;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}
import 'package:haidai_flutter_module/model/store/res/customer_dept_detail_and_role_do.dart';

customerDeptDetailAndRoleDoFromJson(CustomerDeptDetailAndRoleDo data, Map<String, dynamic> json) {
	if (json['customerDeptRelationDos'] != null) {
		data.customerDeptRelationDos = (json['customerDeptRelationDos'] as List).map((v) => CustomerDeptDetailAndRoleDoCustomerDeptRelationDos().fromJson(v)).toList();
	}
	if (json['customerDeptFunctionalVersionDoList'] != null) {
		data.customerDeptFunctionalVersionDoList = (json['customerDeptFunctionalVersionDoList'] as List).map((v) => CustomerDeptDetailAndRoleDoCustomerDeptFunctionalVersionDoList().fromJson(v)).toList();
	}
	if (json['roleName'] != null) {
		data.roleName = json['roleName'].toString();
	}
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
	if (json['customerNum'] != null) {
		data.customerNum = json['customerNum'] is String
				? int.tryParse(json['customerNum'])
				: json['customerNum'].toInt();
	}
	if (json['customerDeptDetailDo'] != null) {
		data.customerDeptDetailDo = CustomerDeptDetailAndRoleDoCustomerDeptDetailDo().fromJson(json['customerDeptDetailDo']);
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

Map<String, dynamic> customerDeptDetailAndRoleDoToJson(CustomerDeptDetailAndRoleDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerDeptRelationDos'] =  entity.customerDeptRelationDos?.map((v) => v.toJson())?.toList();
	data['customerDeptFunctionalVersionDoList'] =  entity.customerDeptFunctionalVersionDoList?.map((v) => v.toJson())?.toList();
	data['roleName'] = entity.roleName;
	data['bossId'] = entity.bossId;
	data['parentDeptId'] = entity.parentDeptId;
	data['path'] = entity.path;
	data['deptType'] = entity.deptType;
	data['status'] = entity.status;
	data['name'] = entity.name;
	data['customerNum'] = entity.customerNum;
	data['customerDeptDetailDo'] = entity.customerDeptDetailDo?.toJson();
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

customerDeptDetailAndRoleDoCustomerDeptRelationDosFromJson(CustomerDeptDetailAndRoleDoCustomerDeptRelationDos data, Map<String, dynamic> json) {
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
		data.deptType = json['deptType'];
	}
	if (json['status'] != null) {
		data.status = json['status'];
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
	return data;
}

Map<String, dynamic> customerDeptDetailAndRoleDoCustomerDeptRelationDosToJson(CustomerDeptDetailAndRoleDoCustomerDeptRelationDos entity) {
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
	return data;
}

customerDeptDetailAndRoleDoCustomerDeptFunctionalVersionDoListFromJson(CustomerDeptDetailAndRoleDoCustomerDeptFunctionalVersionDoList data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'];
	}
	if (json['beginEffectiveTime'] != null) {
		data.beginEffectiveTime = json['beginEffectiveTime'].toString();
	}
	if (json['endEffectiveTime'] != null) {
		data.endEffectiveTime = json['endEffectiveTime'].toString();
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

Map<String, dynamic> customerDeptDetailAndRoleDoCustomerDeptFunctionalVersionDoListToJson(CustomerDeptDetailAndRoleDoCustomerDeptFunctionalVersionDoList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['type'] = entity.type;
	data['beginEffectiveTime'] = entity.beginEffectiveTime;
	data['endEffectiveTime'] = entity.endEffectiveTime;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

customerDeptDetailAndRoleDoCustomerDeptDetailDoFromJson(CustomerDeptDetailAndRoleDoCustomerDeptDetailDo data, Map<String, dynamic> json) {
	if (json['phone'] != null) {
		data.phone = json['phone'].toString();
	}
	if (json['marketId'] != null) {
		data.marketId = json['marketId'] is String
				? int.tryParse(json['marketId'])
				: json['marketId'].toInt();
	}
	if (json['province'] != null) {
		data.province = json['province'].toString();
	}
	if (json['provinceCode'] != null) {
		data.provinceCode = json['provinceCode'].toString();
	}
	if (json['city'] != null) {
		data.city = json['city'].toString();
	}
	if (json['cityCode'] != null) {
		data.cityCode = json['cityCode'].toString();
	}
	if (json['district'] != null) {
		data.district = json['district'].toString();
	}
	if (json['districtCode'] != null) {
		data.districtCode = json['districtCode'].toString();
	}
	if (json['address'] != null) {
		data.address = json['address'].toString();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['logo'] != null) {
		data.logo = json['logo'].toString();
	}
	if (json['photoAlbumHeader'] != null) {
		data.photoAlbumHeader = json['photoAlbumHeader'].toString();
	}
	if (json['wx'] != null) {
		data.wx = json['wx'].toString();
	}
	if (json['enableTime'] != null) {
		data.enableTime = json['enableTime'].toString();
	}
	if (json['longtitude'] != null) {
		data.longtitude = json['longtitude'] is String
				? int.tryParse(json['longtitude'])
				: json['longtitude'].toInt();
	}
	if (json['latitude'] != null) {
		data.latitude = json['latitude'] is String
				? int.tryParse(json['latitude'])
				: json['latitude'].toInt();
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
	if (json['firstActivatedTime'] != null) {
		data.firstActivatedTime = json['firstActivatedTime'].toString();
	}
	if (json['baseExpiryDate'] != null) {
		data.baseExpiryDate = json['baseExpiryDate'].toString();
	}
	if (json['offlineExpiryDate'] != null) {
		data.offlineExpiryDate = json['offlineExpiryDate'].toString();
	}
	if (json['appBiExpiryDate'] != null) {
		data.appBiExpiryDate = json['appBiExpiryDate'].toString();
	}
	if (json['substandardStockExpiryDate'] != null) {
		data.substandardStockExpiryDate = json['substandardStockExpiryDate'].toString();
	}
	if (json['transferExpiryDate'] != null) {
		data.transferExpiryDate = json['transferExpiryDate'].toString();
	}
	if (json['dataBackgroundExpiryDate'] != null) {
		data.dataBackgroundExpiryDate = json['dataBackgroundExpiryDate'].toString();
	}
	if (json['customerQuotationExpiryDate'] != null) {
		data.customerQuotationExpiryDate = json['customerQuotationExpiryDate'].toString();
	}
	return data;
}

Map<String, dynamic> customerDeptDetailAndRoleDoCustomerDeptDetailDoToJson(CustomerDeptDetailAndRoleDoCustomerDeptDetailDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['phone'] = entity.phone;
	data['marketId'] = entity.marketId;
	data['province'] = entity.province;
	data['provinceCode'] = entity.provinceCode;
	data['city'] = entity.city;
	data['cityCode'] = entity.cityCode;
	data['district'] = entity.district;
	data['districtCode'] = entity.districtCode;
	data['address'] = entity.address;
	data['deptId'] = entity.deptId;
	data['logo'] = entity.logo;
	data['photoAlbumHeader'] = entity.photoAlbumHeader;
	data['wx'] = entity.wx;
	data['enableTime'] = entity.enableTime;
	data['longtitude'] = entity.longtitude;
	data['latitude'] = entity.latitude;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['firstActivatedTime'] = entity.firstActivatedTime;
	data['baseExpiryDate'] = entity.baseExpiryDate;
	data['offlineExpiryDate'] = entity.offlineExpiryDate;
	data['appBiExpiryDate'] = entity.appBiExpiryDate;
	data['substandardStockExpiryDate'] = entity.substandardStockExpiryDate;
	data['transferExpiryDate'] = entity.transferExpiryDate;
	data['dataBackgroundExpiryDate'] = entity.dataBackgroundExpiryDate;
	data['customerQuotationExpiryDate'] = entity.customerQuotationExpiryDate;
	return data;
}
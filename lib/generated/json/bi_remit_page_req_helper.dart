import 'package:haidai_flutter_module/page/bi/model/req/bi_remit_page_req.dart';

biRemitPageReqFromJson(BiRemitPageReq data, Map<String, dynamic> json) {
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['customizeStartTime'] != null) {
		data.customizeStartTime = json['customizeStartTime'].toString();
	}
	if (json['customizeEndTime'] != null) {
		data.customizeEndTime = json['customizeEndTime'].toString();
	}
	if (json['customerDeptIds'] != null) {
		data.customerDeptIds = (json['customerDeptIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['customerIds'] != null) {
		data.customerIds = (json['customerIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['merchandiserUserList'] != null) {
		data.merchandiserUserList = (json['merchandiserUserList'] as List).map((v) => BiRemitPageReqMerchandiserUserList().fromJson(v)).toList();
	}
	if (json['createUserUserList'] != null) {
		data.createUserUserList = (json['createUserUserList'] as List).map((v) => BiRemitPageReqCreateUserUserList().fromJson(v)).toList();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['levelTags'] != null) {
		data.levelTags = (json['levelTags'] as List).map((v) => BiRemitPageReqLevelTags().fromJson(v)).toList();
	}
	if (json['types'] != null) {
		data.types = (json['types'] as List).map((v) => BiRemitPageReqTypes().fromJson(v)).toList();
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['excludeColumnFiledNames'] != null) {
		data.excludeColumnFiledNames = (json['excludeColumnFiledNames'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['remitMethodIds'] != null) {
		data.remitMethodIds = (json['remitMethodIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['selectType'] != null) {
		data.selectType = json['selectType'].toString();
	}
	if (json['filterMerchandiser'] != null) {
		data.filterMerchandiser = json['filterMerchandiser'];
	}
	return data;
}

Map<String, dynamic> biRemitPageReqToJson(BiRemitPageReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['topDeptId'] = entity.topDeptId;
	data['customizeStartTime'] = entity.customizeStartTime;
	data['customizeEndTime'] = entity.customizeEndTime;
	data['customerDeptIds'] = entity.customerDeptIds;
	data['customerIds'] = entity.customerIds;
	data['merchandiserUserList'] =  entity.merchandiserUserList?.map((v) => v.toJson())?.toList();
	data['createUserUserList'] =  entity.createUserUserList?.map((v) => v.toJson())?.toList();
	data['canceled'] = entity.canceled;
	data['levelTags'] =  entity.levelTags?.map((v) => v.toJson())?.toList();
	data['types'] =  entity.types?.map((v) => v.toJson())?.toList();
	data['status'] = entity.status;
	data['excludeColumnFiledNames'] = entity.excludeColumnFiledNames;
	data['remitMethodIds'] = entity.remitMethodIds;
	data['selectType'] = entity.selectType;
	data['filterMerchandiser'] = entity.filterMerchandiser;
	return data;
}

biRemitPageReqMerchandiserUserListFromJson(BiRemitPageReqMerchandiserUserList data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	return data;
}

Map<String, dynamic> biRemitPageReqMerchandiserUserListToJson(BiRemitPageReqMerchandiserUserList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	return data;
}

biRemitPageReqCreateUserUserListFromJson(BiRemitPageReqCreateUserUserList data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	return data;
}

Map<String, dynamic> biRemitPageReqCreateUserUserListToJson(BiRemitPageReqCreateUserUserList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	return data;
}

biRemitPageReqLevelTagsFromJson(BiRemitPageReqLevelTags data, Map<String, dynamic> json) {
	if (json['value'] != null) {
		data.value = json['value'] is String
				? int.tryParse(json['value'])
				: json['value'].toInt();
	}
	if (json['desc'] != null) {
		data.desc = json['desc'].toString();
	}
	return data;
}

Map<String, dynamic> biRemitPageReqLevelTagsToJson(BiRemitPageReqLevelTags entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['value'] = entity.value;
	data['desc'] = entity.desc;
	return data;
}

biRemitPageReqTypesFromJson(BiRemitPageReqTypes data, Map<String, dynamic> json) {
	if (json['value'] != null) {
		data.value = json['value'] is String
				? int.tryParse(json['value'])
				: json['value'].toInt();
	}
	if (json['desc'] != null) {
		data.desc = json['desc'].toString();
	}
	return data;
}

Map<String, dynamic> biRemitPageReqTypesToJson(BiRemitPageReqTypes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['value'] = entity.value;
	data['desc'] = entity.desc;
	return data;
}
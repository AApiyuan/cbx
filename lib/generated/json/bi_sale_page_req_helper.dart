import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_page_req.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/req/merchandiser_user_list.dart';

biSalePageReqFromJson(BiSalePageReq data, Map<String, dynamic> json) {
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
	if (json['onSaleStartTime'] != null) {
		data.onSaleStartTime = json['onSaleStartTime'].toString();
	}
	if (json['onSaleEndTime'] != null) {
		data.onSaleEndTime = json['onSaleEndTime'].toString();
	}
	if (json['customerDeptIds'] != null) {
		data.customerDeptIds = (json['customerDeptIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['remitMethodIds'] != null) {
		data.remitMethodIds = (json['remitMethodIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['customerIds'] != null) {
		data.customerIds = (json['customerIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['merchandiserUserList'] != null) {
		data.merchandiserUserList = (json['merchandiserUserList'] as List).map((v) => MerchandiserUserList().fromJson(v)).toList();
	}
	if (json['createUserUserList'] != null) {
		data.createUserUserList = (json['createUserUserList'] as List).map((v) => BiSalePageReqCreateUserUserList().fromJson(v)).toList();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['levelTags'] != null) {
		data.levelTags = (json['levelTags'] as List).map((v) => BiSalePageReqLevelTags().fromJson(v)).toList();
	}
	if (json['excludeColumnFiledNames'] != null) {
		data.excludeColumnFiledNames = (json['excludeColumnFiledNames'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['selectType'] != null) {
		data.selectType = json['selectType'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['orderBy'] != null) {
		data.orderBy = OrderBy().fromJson(json['orderBy']);
	}
	if (json['toAllDept'] != null) {
		data.toAllDept = json['toAllDept'];
	}
	if (json['filterMerchandiser'] != null) {
		data.filterMerchandiser = json['filterMerchandiser'];
	}
	return data;
}

Map<String, dynamic> biSalePageReqToJson(BiSalePageReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['topDeptId'] = entity.topDeptId;
	data['customizeStartTime'] = entity.customizeStartTime;
	data['customizeEndTime'] = entity.customizeEndTime;
	data['onSaleStartTime'] = entity.onSaleStartTime;
	data['onSaleEndTime'] = entity.onSaleEndTime;
	data['customerDeptIds'] = entity.customerDeptIds;
	data['remitMethodIds'] = entity.remitMethodIds;
	data['customerIds'] = entity.customerIds;
	data['merchandiserUserList'] =  entity.merchandiserUserList?.map((v) => v.toJson())?.toList();
	data['createUserUserList'] =  entity.createUserUserList?.map((v) => v.toJson())?.toList();
	data['canceled'] = entity.canceled;
	data['levelTags'] =  entity.levelTags?.map((v) => v.toJson())?.toList();
	data['excludeColumnFiledNames'] = entity.excludeColumnFiledNames;
	data['selectType'] = entity.selectType;
	data['type'] = entity.type;
	data['status'] = entity.status;
	data['orderBy'] = entity.orderBy?.toJson();
	data['toAllDept'] = entity.toAllDept;
	data['filterMerchandiser'] = entity.filterMerchandiser;
	return data;
}

biSalePageReqMerchandiserUserListFromJson(BiSalePageReqMerchandiserUserList data, Map<String, dynamic> json) {
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

Map<String, dynamic> biSalePageReqMerchandiserUserListToJson(BiSalePageReqMerchandiserUserList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	return data;
}

biSalePageReqCreateUserUserListFromJson(BiSalePageReqCreateUserUserList data, Map<String, dynamic> json) {
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

Map<String, dynamic> biSalePageReqCreateUserUserListToJson(BiSalePageReqCreateUserUserList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	return data;
}

biSalePageReqLevelTagsFromJson(BiSalePageReqLevelTags data, Map<String, dynamic> json) {
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

Map<String, dynamic> biSalePageReqLevelTagsToJson(BiSalePageReqLevelTags entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['value'] = entity.value;
	data['desc'] = entity.desc;
	return data;
}

biSalePageReqOrderByFromJson(BiSalePageReqOrderBy data, Map<String, dynamic> json) {
	if (json['field'] != null) {
		data.field = json['field'].toString();
	}
	if (json['by'] != null) {
		data.by = json['by'].toString();
	}
	return data;
}

Map<String, dynamic> biSalePageReqOrderByToJson(BiSalePageReqOrderBy entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['field'] = entity.field;
	data['by'] = entity.by;
	return data;
}
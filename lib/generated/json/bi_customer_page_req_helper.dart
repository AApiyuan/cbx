import 'package:haidai_flutter_module/page/bi/model/req/bi_customer_page_req.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/req/merchandiser_user_list.dart';

biCustomerPageReqFromJson(BiCustomerPageReq data, Map<String, dynamic> json) {
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
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
		data.merchandiserUserList = (json['merchandiserUserList'] as List).map((v) => MerchandiserUserList().fromJson(v)).toList();
	}
	if (json['levelTags'] != null) {
		data.levelTags = (json['levelTags'] as List).map((v) => BiCustomerPageReqLevelTags().fromJson(v)).toList();
	}
	if (json['createdStartTime'] != null) {
		data.createdStartTime = json['createdStartTime'].toString();
	}
	if (json['createdEndTime'] != null) {
		data.createdEndTime = json['createdEndTime'].toString();
	}
	if (json['excludeColumnFiledNames'] != null) {
		data.excludeColumnFiledNames = (json['excludeColumnFiledNames'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['toAllDept'] != null) {
		data.toAllDept = json['toAllDept'];
	}
	if (json['orderBy'] != null) {
		data.orderBy = OrderBy().fromJson(json['orderBy']);
	}
	if (json['filterMerchandiser'] != null) {
		data.filterMerchandiser = json['filterMerchandiser'];
	}
	return data;
}

Map<String, dynamic> biCustomerPageReqToJson(BiCustomerPageReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['topDeptId'] = entity.topDeptId;
	data['customerDeptIds'] = entity.customerDeptIds;
	data['customerIds'] = entity.customerIds;
	data['merchandiserUserList'] =  entity.merchandiserUserList?.map((v) => v.toJson())?.toList();
	data['levelTags'] =  entity.levelTags?.map((v) => v.toJson())?.toList();
	data['createdStartTime'] = entity.createdStartTime;
	data['createdEndTime'] = entity.createdEndTime;
	data['excludeColumnFiledNames'] = entity.excludeColumnFiledNames;
	data['toAllDept'] = entity.toAllDept;
	data['orderBy'] = entity.orderBy?.toJson();
	data['filterMerchandiser'] = entity.filterMerchandiser;
	return data;
}

biCustomerPageReqMerchandiserUserListFromJson(BiCustomerPageReqMerchandiserUserList data, Map<String, dynamic> json) {
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

Map<String, dynamic> biCustomerPageReqMerchandiserUserListToJson(BiCustomerPageReqMerchandiserUserList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	return data;
}

biCustomerPageReqLevelTagsFromJson(BiCustomerPageReqLevelTags data, Map<String, dynamic> json) {
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

Map<String, dynamic> biCustomerPageReqLevelTagsToJson(BiCustomerPageReqLevelTags entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['value'] = entity.value;
	data['desc'] = entity.desc;
	return data;
}

biCustomerPageReqOrderByFromJson(BiCustomerPageReqOrderBy data, Map<String, dynamic> json) {
	if (json['field'] != null) {
		data.field = json['field'].toString();
	}
	if (json['by'] != null) {
		data.by = json['by'].toString();
	}
	return data;
}

Map<String, dynamic> biCustomerPageReqOrderByToJson(BiCustomerPageReqOrderBy entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['field'] = entity.field;
	data['by'] = entity.by;
	return data;
}
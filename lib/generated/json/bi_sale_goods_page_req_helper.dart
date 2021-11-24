import 'package:haidai_flutter_module/page/bi/model/req/bi_sale_goods_page_req.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/req/merchandiser_user_list.dart';

biSaleGoodsPageReqFromJson(BiSaleGoodsPageReq data, Map<String, dynamic> json) {
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
		data.merchandiserUserList = (json['merchandiserUserList'] as List).map((v) => MerchandiserUserList().fromJson(v)).toList();
	}
	if (json['createUserUserList'] != null) {
		data.createUserUserList = (json['createUserUserList'] as List).map((v) => BiSaleGoodsPageReqCreateUserUserList().fromJson(v)).toList();
	}
	if (json['types'] != null) {
		data.types = (json['types'] as List).map((v) => BiSaleGoodsPageReqTypes().fromJson(v)).toList();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'];
	}
	if (json['levelTags'] != null) {
		data.levelTags = (json['levelTags'] as List).map((v) => BiSaleGoodsPageReqLevelTags().fromJson(v)).toList();
	}
	if (json['goodsIds'] != null) {
		data.goodsIds = (json['goodsIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['goodsClassify'] != null) {
		data.goodsClassify = json['goodsClassify'] is String
				? int.tryParse(json['goodsClassify'])
				: json['goodsClassify'].toInt();
	}
	if (json['goodsClassifyMiddle'] != null) {
		data.goodsClassifyMiddle = json['goodsClassifyMiddle'] is String
				? int.tryParse(json['goodsClassifyMiddle'])
				: json['goodsClassifyMiddle'].toInt();
	}
	if (json['goodsClassifySmall'] != null) {
		data.goodsClassifySmall = json['goodsClassifySmall'] is String
				? int.tryParse(json['goodsClassifySmall'])
				: json['goodsClassifySmall'].toInt();
	}
	if (json['goodsBrands'] != null) {
		data.goodsBrands = (json['goodsBrands'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['goodsYears'] != null) {
		data.goodsYears = (json['goodsYears'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['goodsSeasons'] != null) {
		data.goodsSeasons = (json['goodsSeasons'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['goodsLabels'] != null) {
		data.goodsLabels = (json['goodsLabels'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['excludeColumnFiledNames'] != null) {
		data.excludeColumnFiledNames = (json['excludeColumnFiledNames'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['selectType'] != null) {
		data.selectType = json['selectType'].toString();
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

Map<String, dynamic> biSaleGoodsPageReqToJson(BiSaleGoodsPageReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['topDeptId'] = entity.topDeptId;
	data['customizeStartTime'] = entity.customizeStartTime;
	data['customizeEndTime'] = entity.customizeEndTime;
	data['customerDeptIds'] = entity.customerDeptIds;
	data['customerIds'] = entity.customerIds;
	data['merchandiserUserList'] =  entity.merchandiserUserList?.map((v) => v.toJson())?.toList();
	data['createUserUserList'] =  entity.createUserUserList?.map((v) => v.toJson())?.toList();
	data['types'] =  entity.types?.map((v) => v.toJson())?.toList();
	data['canceled'] = entity.canceled;
	data['levelTags'] =  entity.levelTags?.map((v) => v.toJson())?.toList();
	data['goodsIds'] = entity.goodsIds;
	data['goodsClassify'] = entity.goodsClassify;
	data['goodsClassifyMiddle'] = entity.goodsClassifyMiddle;
	data['goodsClassifySmall'] = entity.goodsClassifySmall;
	data['goodsBrands'] = entity.goodsBrands;
	data['goodsYears'] = entity.goodsYears;
	data['goodsSeasons'] = entity.goodsSeasons;
	data['goodsLabels'] = entity.goodsLabels;
	data['excludeColumnFiledNames'] = entity.excludeColumnFiledNames;
	data['selectType'] = entity.selectType;
	data['toAllDept'] = entity.toAllDept;
	data['orderBy'] = entity.orderBy?.toJson();
	data['filterMerchandiser'] = entity.filterMerchandiser;
	return data;
}

biSaleGoodsPageReqMerchandiserUserListFromJson(BiSaleGoodsPageReqMerchandiserUserList data, Map<String, dynamic> json) {
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

Map<String, dynamic> biSaleGoodsPageReqMerchandiserUserListToJson(BiSaleGoodsPageReqMerchandiserUserList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	return data;
}

biSaleGoodsPageReqCreateUserUserListFromJson(BiSaleGoodsPageReqCreateUserUserList data, Map<String, dynamic> json) {
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

Map<String, dynamic> biSaleGoodsPageReqCreateUserUserListToJson(BiSaleGoodsPageReqCreateUserUserList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	return data;
}

biSaleGoodsPageReqTypesFromJson(BiSaleGoodsPageReqTypes data, Map<String, dynamic> json) {
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

Map<String, dynamic> biSaleGoodsPageReqTypesToJson(BiSaleGoodsPageReqTypes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['value'] = entity.value;
	data['desc'] = entity.desc;
	return data;
}

biSaleGoodsPageReqLevelTagsFromJson(BiSaleGoodsPageReqLevelTags data, Map<String, dynamic> json) {
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

Map<String, dynamic> biSaleGoodsPageReqLevelTagsToJson(BiSaleGoodsPageReqLevelTags entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['value'] = entity.value;
	data['desc'] = entity.desc;
	return data;
}

biSaleGoodsPageReqOrderByFromJson(BiSaleGoodsPageReqOrderBy data, Map<String, dynamic> json) {
	if (json['field'] != null) {
		data.field = json['field'].toString();
	}
	if (json['by'] != null) {
		data.by = json['by'].toString();
	}
	return data;
}

Map<String, dynamic> biSaleGoodsPageReqOrderByToJson(BiSaleGoodsPageReqOrderBy entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['field'] = entity.field;
	data['by'] = entity.by;
	return data;
}
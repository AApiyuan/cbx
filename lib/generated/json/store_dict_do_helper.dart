import 'package:haidai_flutter_module/model/store_dict_do.dart';

storeDictDoFromJson(StoreDictDo data, Map<String, dynamic> json) {
	if (json['MODEL'] != null) {
		data.mODEL = (json['MODEL'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['DESIGNER_NUMBER'] != null) {
		data.designerNumber = (json['DESIGNER_NUMBER'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['COMPONENT'] != null) {
		data.cOMPONENT = (json['COMPONENT'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['STREAM'] != null) {
		data.sTREAM = (json['STREAM'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['SUBSTANDARD_GOODS'] != null) {
		data.substandardGoods = (json['SUBSTANDARD_GOODS'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['CODE_TYPE'] != null) {
		data.codeType = (json['CODE_TYPE'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['PLATE_TYPE'] != null) {
		data.plateType = (json['PLATE_TYPE'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['WARE_HOUSING'] != null) {
		data.wareHousing = (json['WARE_HOUSING'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['MINIMUM_ORDER_QUANTITY'] != null) {
		data.minimumOrderQuantity = (json['MINIMUM_ORDER_QUANTITY'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['STANDARD'] != null) {
		data.sTANDARD = (json['STANDARD'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['CHECK_NAME'] != null) {
		data.checkName = (json['CHECK_NAME'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['GOODS_CLASSIFY_MIDDLE'] != null) {
		data.goodsClassifyMiddle = (json['GOODS_CLASSIFY_MIDDLE'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['PATTERN'] != null) {
		data.pATTERN = (json['PATTERN'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['GENDER'] != null) {
		data.gENDER = (json['GENDER'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['AGE'] != null) {
		data.aGE = (json['AGE'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['SERIES'] != null) {
		data.sERIES = (json['SERIES'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['POPULAR_ELEMENTS'] != null) {
		data.popularElements = (json['POPULAR_ELEMENTS'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['GOODS_SEASON'] != null) {
		data.goodsSeason = (json['GOODS_SEASON'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['QUALIFY_LEVEL'] != null) {
		data.qualifyLevel = (json['QUALIFY_LEVEL'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['GOODS_YEAR'] != null) {
		data.goodsYear = (json['GOODS_YEAR'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['GOODS_CLASSIFY_SMALL'] != null) {
		data.goodsClassifySmall = (json['GOODS_CLASSIFY_SMALL'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['LEVEL'] != null) {
		data.lEVEL = (json['LEVEL'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['GOODS_LABEL'] != null) {
		data.goodsLabel = (json['GOODS_LABEL'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['DELIVERY_DATE'] != null) {
		data.deliveryDate = (json['DELIVERY_DATE'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['MATERIAL'] != null) {
		data.mATERIAL = (json['MATERIAL'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['STYLE'] != null) {
		data.sTYLE = (json['STYLE'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['TECHNOLOGY'] != null) {
		data.tECHNOLOGY = (json['TECHNOLOGY'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['AREA'] != null) {
		data.aREA = (json['AREA'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['GOODS_CLASSIFY'] != null) {
		data.goodsClassify = (json['GOODS_CLASSIFY'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['GOODS_BRAND'] != null) {
		data.goodsBrand = (json['GOODS_BRAND'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['SELLING_POINT'] != null) {
		data.sellingPoint = (json['SELLING_POINT'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['LOGISTICS_COMPANY'] != null) {
		data.logisticsCompany = (json['LOGISTICS_COMPANY'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['SECURITY_TYPE'] != null) {
		data.securityType = (json['SECURITY_TYPE'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	if (json['OUT_OF_STOCK_TAG'] != null) {
		data.outOfStockTag = (json['OUT_OF_STOCK_TAG'] as List).map((v) => StoreDictData().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> storeDictDoToJson(StoreDictDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['MODEL'] =  entity.mODEL?.map((v) => v.toJson())?.toList();
	data['DESIGNER_NUMBER'] =  entity.designerNumber?.map((v) => v.toJson())?.toList();
	data['COMPONENT'] =  entity.cOMPONENT?.map((v) => v.toJson())?.toList();
	data['STREAM'] =  entity.sTREAM?.map((v) => v.toJson())?.toList();
	data['SUBSTANDARD_GOODS'] =  entity.substandardGoods?.map((v) => v.toJson())?.toList();
	data['CODE_TYPE'] =  entity.codeType?.map((v) => v.toJson())?.toList();
	data['PLATE_TYPE'] =  entity.plateType?.map((v) => v.toJson())?.toList();
	data['WARE_HOUSING'] =  entity.wareHousing?.map((v) => v.toJson())?.toList();
	data['MINIMUM_ORDER_QUANTITY'] =  entity.minimumOrderQuantity?.map((v) => v.toJson())?.toList();
	data['STANDARD'] =  entity.sTANDARD?.map((v) => v.toJson())?.toList();
	data['CHECK_NAME'] =  entity.checkName?.map((v) => v.toJson())?.toList();
	data['GOODS_CLASSIFY_MIDDLE'] =  entity.goodsClassifyMiddle?.map((v) => v.toJson())?.toList();
	data['PATTERN'] =  entity.pATTERN?.map((v) => v.toJson())?.toList();
	data['GENDER'] =  entity.gENDER?.map((v) => v.toJson())?.toList();
	data['AGE'] =  entity.aGE?.map((v) => v.toJson())?.toList();
	data['SERIES'] =  entity.sERIES?.map((v) => v.toJson())?.toList();
	data['POPULAR_ELEMENTS'] =  entity.popularElements?.map((v) => v.toJson())?.toList();
	data['GOODS_SEASON'] =  entity.goodsSeason?.map((v) => v.toJson())?.toList();
	data['QUALIFY_LEVEL'] =  entity.qualifyLevel?.map((v) => v.toJson())?.toList();
	data['GOODS_YEAR'] =  entity.goodsYear?.map((v) => v.toJson())?.toList();
	data['GOODS_CLASSIFY_SMALL'] =  entity.goodsClassifySmall?.map((v) => v.toJson())?.toList();
	data['LEVEL'] =  entity.lEVEL?.map((v) => v.toJson())?.toList();
	data['GOODS_LABEL'] =  entity.goodsLabel?.map((v) => v.toJson())?.toList();
	data['DELIVERY_DATE'] =  entity.deliveryDate?.map((v) => v.toJson())?.toList();
	data['MATERIAL'] =  entity.mATERIAL?.map((v) => v.toJson())?.toList();
	data['STYLE'] =  entity.sTYLE?.map((v) => v.toJson())?.toList();
	data['TECHNOLOGY'] =  entity.tECHNOLOGY?.map((v) => v.toJson())?.toList();
	data['AREA'] =  entity.aREA?.map((v) => v.toJson())?.toList();
	data['GOODS_CLASSIFY'] =  entity.goodsClassify?.map((v) => v.toJson())?.toList();
	data['GOODS_BRAND'] =  entity.goodsBrand?.map((v) => v.toJson())?.toList();
	data['SELLING_POINT'] =  entity.sellingPoint?.map((v) => v.toJson())?.toList();
	data['LOGISTICS_COMPANY'] =  entity.logisticsCompany?.map((v) => v.toJson())?.toList();
	data['SECURITY_TYPE'] =  entity.securityType?.map((v) => v.toJson())?.toList();
	data['OUT_OF_STOCK_TAG'] =  entity.outOfStockTag?.map((v) => v.toJson())?.toList();
	return data;
}

storeDictDataFromJson(StoreDictData data, Map<String, dynamic> json) {
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
	if (json['parentId'] != null) {
		data.parentId = json['parentId'] is String
				? int.tryParse(json['parentId'])
				: json['parentId'].toInt();
	}
	if (json['dictName'] != null) {
		data.dictName = json['dictName'].toString();
	}
	if (json['dictType'] != null) {
		data.dictType = json['dictType'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['useNum'] != null) {
		data.useNum = json['useNum'] is String
				? int.tryParse(json['useNum'])
				: json['useNum'].toInt();
	}
	return data;
}

Map<String, dynamic> storeDictDataToJson(StoreDictData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['parentId'] = entity.parentId;
	data['dictName'] = entity.dictName;
	data['dictType'] = entity.dictType;
	data['sort'] = entity.sort;
	data['status'] = entity.status;
	data['useNum'] = entity.useNum;
	return data;
}
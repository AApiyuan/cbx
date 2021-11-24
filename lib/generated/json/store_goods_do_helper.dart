import 'package:haidai_flutter_module/model/goods/store_goods_do.dart';

storeGoodsDoFromJson(StoreGoodsDo data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['colors'] != null) {
		data.colors = (json['colors'] as List).map((v) => StoreGoodsDoColors().fromJson(v)).toList();
	}
	if (json['sizes'] != null) {
		data.sizes = (json['sizes'] as List).map((v) => StoreGoodsDoSizes().fromJson(v)).toList();
	}
	if (json['deptDos'] != null) {
		data.deptDos = (json['deptDos'] as List).map((v) => StoreGoodsDoDeptDos().fromJson(v)).toList();
	}
	if (json['goodsNameSerial'] != null) {
		data.goodsNameSerial = json['goodsNameSerial'].toString();
	}
	if (json['imgPath'] != null) {
		data.imgPath = json['imgPath'].toString();
	}
	if (json['onSaleTime'] != null) {
		data.onSaleTime = json['onSaleTime'] is String
				? int.tryParse(json['onSaleTime'])
				: json['onSaleTime'].toInt();
	}
	if (json['onSaleUser'] != null) {
		data.onSaleUser = json['onSaleUser'] is String
				? int.tryParse(json['onSaleUser'])
				: json['onSaleUser'].toInt();
	}
	if (json['onSaleType'] != null) {
		data.onSaleType = json['onSaleType'];
	}
	if (json['onSaleUserName'] != null) {
		data.onSaleUserName = json['onSaleUserName'].toString();
	}
	if (json['sailingPrice'] != null) {
		data.sailingPrice = json['sailingPrice'] is String
				? int.tryParse(json['sailingPrice'])
				: json['sailingPrice'].toInt();
	}
	if (json['takingPrice'] != null) {
		data.takingPrice = json['takingPrice'] is String
				? int.tryParse(json['takingPrice'])
				: json['takingPrice'].toInt();
	}
	if (json['packagePrice'] != null) {
		data.packagePrice = json['packagePrice'] is String
				? int.tryParse(json['packagePrice'])
				: json['packagePrice'].toInt();
	}
	if (json['costPrice'] != null) {
		data.costPrice = json['costPrice'] is String
				? int.tryParse(json['costPrice'])
				: json['costPrice'].toInt();
	}
	if (json['goodsClassify'] != null) {
		data.goodsClassify = json['goodsClassify'] is String
				? int.tryParse(json['goodsClassify'])
				: json['goodsClassify'].toInt();
	}
	if (json['goodsClassifyName'] != null) {
		data.goodsClassifyName = json['goodsClassifyName'].toString();
	}
	if (json['goodsClassifyMiddle'] != null) {
		data.goodsClassifyMiddle = json['goodsClassifyMiddle'] is String
				? int.tryParse(json['goodsClassifyMiddle'])
				: json['goodsClassifyMiddle'].toInt();
	}
	if (json['goodsClassifyMiddleName'] != null) {
		data.goodsClassifyMiddleName = json['goodsClassifyMiddleName'].toString();
	}
	if (json['goodsClassifySmall'] != null) {
		data.goodsClassifySmall = json['goodsClassifySmall'] is String
				? int.tryParse(json['goodsClassifySmall'])
				: json['goodsClassifySmall'].toInt();
	}
	if (json['goodsClassifySmallName'] != null) {
		data.goodsClassifySmallName = json['goodsClassifySmallName'].toString();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['goodsImgs'] != null) {
		data.goodsImgs = json['goodsImgs'].toString();
	}
	if (json['goodsDetail'] != null) {
		data.goodsDetail = json['goodsDetail'].toString();
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['intro'] != null) {
		data.intro = json['intro'].toString();
	}
	if (json['supplierId'] != null) {
		data.supplierId = json['supplierId'] is String
				? int.tryParse(json['supplierId'])
				: json['supplierId'].toInt();
	}
	if (json['supplierName'] != null) {
		data.supplierName = json['supplierName'].toString();
	}
	if (json['supplierSerial'] != null) {
		data.supplierSerial = json['supplierSerial'].toString();
	}
	if (json['goodsBrand'] != null) {
		data.goodsBrand = json['goodsBrand'] is String
				? int.tryParse(json['goodsBrand'])
				: json['goodsBrand'].toInt();
	}
	if (json['goodsBrandName'] != null) {
		data.goodsBrandName = json['goodsBrandName'].toString();
	}
	if (json['goodsYear'] != null) {
		data.goodsYear = json['goodsYear'] is String
				? int.tryParse(json['goodsYear'])
				: json['goodsYear'].toInt();
	}
	if (json['goodsYearName'] != null) {
		data.goodsYearName = json['goodsYearName'].toString();
	}
	if (json['goodsSeason'] != null) {
		data.goodsSeason = json['goodsSeason'] is String
				? int.tryParse(json['goodsSeason'])
				: json['goodsSeason'].toInt();
	}
	if (json['goodsSeasonName'] != null) {
		data.goodsSeasonName = json['goodsSeasonName'].toString();
	}
	if (json['goodsLabel'] != null) {
		data.goodsLabel = json['goodsLabel'] is String
				? int.tryParse(json['goodsLabel'])
				: json['goodsLabel'].toInt();
	}
	if (json['goodsLabelName'] != null) {
		data.goodsLabelName = json['goodsLabelName'].toString();
	}
	if (json['designNum'] != null) {
		data.designNum = json['designNum'] is String
				? int.tryParse(json['designNum'])
				: json['designNum'].toInt();
	}
	if (json['designNumName'] != null) {
		data.designNumName = json['designNumName'].toString();
	}
	if (json['designSerial'] != null) {
		data.designSerial = json['designSerial'].toString();
	}
	if (json['stream'] != null) {
		data.stream = json['stream'] is String
				? int.tryParse(json['stream'])
				: json['stream'].toInt();
	}
	if (json['streamName'] != null) {
		data.streamName = json['streamName'].toString();
	}
	if (json['codeType'] != null) {
		data.codeType = json['codeType'] is String
				? int.tryParse(json['codeType'])
				: json['codeType'].toInt();
	}
	if (json['codeTypeName'] != null) {
		data.codeTypeName = json['codeTypeName'].toString();
	}
	if (json['securityType'] != null) {
		data.securityType = json['securityType'] is String
				? int.tryParse(json['securityType'])
				: json['securityType'].toInt();
	}
	if (json['securityTypeName'] != null) {
		data.securityTypeName = json['securityTypeName'].toString();
	}
	if (json['standards'] != null) {
		data.standards = json['standards'] is String
				? int.tryParse(json['standards'])
				: json['standards'].toInt();
	}
	if (json['standardsName'] != null) {
		data.standardsName = json['standardsName'].toString();
	}
	if (json['qualifyLevel'] != null) {
		data.qualifyLevel = json['qualifyLevel'] is String
				? int.tryParse(json['qualifyLevel'])
				: json['qualifyLevel'].toInt();
	}
	if (json['qualifyLevelName'] != null) {
		data.qualifyLevelName = json['qualifyLevelName'].toString();
	}
	if (json['area'] != null) {
		data.area = json['area'] is String
				? int.tryParse(json['area'])
				: json['area'].toInt();
	}
	if (json['areaName'] != null) {
		data.areaName = json['areaName'].toString();
	}
	if (json['levelTag'] != null) {
		data.levelTag = json['levelTag'] is String
				? int.tryParse(json['levelTag'])
				: json['levelTag'].toInt();
	}
	if (json['levelTagName'] != null) {
		data.levelTagName = json['levelTagName'].toString();
	}
	if (json['checkName'] != null) {
		data.checkName = json['checkName'] is String
				? int.tryParse(json['checkName'])
				: json['checkName'].toInt();
	}
	if (json['checkUserName'] != null) {
		data.checkUserName = json['checkUserName'].toString();
	}
	if (json['deliveryDate'] != null) {
		data.deliveryDate = json['deliveryDate'] is String
				? int.tryParse(json['deliveryDate'])
				: json['deliveryDate'].toInt();
	}
	if (json['deliveryDateName'] != null) {
		data.deliveryDateName = json['deliveryDateName'].toString();
	}
	if (json['minimumOrderQuantity'] != null) {
		data.minimumOrderQuantity = json['minimumOrderQuantity'] is String
				? int.tryParse(json['minimumOrderQuantity'])
				: json['minimumOrderQuantity'].toInt();
	}
	if (json['minimumOrderQuantityName'] != null) {
		data.minimumOrderQuantityName = json['minimumOrderQuantityName'].toString();
	}
	if (json['fabricA'] != null) {
		data.fabricA = json['fabricA'] is String
				? int.tryParse(json['fabricA'])
				: json['fabricA'].toInt();
	}
	if (json['fabricAName'] != null) {
		data.fabricAName = json['fabricAName'].toString();
	}
	if (json['fabricB'] != null) {
		data.fabricB = json['fabricB'] is String
				? int.tryParse(json['fabricB'])
				: json['fabricB'].toInt();
	}
	if (json['fabricC'] != null) {
		data.fabricC = json['fabricC'] is String
				? int.tryParse(json['fabricC'])
				: json['fabricC'].toInt();
	}
	if (json['accessoriesA'] != null) {
		data.accessoriesA = json['accessoriesA'] is String
				? int.tryParse(json['accessoriesA'])
				: json['accessoriesA'].toInt();
	}
	if (json['accessoriesAName'] != null) {
		data.accessoriesAName = json['accessoriesAName'].toString();
	}
	if (json['accessoriesB'] != null) {
		data.accessoriesB = json['accessoriesB'] is String
				? int.tryParse(json['accessoriesB'])
				: json['accessoriesB'].toInt();
	}
	if (json['accessoriesC'] != null) {
		data.accessoriesC = json['accessoriesC'] is String
				? int.tryParse(json['accessoriesC'])
				: json['accessoriesC'].toInt();
	}
	if (json['age'] != null) {
		data.age = json['age'] is String
				? int.tryParse(json['age'])
				: json['age'].toInt();
	}
	if (json['ageName'] != null) {
		data.ageName = json['ageName'].toString();
	}
	if (json['material'] != null) {
		data.material = json['material'] is String
				? int.tryParse(json['material'])
				: json['material'].toInt();
	}
	if (json['materialName'] != null) {
		data.materialName = json['materialName'].toString();
	}
	if (json['pattern'] != null) {
		data.pattern = json['pattern'] is String
				? int.tryParse(json['pattern'])
				: json['pattern'].toInt();
	}
	if (json['patternName'] != null) {
		data.patternName = json['patternName'].toString();
	}
	if (json['style'] != null) {
		data.style = json['style'] is String
				? int.tryParse(json['style'])
				: json['style'].toInt();
	}
	if (json['styleName'] != null) {
		data.styleName = json['styleName'].toString();
	}
	if (json['component'] != null) {
		data.component = json['component'] is String
				? int.tryParse(json['component'])
				: json['component'].toInt();
	}
	if (json['componentName'] != null) {
		data.componentName = json['componentName'].toString();
	}
	if (json['sellingPoint'] != null) {
		data.sellingPoint = json['sellingPoint'] is String
				? int.tryParse(json['sellingPoint'])
				: json['sellingPoint'].toInt();
	}
	if (json['sellingPointName'] != null) {
		data.sellingPointName = json['sellingPointName'].toString();
	}
	if (json['popularElement'] != null) {
		data.popularElement = json['popularElement'] is String
				? int.tryParse(json['popularElement'])
				: json['popularElement'].toInt();
	}
	if (json['popularElementName'] != null) {
		data.popularElementName = json['popularElementName'].toString();
	}
	if (json['technology'] != null) {
		data.technology = json['technology'] is String
				? int.tryParse(json['technology'])
				: json['technology'].toInt();
	}
	if (json['technologyName'] != null) {
		data.technologyName = json['technologyName'].toString();
	}
	if (json['plateType'] != null) {
		data.plateType = json['plateType'] is String
				? int.tryParse(json['plateType'])
				: json['plateType'].toInt();
	}
	if (json['plateTypeName'] != null) {
		data.plateTypeName = json['plateTypeName'].toString();
	}
	if (json['model'] != null) {
		data.model = json['model'] is String
				? int.tryParse(json['model'])
				: json['model'].toInt();
	}
	if (json['modelName'] != null) {
		data.modelName = json['modelName'].toString();
	}
	if (json['gender'] != null) {
		data.gender = json['gender'] is String
				? int.tryParse(json['gender'])
				: json['gender'].toInt();
	}
	if (json['genderName'] != null) {
		data.genderName = json['genderName'].toString();
	}
	if (json['series'] != null) {
		data.series = json['series'] is String
				? int.tryParse(json['series'])
				: json['series'].toInt();
	}
	if (json['seriesName'] != null) {
		data.seriesName = json['seriesName'].toString();
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

Map<String, dynamic> storeGoodsDoToJson(StoreGoodsDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['goodsSerial'] = entity.goodsSerial;
	data['colors'] =  entity.colors?.map((v) => v.toJson())?.toList();
	data['sizes'] =  entity.sizes?.map((v) => v.toJson())?.toList();
	data['deptDos'] =  entity.deptDos?.map((v) => v.toJson())?.toList();
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['imgPath'] = entity.imgPath;
	data['onSaleTime'] = entity.onSaleTime;
	data['onSaleUser'] = entity.onSaleUser;
	data['onSaleType'] = entity.onSaleType;
	data['onSaleUserName'] = entity.onSaleUserName;
	data['sailingPrice'] = entity.sailingPrice;
	data['takingPrice'] = entity.takingPrice;
	data['packagePrice'] = entity.packagePrice;
	data['costPrice'] = entity.costPrice;
	data['goodsClassify'] = entity.goodsClassify;
	data['goodsClassifyName'] = entity.goodsClassifyName;
	data['goodsClassifyMiddle'] = entity.goodsClassifyMiddle;
	data['goodsClassifyMiddleName'] = entity.goodsClassifyMiddleName;
	data['goodsClassifySmall'] = entity.goodsClassifySmall;
	data['goodsClassifySmallName'] = entity.goodsClassifySmallName;
	data['cover'] = entity.cover;
	data['goodsImgs'] = entity.goodsImgs;
	data['goodsDetail'] = entity.goodsDetail;
	data['goodsName'] = entity.goodsName;
	data['intro'] = entity.intro;
	data['supplierId'] = entity.supplierId;
	data['supplierName'] = entity.supplierName;
	data['supplierSerial'] = entity.supplierSerial;
	data['goodsBrand'] = entity.goodsBrand;
	data['goodsBrandName'] = entity.goodsBrandName;
	data['goodsYear'] = entity.goodsYear;
	data['goodsYearName'] = entity.goodsYearName;
	data['goodsSeason'] = entity.goodsSeason;
	data['goodsSeasonName'] = entity.goodsSeasonName;
	data['goodsLabel'] = entity.goodsLabel;
	data['goodsLabelName'] = entity.goodsLabelName;
	data['designNum'] = entity.designNum;
	data['designNumName'] = entity.designNumName;
	data['designSerial'] = entity.designSerial;
	data['stream'] = entity.stream;
	data['streamName'] = entity.streamName;
	data['codeType'] = entity.codeType;
	data['codeTypeName'] = entity.codeTypeName;
	data['securityType'] = entity.securityType;
	data['securityTypeName'] = entity.securityTypeName;
	data['standards'] = entity.standards;
	data['standardsName'] = entity.standardsName;
	data['qualifyLevel'] = entity.qualifyLevel;
	data['qualifyLevelName'] = entity.qualifyLevelName;
	data['area'] = entity.area;
	data['areaName'] = entity.areaName;
	data['levelTag'] = entity.levelTag;
	data['levelTagName'] = entity.levelTagName;
	data['checkName'] = entity.checkName;
	data['checkUserName'] = entity.checkUserName;
	data['deliveryDate'] = entity.deliveryDate;
	data['deliveryDateName'] = entity.deliveryDateName;
	data['minimumOrderQuantity'] = entity.minimumOrderQuantity;
	data['minimumOrderQuantityName'] = entity.minimumOrderQuantityName;
	data['fabricA'] = entity.fabricA;
	data['fabricAName'] = entity.fabricAName;
	data['fabricB'] = entity.fabricB;
	data['fabricC'] = entity.fabricC;
	data['accessoriesA'] = entity.accessoriesA;
	data['accessoriesAName'] = entity.accessoriesAName;
	data['accessoriesB'] = entity.accessoriesB;
	data['accessoriesC'] = entity.accessoriesC;
	data['age'] = entity.age;
	data['ageName'] = entity.ageName;
	data['material'] = entity.material;
	data['materialName'] = entity.materialName;
	data['pattern'] = entity.pattern;
	data['patternName'] = entity.patternName;
	data['style'] = entity.style;
	data['styleName'] = entity.styleName;
	data['component'] = entity.component;
	data['componentName'] = entity.componentName;
	data['sellingPoint'] = entity.sellingPoint;
	data['sellingPointName'] = entity.sellingPointName;
	data['popularElement'] = entity.popularElement;
	data['popularElementName'] = entity.popularElementName;
	data['technology'] = entity.technology;
	data['technologyName'] = entity.technologyName;
	data['plateType'] = entity.plateType;
	data['plateTypeName'] = entity.plateTypeName;
	data['model'] = entity.model;
	data['modelName'] = entity.modelName;
	data['gender'] = entity.gender;
	data['genderName'] = entity.genderName;
	data['series'] = entity.series;
	data['seriesName'] = entity.seriesName;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

storeGoodsDoColorsFromJson(StoreGoodsDoColors data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['color'] != null) {
		data.color = json['color'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'];
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	if (json['styleGroupId'] != null) {
		data.styleGroupId = json['styleGroupId'] is String
				? int.tryParse(json['styleGroupId'])
				: json['styleGroupId'].toInt();
	}
	return data;
}

Map<String, dynamic> storeGoodsDoColorsToJson(StoreGoodsDoColors entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['id'] = entity.id;
	data['code'] = entity.code;
	data['color'] = entity.color;
	data['type'] = entity.type;
	data['status'] = entity.status;
	data['sort'] = entity.sort;
	data['styleGroupId'] = entity.styleGroupId;
	return data;
}

storeGoodsDoSizesFromJson(StoreGoodsDoSizes data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['color'] != null) {
		data.color = json['color'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'];
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	if (json['styleGroupId'] != null) {
		data.styleGroupId = json['styleGroupId'] is String
				? int.tryParse(json['styleGroupId'])
				: json['styleGroupId'].toInt();
	}
	return data;
}

Map<String, dynamic> storeGoodsDoSizesToJson(StoreGoodsDoSizes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['id'] = entity.id;
	data['code'] = entity.code;
	data['color'] = entity.color;
	data['type'] = entity.type;
	data['status'] = entity.status;
	data['sort'] = entity.sort;
	data['styleGroupId'] = entity.styleGroupId;
	return data;
}

storeGoodsDoDeptDosFromJson(StoreGoodsDoDeptDos data, Map<String, dynamic> json) {
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
		data.customerDeptDetailDo = StoreGoodsDoDeptDosCustomerDeptDetailDo().fromJson(json['customerDeptDetailDo']);
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

Map<String, dynamic> storeGoodsDoDeptDosToJson(StoreGoodsDoDeptDos entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
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
	return data;
}

storeGoodsDoDeptDosCustomerDeptDetailDoFromJson(StoreGoodsDoDeptDosCustomerDeptDetailDo data, Map<String, dynamic> json) {
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
		data.enableTime = json['enableTime'] is String
				? int.tryParse(json['enableTime'])
				: json['enableTime'].toInt();
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

Map<String, dynamic> storeGoodsDoDeptDosCustomerDeptDetailDoToJson(StoreGoodsDoDeptDosCustomerDeptDetailDo entity) {
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
	return data;
}
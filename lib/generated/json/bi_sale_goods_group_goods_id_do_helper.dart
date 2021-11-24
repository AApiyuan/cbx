import 'package:haidai_flutter_module/page/bi/model/res/bi_sale_goods_group_goods_id_do.dart';

biSaleGoodsGroupGoodsIdDoFromJson(BiSaleGoodsGroupGoodsIdDo data, Map<String, dynamic> json) {
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['normalSaleGoodsNum'] != null) {
		data.normalSaleGoodsNum = json['normalSaleGoodsNum'] is String
				? int.tryParse(json['normalSaleGoodsNum'])
				: json['normalSaleGoodsNum'].toInt();
	}
	if (json['normalSaleAmount'] != null) {
		data.normalSaleAmount = json['normalSaleAmount'] is String
				? int.tryParse(json['normalSaleAmount'])
				: json['normalSaleAmount'].toInt();
	}
	if (json['normalSaleTaxAmount'] != null) {
		data.normalSaleTaxAmount = json['normalSaleTaxAmount'] is String
				? int.tryParse(json['normalSaleTaxAmount'])
				: json['normalSaleTaxAmount'].toInt();
	}
	if (json['returnGoodsNum'] != null) {
		data.returnGoodsNum = json['returnGoodsNum'] is String
				? int.tryParse(json['returnGoodsNum'])
				: json['returnGoodsNum'].toInt();
	}
	if (json['returnAmount'] != null) {
		data.returnAmount = json['returnAmount'] is String
				? int.tryParse(json['returnAmount'])
				: json['returnAmount'].toInt();
	}
	if (json['changeBackOrderGoodsNum'] != null) {
		data.changeBackOrderGoodsNum = json['changeBackOrderGoodsNum'] is String
				? int.tryParse(json['changeBackOrderGoodsNum'])
				: json['changeBackOrderGoodsNum'].toInt();
	}
	if (json['changeBackOrderAmount'] != null) {
		data.changeBackOrderAmount = json['changeBackOrderAmount'] is String
				? int.tryParse(json['changeBackOrderAmount'])
				: json['changeBackOrderAmount'].toInt();
	}
	if (json['saleGoodsNum'] != null) {
		data.saleGoodsNum = json['saleGoodsNum'] is String
				? int.tryParse(json['saleGoodsNum'])
				: json['saleGoodsNum'].toInt();
	}
	if (json['saleAmount'] != null) {
		data.saleAmount = json['saleAmount'] is String
				? int.tryParse(json['saleAmount'])
				: json['saleAmount'].toInt();
	}
	if (json['saleTaxAmount'] != null) {
		data.saleTaxAmount = json['saleTaxAmount'] is String
				? int.tryParse(json['saleTaxAmount'])
				: json['saleTaxAmount'].toInt();
	}
	if (json['deliveryNum'] != null) {
		data.deliveryNum = json['deliveryNum'] is String
				? int.tryParse(json['deliveryNum'])
				: json['deliveryNum'].toInt();
	}
	if (json['deliveryAmount'] != null) {
		data.deliveryAmount = json['deliveryAmount'] is String
				? int.tryParse(json['deliveryAmount'])
				: json['deliveryAmount'].toInt();
	}
	if (json['canceledNum'] != null) {
		data.canceledNum = json['canceledNum'] is String
				? int.tryParse(json['canceledNum'])
				: json['canceledNum'].toInt();
	}
	if (json['canceledAmount'] != null) {
		data.canceledAmount = json['canceledAmount'] is String
				? int.tryParse(json['canceledAmount'])
				: json['canceledAmount'].toInt();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['shortageAmount'] != null) {
		data.shortageAmount = json['shortageAmount'] is String
				? int.tryParse(json['shortageAmount'])
				: json['shortageAmount'].toInt();
	}
	if (json['onSaleTime'] != null) {
		data.onSaleTime = json['onSaleTime'] is String
				? int.tryParse(json['onSaleTime'])
				: json['onSaleTime'].toInt();
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
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['imgPath'] != null) {
		data.imgPath = json['imgPath'].toString();
	}
	if (json['goodsYear'] != null) {
		data.goodsYear = json['goodsYear'] is String
				? int.tryParse(json['goodsYear'])
				: json['goodsYear'].toInt();
	}
	if (json['goodsYearName'] != null) {
		data.goodsYearName = json['goodsYearName'].toString();
	}
	if (json['goodsBrand'] != null) {
		data.goodsBrand = json['goodsBrand'] is String
				? int.tryParse(json['goodsBrand'])
				: json['goodsBrand'].toInt();
	}
	if (json['goodsBrandName'] != null) {
		data.goodsBrandName = json['goodsBrandName'].toString();
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
	if (json['supplierId'] != null) {
		data.supplierId = json['supplierId'] is String
				? int.tryParse(json['supplierId'])
				: json['supplierId'].toInt();
	}
	if (json['supplierName'] != null) {
		data.supplierName = json['supplierName'].toString();
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
	if (json['model'] != null) {
		data.model = json['model'] is String
				? int.tryParse(json['model'])
				: json['model'].toInt();
	}
	if (json['modelName'] != null) {
		data.modelName = json['modelName'].toString();
	}
	if (json['plateType'] != null) {
		data.plateType = json['plateType'] is String
				? int.tryParse(json['plateType'])
				: json['plateType'].toInt();
	}
	if (json['plateTypeName'] != null) {
		data.plateTypeName = json['plateTypeName'].toString();
	}
	if (json['designNum'] != null) {
		data.designNum = json['designNum'] is String
				? int.tryParse(json['designNum'])
				: json['designNum'].toInt();
	}
	if (json['designNumName'] != null) {
		data.designNumName = json['designNumName'].toString();
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
	if (json['designSerial'] != null) {
		data.designSerial = json['designSerial'].toString();
	}
	if (json['supplierSerial'] != null) {
		data.supplierSerial = json['supplierSerial'].toString();
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
	if (json['goodsLevelTag'] != null) {
		data.goodsLevelTag = json['goodsLevelTag'] is String
				? int.tryParse(json['goodsLevelTag'])
				: json['goodsLevelTag'].toInt();
	}
	if (json['goodsLevelTagName'] != null) {
		data.goodsLevelTagName = json['goodsLevelTagName'].toString();
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
	if (json['fabric'] != null) {
		data.fabric = json['fabric'] is String
				? int.tryParse(json['fabric'])
				: json['fabric'].toInt();
	}
	if (json['fabricName'] != null) {
		data.fabricName = json['fabricName'].toString();
	}
	if (json['accessories'] != null) {
		data.accessories = json['accessories'] is String
				? int.tryParse(json['accessories'])
				: json['accessories'].toInt();
	}
	if (json['accessoriesName'] != null) {
		data.accessoriesName = json['accessoriesName'].toString();
	}
	return data;
}

Map<String, dynamic> biSaleGoodsGroupGoodsIdDoToJson(BiSaleGoodsGroupGoodsIdDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsId'] = entity.goodsId;
	data['normalSaleGoodsNum'] = entity.normalSaleGoodsNum;
	data['normalSaleAmount'] = entity.normalSaleAmount;
	data['normalSaleTaxAmount'] = entity.normalSaleTaxAmount;
	data['returnGoodsNum'] = entity.returnGoodsNum;
	data['returnAmount'] = entity.returnAmount;
	data['changeBackOrderGoodsNum'] = entity.changeBackOrderGoodsNum;
	data['changeBackOrderAmount'] = entity.changeBackOrderAmount;
	data['saleGoodsNum'] = entity.saleGoodsNum;
	data['saleAmount'] = entity.saleAmount;
	data['saleTaxAmount'] = entity.saleTaxAmount;
	data['deliveryNum'] = entity.deliveryNum;
	data['deliveryAmount'] = entity.deliveryAmount;
	data['canceledNum'] = entity.canceledNum;
	data['canceledAmount'] = entity.canceledAmount;
	data['shortageNum'] = entity.shortageNum;
	data['shortageAmount'] = entity.shortageAmount;
	data['onSaleTime'] = entity.onSaleTime;
	data['sailingPrice'] = entity.sailingPrice;
	data['takingPrice'] = entity.takingPrice;
	data['packagePrice'] = entity.packagePrice;
	data['costPrice'] = entity.costPrice;
	data['goodsSerial'] = entity.goodsSerial;
	data['goodsName'] = entity.goodsName;
	data['cover'] = entity.cover;
	data['imgPath'] = entity.imgPath;
	data['goodsYear'] = entity.goodsYear;
	data['goodsYearName'] = entity.goodsYearName;
	data['goodsBrand'] = entity.goodsBrand;
	data['goodsBrandName'] = entity.goodsBrandName;
	data['goodsSeason'] = entity.goodsSeason;
	data['goodsSeasonName'] = entity.goodsSeasonName;
	data['goodsLabel'] = entity.goodsLabel;
	data['goodsLabelName'] = entity.goodsLabelName;
	data['goodsClassify'] = entity.goodsClassify;
	data['goodsClassifyName'] = entity.goodsClassifyName;
	data['goodsClassifyMiddle'] = entity.goodsClassifyMiddle;
	data['goodsClassifyMiddleName'] = entity.goodsClassifyMiddleName;
	data['goodsClassifySmall'] = entity.goodsClassifySmall;
	data['goodsClassifySmallName'] = entity.goodsClassifySmallName;
	data['supplierId'] = entity.supplierId;
	data['supplierName'] = entity.supplierName;
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
	data['model'] = entity.model;
	data['modelName'] = entity.modelName;
	data['plateType'] = entity.plateType;
	data['plateTypeName'] = entity.plateTypeName;
	data['designNum'] = entity.designNum;
	data['designNumName'] = entity.designNumName;
	data['gender'] = entity.gender;
	data['genderName'] = entity.genderName;
	data['series'] = entity.series;
	data['seriesName'] = entity.seriesName;
	data['designSerial'] = entity.designSerial;
	data['supplierSerial'] = entity.supplierSerial;
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
	data['goodsLevelTag'] = entity.goodsLevelTag;
	data['goodsLevelTagName'] = entity.goodsLevelTagName;
	data['checkName'] = entity.checkName;
	data['checkUserName'] = entity.checkUserName;
	data['deliveryDate'] = entity.deliveryDate;
	data['deliveryDateName'] = entity.deliveryDateName;
	data['minimumOrderQuantity'] = entity.minimumOrderQuantity;
	data['minimumOrderQuantityName'] = entity.minimumOrderQuantityName;
	data['fabric'] = entity.fabric;
	data['fabricName'] = entity.fabricName;
	data['accessories'] = entity.accessories;
	data['accessoriesName'] = entity.accessoriesName;
	return data;
}
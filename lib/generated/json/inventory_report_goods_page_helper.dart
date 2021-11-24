import 'package:haidai_flutter_module/model/rep/inventory_report_goods_page.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';

inventoryReportGoodsPageFromJson(InventoryReportGoodsPage data, Map<String, dynamic> json) {
	if (json['orderInventoryId'] != null) {
		data.orderInventoryId = json['orderInventoryId'] is String
				? int.tryParse(json['orderInventoryId'])
				: json['orderInventoryId'].toInt();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['isInventory'] != null) {
		data.isInventory = json['isInventory'].toString();
	}
	if (json['goodsNameSerial'] != null) {
		data.goodsNameSerial = json['goodsNameSerial'].toString();
	}
	if (json['goodsClassify'] != null) {
		data.goodsClassify = json['goodsClassify'] is String
				? int.tryParse(json['goodsClassify'])
				: json['goodsClassify'].toInt();
	}
	if (json['goodsClassifies'] != null) {
		data.goodsClassifies = (json['goodsClassifies'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['goodsClassifyMiddle'] != null) {
		data.goodsClassifyMiddle = json['goodsClassifyMiddle'] is String
				? int.tryParse(json['goodsClassifyMiddle'])
				: json['goodsClassifyMiddle'].toInt();
	}
	if (json['goodsClassifyMiddles'] != null) {
		data.goodsClassifyMiddles = (json['goodsClassifyMiddles'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['goodsClassifySmall'] != null) {
		data.goodsClassifySmall = json['goodsClassifySmall'] is String
				? int.tryParse(json['goodsClassifySmall'])
				: json['goodsClassifySmall'].toInt();
	}
	if (json['goodsClassifySmalls'] != null) {
		data.goodsClassifySmalls = (json['goodsClassifySmalls'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['goodsBrand'] != null) {
		data.goodsBrand = json['goodsBrand'] is String
				? int.tryParse(json['goodsBrand'])
				: json['goodsBrand'].toInt();
	}
	if (json['goodsBrands'] != null) {
		data.goodsBrands = (json['goodsBrands'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['goodsYear'] != null) {
		data.goodsYear = json['goodsYear'] is String
				? int.tryParse(json['goodsYear'])
				: json['goodsYear'].toInt();
	}
	if (json['goodsYears'] != null) {
		data.goodsYears = (json['goodsYears'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['goodsSeason'] != null) {
		data.goodsSeason = json['goodsSeason'] is String
				? int.tryParse(json['goodsSeason'])
				: json['goodsSeason'].toInt();
	}
	if (json['goodsSeasons'] != null) {
		data.goodsSeasons = (json['goodsSeasons'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['goodsLabel'] != null) {
		data.goodsLabel = json['goodsLabel'] is String
				? int.tryParse(json['goodsLabel'])
				: json['goodsLabel'].toInt();
	}
	if (json['goodsLabels'] != null) {
		data.goodsLabels = (json['goodsLabels'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['orderBy'] != null) {
		data.orderBy = OrderBy().fromJson(json['orderBy']);
	}
	return data;
}

Map<String, dynamic> inventoryReportGoodsPageToJson(InventoryReportGoodsPage entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderInventoryId'] = entity.orderInventoryId;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['isInventory'] = entity.isInventory;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['goodsClassify'] = entity.goodsClassify;
	data['goodsClassifies'] = entity.goodsClassifies;
	data['goodsClassifyMiddle'] = entity.goodsClassifyMiddle;
	data['goodsClassifyMiddles'] = entity.goodsClassifyMiddles;
	data['goodsClassifySmall'] = entity.goodsClassifySmall;
	data['goodsClassifySmalls'] = entity.goodsClassifySmalls;
	data['goodsBrand'] = entity.goodsBrand;
	data['goodsBrands'] = entity.goodsBrands;
	data['goodsYear'] = entity.goodsYear;
	data['goodsYears'] = entity.goodsYears;
	data['goodsSeason'] = entity.goodsSeason;
	data['goodsSeasons'] = entity.goodsSeasons;
	data['goodsLabel'] = entity.goodsLabel;
	data['goodsLabels'] = entity.goodsLabels;
	data['orderBy'] = entity.orderBy?.toJson();
	return data;
}
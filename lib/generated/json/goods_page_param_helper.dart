import 'package:haidai_flutter_module/model/rep/goods_page_param.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';

goodsPageParamFromJson(GoodsPageParam data, Map<String, dynamic> json) {
	if (json['selectType'] != null) {
		data.selectType = json['selectType'];
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['isBasePrice'] != null) {
		data.isBasePrice = json['isBasePrice'];
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['goodsIds'] != null) {
		data.goodsIds = (json['goodsIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['goodsNameSerial'] != null) {
		data.goodsNameSerial = json['goodsNameSerial'].toString();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['onSaleStartTime'] != null) {
		data.onSaleStartTime = json['onSaleStartTime'].toString();
	}
	if (json['onSaleEndTime'] != null) {
		data.onSaleEndTime = json['onSaleEndTime'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['inventoryId'] != null) {
		data.inventoryId = json['inventoryId'] is String
				? int.tryParse(json['inventoryId'])
				: json['inventoryId'].toInt();
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
	if (json['supplierId'] != null) {
		data.supplierId = json['supplierId'] is String
				? int.tryParse(json['supplierId'])
				: json['supplierId'].toInt();
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
	if (json['returnCustomerDeliveryNum'] != null) {
		data.returnCustomerDeliveryNum = json['returnCustomerDeliveryNum'];
	}
	if (json['orderBy'] != null) {
		data.orderBy = OrderBy().fromJson(json['orderBy']);
	}
	return data;
}

Map<String, dynamic> goodsPageParamToJson(GoodsPageParam entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['selectType'] = entity.selectType;
	data['deptId'] = entity.deptId;
	data['isBasePrice'] = entity.isBasePrice;
	data['customerId'] = entity.customerId;
	data['goodsSerial'] = entity.goodsSerial;
	data['goodsName'] = entity.goodsName;
	data['goodsIds'] = entity.goodsIds;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['onSaleStartTime'] = entity.onSaleStartTime;
	data['onSaleEndTime'] = entity.onSaleEndTime;
	data['status'] = entity.status;
	data['inventoryId'] = entity.inventoryId;
	data['goodsClassify'] = entity.goodsClassify;
	data['goodsClassifies'] = entity.goodsClassifies;
	data['goodsClassifyMiddle'] = entity.goodsClassifyMiddle;
	data['goodsClassifyMiddles'] = entity.goodsClassifyMiddles;
	data['goodsClassifySmall'] = entity.goodsClassifySmall;
	data['goodsClassifySmalls'] = entity.goodsClassifySmalls;
	data['supplierId'] = entity.supplierId;
	data['goodsBrand'] = entity.goodsBrand;
	data['goodsBrands'] = entity.goodsBrands;
	data['goodsYear'] = entity.goodsYear;
	data['goodsYears'] = entity.goodsYears;
	data['goodsSeason'] = entity.goodsSeason;
	data['goodsSeasons'] = entity.goodsSeasons;
	data['goodsLabel'] = entity.goodsLabel;
	data['goodsLabels'] = entity.goodsLabels;
	data['returnCustomerDeliveryNum'] = entity.returnCustomerDeliveryNum;
	data['orderBy'] = entity.orderBy?.toJson();
	return data;
}
import 'package:haidai_flutter_module/page/sale_detail/models/req/sale_update_req_entity.dart';

saleUpdateReqEntityFromJson(SaleUpdateReqEntity data, Map<String, dynamic> json) {
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['merchandiserId'] != null) {
		data.merchandiserId = json['merchandiserId'] is String
				? int.tryParse(json['merchandiserId'])
				: json['merchandiserId'].toInt();
	}
	if (json['wipeOffAmount'] != null) {
		data.wipeOffAmount = json['wipeOffAmount'] is String
				? int.tryParse(json['wipeOffAmount'])
				: json['wipeOffAmount'].toInt();
	}
	if (json['configDistribution'] != null) {
		data.configDistribution = json['configDistribution'].toString();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['distributorId'] != null) {
		data.distributorId = json['distributorId'] is String
				? int.tryParse(json['distributorId'])
				: json['distributorId'].toInt();
	}
	return data;
}

Map<String, dynamic> saleUpdateReqEntityToJson(SaleUpdateReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderSaleId'] = entity.orderSaleId;
	data['merchandiserId'] = entity.merchandiserId;
	data['wipeOffAmount'] = entity.wipeOffAmount;
	data['configDistribution'] = entity.configDistribution;
	data['warehouseId'] = entity.warehouseId;
	data['distributorId'] = entity.distributorId;
	return data;
}
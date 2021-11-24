import 'package:haidai_flutter_module/page/direct_deliver/model/req/sale_create_delivery_req_entity.dart';

saleCreateDeliveryReqEntityFromJson(SaleCreateDeliveryReqEntity data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	return data;
}

Map<String, dynamic> saleCreateDeliveryReqEntityToJson(SaleCreateDeliveryReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['customerId'] = entity.customerId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	return data;
}
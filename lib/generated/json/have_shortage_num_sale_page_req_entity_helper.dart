import 'package:haidai_flutter_module/page/goods/model/req/have_shortage_num_sale_page_req_entity.dart';

haveShortageNumSalePageReqEntityFromJson(HaveShortageNumSalePageReqEntity data, Map<String, dynamic> json) {
	if (json['customerDeptId'] != null) {
		data.customerDeptId = json['customerDeptId'] is String
				? int.tryParse(json['customerDeptId'])
				: json['customerDeptId'].toInt();
	}
	if (json['goodsNameSerial'] != null) {
		data.goodsNameSerial = json['goodsNameSerial'].toString();
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

Map<String, dynamic> haveShortageNumSalePageReqEntityToJson(HaveShortageNumSalePageReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerDeptId'] = entity.customerDeptId;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['customerId'] = entity.customerId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	return data;
}
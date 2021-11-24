import 'package:haidai_flutter_module/page/sale/model/req/batch_customer_buy_price_req_entity.dart';

batchCustomerBuyPriceReqEntityFromJson(BatchCustomerBuyPriceReqEntity data, Map<String, dynamic> json) {
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['goodsIds'] != null) {
		data.goodsIds = (json['goodsIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	return data;
}

Map<String, dynamic> batchCustomerBuyPriceReqEntityToJson(BatchCustomerBuyPriceReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerId'] = entity.customerId;
	data['deptId'] = entity.deptId;
	data['goodsIds'] = entity.goodsIds;
	return data;
}
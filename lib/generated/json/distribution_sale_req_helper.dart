import 'package:haidai_flutter_module/page/transfer/model/req/distribution_sale_req.dart';

distributionSaleReqFromJson(DistributionSaleReq data, Map<String, dynamic> json) {
	if (json['customerDeptId'] != null) {
		data.customerDeptId = json['customerDeptId'] is String
				? int.tryParse(json['customerDeptId'])
				: json['customerDeptId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderTransferId'] != null) {
		data.orderTransferId = json['orderTransferId'] is String
				? int.tryParse(json['orderTransferId'])
				: json['orderTransferId'].toInt();
	}
	return data;
}

Map<String, dynamic> distributionSaleReqToJson(DistributionSaleReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerDeptId'] = entity.customerDeptId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderTransferId'] = entity.orderTransferId;
	return data;
}
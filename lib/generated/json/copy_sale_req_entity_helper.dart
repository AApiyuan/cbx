import 'package:haidai_flutter_module/page/sale_detail/models/req/copy_sale_req_entity.dart';

copySaleReqEntityFromJson(CopySaleReqEntity data, Map<String, dynamic> json) {
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	return data;
}

Map<String, dynamic> copySaleReqEntityToJson(CopySaleReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderSaleId'] = entity.orderSaleId;
	data['deptId'] = entity.deptId;
	return data;
}
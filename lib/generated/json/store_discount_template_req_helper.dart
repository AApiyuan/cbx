import 'package:haidai_flutter_module/model/store/req/store_discount_template_req.dart';

storeDiscountTemplateReqFromJson(StoreDiscountTemplateReq data, Map<String, dynamic> json) {
	if (json['customerDeptId'] != null) {
		data.customerDeptId = json['customerDeptId'] is String
				? int.tryParse(json['customerDeptId'])
				: json['customerDeptId'].toInt();
	}
	if (json['style'] != null) {
		data.style = json['style'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	return data;
}

Map<String, dynamic> storeDiscountTemplateReqToJson(StoreDiscountTemplateReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerDeptId'] = entity.customerDeptId;
	data['style'] = entity.style;
	data['status'] = entity.status;
	return data;
}
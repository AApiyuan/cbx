import 'package:haidai_flutter_module/page/customer/model/rep/customer_risk_article_page_req_entity.dart';

customerRiskArticlePageReqEntityFromJson(CustomerRiskArticlePageReqEntity data, Map<String, dynamic> json) {
	if (json['customerDeptId'] != null) {
		data.customerDeptId = json['customerDeptId'] is String
				? int.tryParse(json['customerDeptId'])
				: json['customerDeptId'].toInt();
	}
	if (json['customerPhone'] != null) {
		data.customerPhone = json['customerPhone'].toString();
	}
	return data;
}

Map<String, dynamic> customerRiskArticlePageReqEntityToJson(CustomerRiskArticlePageReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerDeptId'] = entity.customerDeptId;
	data['customerPhone'] = entity.customerPhone;
	return data;
}
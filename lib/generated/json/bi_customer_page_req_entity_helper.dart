import 'package:haidai_flutter_module/page/bi/model/req/bi_customer_page_req_entity.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';

biCustomerPageReqEntityFromJson(BiCustomerPageReqEntity data, Map<String, dynamic> json) {
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['customerDeptIds'] != null) {
		data.customerDeptIds = (json['customerDeptIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['orderBy'] != null) {
		data.orderBy = OrderBy().fromJson(json['orderBy']);
	}
	if (json['filterMerchandiser'] != null) {
		data.filterMerchandiser = json['filterMerchandiser'];
	}
	return data;
}

Map<String, dynamic> biCustomerPageReqEntityToJson(BiCustomerPageReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['topDeptId'] = entity.topDeptId;
	data['customerDeptIds'] = entity.customerDeptIds;
	data['orderBy'] = entity.orderBy?.toJson();
	data['filterMerchandiser'] = entity.filterMerchandiser;
	return data;
}
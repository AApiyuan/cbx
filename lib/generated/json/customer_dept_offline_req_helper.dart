import 'package:haidai_flutter_module/model/rep/customer_dept_offline_req.dart';

customerDeptOfflineReqFromJson(CustomerDeptOfflineReq data, Map<String, dynamic> json) {
	if (json['customerDeptId'] != null) {
		data.customerDeptId = json['customerDeptId'] is String
				? int.tryParse(json['customerDeptId'])
				: json['customerDeptId'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	return data;
}

Map<String, dynamic> customerDeptOfflineReqToJson(CustomerDeptOfflineReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerDeptId'] = entity.customerDeptId;
	data['type'] = entity.type;
	return data;
}
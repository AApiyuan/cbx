import 'package:haidai_flutter_module/model/store/req/customer_dept_config_req.dart';

customerDeptConfigReqFromJson(CustomerDeptConfigReq data, Map<String, dynamic> json) {
	if (json['customerDeptId'] != null) {
		data.customerDeptId = json['customerDeptId'] is String
				? int.tryParse(json['customerDeptId'])
				: json['customerDeptId'].toInt();
	}
	if (json['groupTypeList'] != null) {
		data.groupTypeList = (json['groupTypeList'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['typeList'] != null) {
		data.typeList = (json['typeList'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	return data;
}

Map<String, dynamic> customerDeptConfigReqToJson(CustomerDeptConfigReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerDeptId'] = entity.customerDeptId;
	data['groupTypeList'] = entity.groupTypeList;
	data['typeList'] = entity.typeList;
	return data;
}
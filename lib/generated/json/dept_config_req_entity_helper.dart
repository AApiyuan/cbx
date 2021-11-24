import 'package:haidai_flutter_module/model/dept_config_req_entity.dart';

deptConfigReqEntityFromJson(DeptConfigReqEntity data, Map<String, dynamic> json) {
	if (json['customerDeptId'] != null) {
		data.customerDeptId = json['customerDeptId'] is String
				? int.tryParse(json['customerDeptId'])
				: json['customerDeptId'].toInt();
	}
	if (json['groupTypeList'] != null) {
		data.groupTypeList = (json['groupTypeList'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	return data;
}

Map<String, dynamic> deptConfigReqEntityToJson(DeptConfigReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerDeptId'] = entity.customerDeptId;
	data['groupTypeList'] = entity.groupTypeList;
	return data;
}
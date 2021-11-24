import 'package:haidai_flutter_module/model/store/res/customer_dept_config_do.dart';

customerDeptConfigDoFromJson(CustomerDeptConfigDo data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['groupType'] != null) {
		data.groupType = json['groupType'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['configDateType'] != null) {
		data.configDateType = json['configDateType'].toString();
	}
	if (json['configDate'] != null) {
		data.configDate = json['configDate'];
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	return data;
}

Map<String, dynamic> customerDeptConfigDoToJson(CustomerDeptConfigDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['groupType'] = entity.groupType;
	data['type'] = entity.type;
	data['configDateType'] = entity.configDateType;
	data['configDate'] = entity.configDate;
	data['id'] = entity.id;
	return data;
}
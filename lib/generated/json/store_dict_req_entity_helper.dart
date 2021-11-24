import 'package:haidai_flutter_module/page/direct_deliver/model/req/store_dict_req_entity.dart';

storeDictReqEntityFromJson(StoreDictReqEntity data, Map<String, dynamic> json) {
	if (json['customerDeptId'] != null) {
		data.customerDeptId = json['customerDeptId'] is String
				? int.tryParse(json['customerDeptId'])
				: json['customerDeptId'].toInt();
	}
	if (json['dictType'] != null) {
		data.dictType = json['dictType'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['parentId'] != null) {
		data.parentId = json['parentId'] is String
				? int.tryParse(json['parentId'])
				: json['parentId'].toInt();
	}
	return data;
}

Map<String, dynamic> storeDictReqEntityToJson(StoreDictReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerDeptId'] = entity.customerDeptId;
	data['dictType'] = entity.dictType;
	data['status'] = entity.status;
	data['parentId'] = entity.parentId;
	return data;
}
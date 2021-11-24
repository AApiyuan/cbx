import 'package:haidai_flutter_module/model/rep/dept_and_relation_req_entity.dart';

deptAndRelationReqEntityFromJson(DeptAndRelationReqEntity data, Map<String, dynamic> json) {
	if (json['deptTypes'] != null) {
		data.deptTypes = (json['deptTypes'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['returnRelation'] != null) {
		data.returnRelation = json['returnRelation'];
	}
	if (json['returnRoleName'] != null) {
		data.returnRoleName = json['returnRoleName'];
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	return data;
}

Map<String, dynamic> deptAndRelationReqEntityToJson(DeptAndRelationReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptTypes'] = entity.deptTypes;
	data['returnRelation'] = entity.returnRelation;
	data['returnRoleName'] = entity.returnRoleName;
	data['status'] = entity.status;
	return data;
}
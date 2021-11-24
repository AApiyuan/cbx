import 'package:haidai_flutter_module/model/store/req/dept_and_relation_req.dart';

deptAndRelationReqFromJson(DeptAndRelationReq data, Map<String, dynamic> json) {
	if (json['returnRelation'] != null) {
		data.returnRelation = json['returnRelation'];
	}
	if (json['returnRoleName'] != null) {
		data.returnRoleName = json['returnRoleName'];
	}
	if (json['deptTypes'] != null) {
		data.deptTypes = (json['deptTypes'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	return data;
}

Map<String, dynamic> deptAndRelationReqToJson(DeptAndRelationReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['returnRelation'] = entity.returnRelation;
	data['returnRoleName'] = entity.returnRoleName;
	data['deptTypes'] = entity.deptTypes;
	data['status'] = entity.status;
	return data;
}
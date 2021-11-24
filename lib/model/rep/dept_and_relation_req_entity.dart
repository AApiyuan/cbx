import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class DeptAndRelationReqEntity with JsonConvert<DeptAndRelationReqEntity> {
	List<String>? deptTypes;
	bool? returnRelation;
	bool? returnRoleName;
	String? status;
}

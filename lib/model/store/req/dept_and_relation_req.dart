import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class DeptAndRelationReq with JsonConvert<DeptAndRelationReq> {
	bool? returnRelation;
	bool? returnRoleName;
	List<String>? deptTypes;
	String? status;
}

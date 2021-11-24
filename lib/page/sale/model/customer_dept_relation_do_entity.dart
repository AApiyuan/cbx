import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class CustomerDeptRelationDoEntity with JsonConvert<CustomerDeptRelationDoEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	int? deptId;
	int? relationDeptId;
	bool? selfUse;
	String? deptType;
	String? status;
	String? name;
}

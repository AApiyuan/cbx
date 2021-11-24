import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class CustomerDeptRelationDo with JsonConvert<CustomerDeptRelationDo> {
	int? deptId;
	int? relationDeptId;
	bool? selfUse;
	String? deptType;
	String? status;
	String? name;
	String? logo;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
	bool selected = false;
}

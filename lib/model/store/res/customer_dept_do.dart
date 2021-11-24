import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class CustomerDeptDo with JsonConvert<CustomerDeptDo> {
	int? bossId;
	int? parentDeptId;
	String? path;
	dynamic? deptType;
	dynamic? status;
	String? name;
	int? paidStaffNum;
	int? customerNum;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

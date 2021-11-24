import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class CustomerDeptUserDetailDo with JsonConvert<CustomerDeptUserDetailDo> {
	CustomerDeptUserDetailDoCustomerUserDo? customerUserDo;
	List<CustomerDeptUserDetailDoCustomerDeptUserDoList>? customerDeptUserDoList;
	int? userId;
	int? deptId;
	int? topDeptId;
	dynamic? status;
	int? entryTime;
	int? roleId;
	String? jobNumber;
	int? factoryDeptId;
	String? remark;
	String? roleName;
	String? deptName;
	String? factoryDeptName;
	String? userName;
	int? id;
	int? createdTime;
	int? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class CustomerDeptUserDetailDoCustomerUserDo with JsonConvert<CustomerDeptUserDetailDoCustomerUserDo> {
	String? name;
	String? avatar;
	String? bindPhone;
	String? wx;
	int? customerUserId;
	int? entryTime;
	String? noSelectedDepts;
	int? id;
	int? createdTime;
	int? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class CustomerDeptUserDetailDoCustomerDeptUserDoList with JsonConvert<CustomerDeptUserDetailDoCustomerDeptUserDoList> {
	int? userId;
	int? deptId;
	int? topDeptId;
	dynamic? status;
	int? entryTime;
	int? roleId;
	String? jobNumber;
	int? factoryDeptId;
	String? remark;
	String? roleName;
	String? deptName;
	String? factoryDeptName;
	String? userName;
	int? id;
	int? createdTime;
	int? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

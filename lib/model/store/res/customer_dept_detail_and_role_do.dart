import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class CustomerDeptDetailAndRoleDo with JsonConvert<CustomerDeptDetailAndRoleDo> {
	List<CustomerDeptDetailAndRoleDoCustomerDeptRelationDos>? customerDeptRelationDos;
	List<CustomerDeptDetailAndRoleDoCustomerDeptFunctionalVersionDoList>? customerDeptFunctionalVersionDoList;
	String? roleName;
	int? bossId;
	int? parentDeptId;
	String? path;
	dynamic? deptType;
	dynamic? status;
	String? name;
	int? customerNum;
	CustomerDeptDetailAndRoleDoCustomerDeptDetailDo? customerDeptDetailDo;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;

	bool selected =false;//外部加入

}

class CustomerDeptDetailAndRoleDoCustomerDeptRelationDos with JsonConvert<CustomerDeptDetailAndRoleDoCustomerDeptRelationDos> {
	int? deptId;
	int? relationDeptId;
	bool? selfUse;
	dynamic? deptType;
	dynamic? status;
	String? name;
	String? logo;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class CustomerDeptDetailAndRoleDoCustomerDeptFunctionalVersionDoList with JsonConvert<CustomerDeptDetailAndRoleDoCustomerDeptFunctionalVersionDoList> {
	int? deptId;
	dynamic? type;
	String? beginEffectiveTime;
	String? endEffectiveTime;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class CustomerDeptDetailAndRoleDoCustomerDeptDetailDo with JsonConvert<CustomerDeptDetailAndRoleDoCustomerDeptDetailDo> {
	String? phone;
	int? marketId;
	String? province;
	String? provinceCode;
	String? city;
	String? cityCode;
	String? district;
	String? districtCode;
	String? address;
	int? deptId;
	String? logo;
	String? photoAlbumHeader;
	String? wx;
	String? enableTime;
	int? longtitude;
	int? latitude;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
	String? firstActivatedTime;
	String? baseExpiryDate;
	String? offlineExpiryDate;
	String? appBiExpiryDate;
	String? substandardStockExpiryDate;
	String? transferExpiryDate;
	String? dataBackgroundExpiryDate;
	String? customerQuotationExpiryDate;
}

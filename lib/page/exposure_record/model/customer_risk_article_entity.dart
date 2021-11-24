import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class CustomerRiskArticleEntity with JsonConvert<CustomerRiskArticleEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	int? deptId;
	int? topDeptId;
	int? marketId;
	String? customerPhone;
	String? logo;
	String? content;
	String? imgPath;
	String? contentImgs;
	String? showDept;
	String? deptName;
	String? marketName;
	bool? publishedMyCompany;
}

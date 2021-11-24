import 'package:haidai_flutter_module/page/exposure_record/model/customer_risk_article_entity.dart';

customerRiskArticleEntityFromJson(CustomerRiskArticleEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? int.tryParse(json['updatedBy'])
				: json['updatedBy'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['marketId'] != null) {
		data.marketId = json['marketId'] is String
				? int.tryParse(json['marketId'])
				: json['marketId'].toInt();
	}
	if (json['customerPhone'] != null) {
		data.customerPhone = json['customerPhone'].toString();
	}
	if (json['logo'] != null) {
		data.logo = json['logo'].toString();
	}
	if (json['content'] != null) {
		data.content = json['content'].toString();
	}
	if (json['imgPath'] != null) {
		data.imgPath = json['imgPath'].toString();
	}
	if (json['contentImgs'] != null) {
		data.contentImgs = json['contentImgs'].toString();
	}
	if (json['showDept'] != null) {
		data.showDept = json['showDept'].toString();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['marketName'] != null) {
		data.marketName = json['marketName'].toString();
	}
	if (json['publishedMyCompany'] != null) {
		data.publishedMyCompany = json['publishedMyCompany'];
	}
	return data;
}

Map<String, dynamic> customerRiskArticleEntityToJson(CustomerRiskArticleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['marketId'] = entity.marketId;
	data['customerPhone'] = entity.customerPhone;
	data['logo'] = entity.logo;
	data['content'] = entity.content;
	data['imgPath'] = entity.imgPath;
	data['contentImgs'] = entity.contentImgs;
	data['showDept'] = entity.showDept;
	data['deptName'] = entity.deptName;
	data['marketName'] = entity.marketName;
	data['publishedMyCompany'] = entity.publishedMyCompany;
	return data;
}
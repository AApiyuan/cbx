import 'package:haidai_flutter_module/model/store/res/store_discount_template_do.dart';

storeDiscountTemplateDoFromJson(StoreDiscountTemplateDo data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['style'] != null) {
		data.style = json['style'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['enableNum'] != null) {
		data.enableNum = json['enableNum'] is String
				? int.tryParse(json['enableNum'])
				: json['enableNum'].toInt();
	}
	if (json['totalPrice'] != null) {
		data.totalPrice = json['totalPrice'] is String
				? int.tryParse(json['totalPrice'])
				: json['totalPrice'].toInt();
	}
	if (json['discountPrice'] != null) {
		data.discountPrice = json['discountPrice'] is String
				? int.tryParse(json['discountPrice'])
				: json['discountPrice'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	return data;
}

Map<String, dynamic> storeDiscountTemplateDoToJson(StoreDiscountTemplateDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['style'] = entity.style;
	data['status'] = entity.status;
	data['enableNum'] = entity.enableNum;
	data['totalPrice'] = entity.totalPrice;
	data['discountPrice'] = entity.discountPrice;
	data['topDeptId'] = entity.topDeptId;
	data['id'] = entity.id;
	return data;
}
import 'package:haidai_flutter_module/page/sale/model/discount_template_detail_entity.dart';

discountTemplateDetailEntityFromJson(DiscountTemplateDetailEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['style'] != null) {
		data.style = json['style'].toString();
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
	return data;
}

Map<String, dynamic> discountTemplateDetailEntityToJson(DiscountTemplateDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['style'] = entity.style;
	data['enableNum'] = entity.enableNum;
	data['totalPrice'] = entity.totalPrice;
	data['discountPrice'] = entity.discountPrice;
	return data;
}
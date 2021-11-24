import 'package:haidai_flutter_module/model/rep/base_page.dart';

basePageFromJson(BasePage data, Map<String, dynamic> json) {
	if (json['pageSize'] != null) {
		data.pageSize = json['pageSize'] is String
				? int.tryParse(json['pageSize'])
				: json['pageSize'].toInt();
	}
	if (json['param'] != null) {
		data.param = json['param'];
	}
	if (json['pageNo'] != null) {
		data.pageNo = json['pageNo'] is String
				? int.tryParse(json['pageNo'])
				: json['pageNo'].toInt();
	}
	return data;
}

Map<String, dynamic> basePageToJson(BasePage entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['pageSize'] = entity.pageSize;
	data['param'] = entity.param;
	data['pageNo'] = entity.pageNo;
	return data;
}
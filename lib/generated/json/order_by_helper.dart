import 'package:haidai_flutter_module/model/rep/order_by.dart';

orderByFromJson(OrderBy data, Map<String, dynamic> json) {
	if (json['field'] != null) {
		data.field = json['field'].toString();
	}
	if (json['by'] != null) {
		data.by = json['by'];
	}
	return data;
}

Map<String, dynamic> orderByToJson(OrderBy entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['field'] = entity.field;
	data['by'] = entity.by;
	return data;
}
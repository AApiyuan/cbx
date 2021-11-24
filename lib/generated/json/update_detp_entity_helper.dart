import 'package:haidai_flutter_module/model/update_detp_entity.dart';

updateDetpEntityFromJson(UpdateDetpEntity data, Map<String, dynamic> json) {
	if (json['depId'] != null) {
		data.depId = json['depId'] is String
				? int.tryParse(json['depId'])
				: json['depId'].toInt();
	}
	if (json['token'] != null) {
		data.token = json['token'].toString();
	}
	return data;
}

Map<String, dynamic> updateDetpEntityToJson(UpdateDetpEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['depId'] = entity.depId;
	data['token'] = entity.token;
	return data;
}
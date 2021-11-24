import 'package:haidai_flutter_module/model/download_dept_entity.dart';

downloadDeptEntityFromJson(DownloadDeptEntity data, Map<String, dynamic> json) {
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
	}
	if (json['token'] != null) {
		data.token = json['token'].toString();
	}
	return data;
}

Map<String, dynamic> downloadDeptEntityToJson(DownloadDeptEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['userId'] = entity.userId;
	data['token'] = entity.token;
	return data;
}
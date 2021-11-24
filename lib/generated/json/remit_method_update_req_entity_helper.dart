import 'package:haidai_flutter_module/page/gathering_detail/model/req/remit_method_update_req_entity.dart';

remitMethodUpdateReqEntityFromJson(RemitMethodUpdateReqEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['remitMethodId'] != null) {
		data.remitMethodId = json['remitMethodId'] is String
				? int.tryParse(json['remitMethodId'])
				: json['remitMethodId'].toInt();
	}
	return data;
}

Map<String, dynamic> remitMethodUpdateReqEntityToJson(RemitMethodUpdateReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['remitMethodId'] = entity.remitMethodId;
	return data;
}
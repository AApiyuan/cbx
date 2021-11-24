import 'package:haidai_flutter_module/page/gathering_detail/model/req/update_remit_base_req_entity.dart';

updateRemitBaseReqEntityFromJson(UpdateRemitBaseReqEntity data, Map<String, dynamic> json) {
	if (json['orderRemitId'] != null) {
		data.orderRemitId = json['orderRemitId'] is String
				? int.tryParse(json['orderRemitId'])
				: json['orderRemitId'].toInt();
	}
	if (json['merchandiserId'] != null) {
		data.merchandiserId = json['merchandiserId'] is String
				? int.tryParse(json['merchandiserId'])
				: json['merchandiserId'].toInt();
	}
	return data;
}

Map<String, dynamic> updateRemitBaseReqEntityToJson(UpdateRemitBaseReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderRemitId'] = entity.orderRemitId;
	data['merchandiserId'] = entity.merchandiserId;
	return data;
}
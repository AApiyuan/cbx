import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_group_time_do.dart';

biRemitGroupTimeDoFromJson(BiRemitGroupTimeDo data, Map<String, dynamic> json) {
	if (json['timeTitle'] != null) {
		data.timeTitle = json['timeTitle'].toString();
	}
	if (json['timeTitleShorthand'] != null) {
		data.timeTitleShorthand = json['timeTitleShorthand'].toString();
	}
	if (json['receivedAmount'] != null) {
		data.receivedAmount = json['receivedAmount'] is String
				? double.tryParse(json['receivedAmount'])
				: json['receivedAmount'].toDouble();
	}
	if (json['refundAmount'] != null) {
		data.refundAmount = json['refundAmount'] is String
				? double.tryParse(json['refundAmount'])
				: json['refundAmount'].toDouble();
	}
	return data;
}

Map<String, dynamic> biRemitGroupTimeDoToJson(BiRemitGroupTimeDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['timeTitle'] = entity.timeTitle;
	data['timeTitleShorthand'] = entity.timeTitleShorthand;
	data['receivedAmount'] = entity.receivedAmount;
	data['refundAmount'] = entity.refundAmount;
	return data;
}
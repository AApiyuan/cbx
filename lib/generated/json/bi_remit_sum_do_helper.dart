import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_sum_do.dart';

biRemitSumDoFromJson(BiRemitSumDo data, Map<String, dynamic> json) {
	if (json['receivedAmount'] != null) {
		data.receivedAmount = json['receivedAmount'] is String
				? int.tryParse(json['receivedAmount'])
				: json['receivedAmount'].toInt();
	}
	if (json['refundAmount'] != null) {
		data.refundAmount = json['refundAmount'] is String
				? int.tryParse(json['refundAmount'])
				: json['refundAmount'].toInt();
	}
	return data;
}

Map<String, dynamic> biRemitSumDoToJson(BiRemitSumDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['receivedAmount'] = entity.receivedAmount;
	data['refundAmount'] = entity.refundAmount;
	return data;
}
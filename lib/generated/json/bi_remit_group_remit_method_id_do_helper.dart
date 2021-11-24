import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_group_remit_method_id_do.dart';

biRemitGroupRemitMethodIdDoFromJson(BiRemitGroupRemitMethodIdDo data, Map<String, dynamic> json) {
	if (json['remitMethodId'] != null) {
		data.remitMethodId = json['remitMethodId'] is String
				? int.tryParse(json['remitMethodId'])
				: json['remitMethodId'].toInt();
	}
	if (json['remitMethodName'] != null) {
		data.remitMethodName = json['remitMethodName'].toString();
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
	if (json['totalAmount'] != null) {
		data.totalAmount = json['totalAmount'] is String
				? double.tryParse(json['totalAmount'])
				: json['totalAmount'].toDouble();
	}
	return data;
}

Map<String, dynamic> biRemitGroupRemitMethodIdDoToJson(BiRemitGroupRemitMethodIdDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['remitMethodId'] = entity.remitMethodId;
	data['remitMethodName'] = entity.remitMethodName;
	data['receivedAmount'] = entity.receivedAmount;
	data['refundAmount'] = entity.refundAmount;
	data['totalAmount'] = entity.totalAmount;
	return data;
}
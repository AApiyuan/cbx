import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_total_do.dart';

biCustomerTotalDoFromJson(BiCustomerTotalDo data, Map<String, dynamic> json) {
	if (json['balance'] != null) {
		data.balance = json['balance'] is String
				? int.tryParse(json['balance'])
				: json['balance'].toInt();
	}
	if (json['orderOweAmount'] != null) {
		data.orderOweAmount = json['orderOweAmount'] is String
				? int.tryParse(json['orderOweAmount'])
				: json['orderOweAmount'].toInt();
	}
	if (json['oweAmount'] != null) {
		data.oweAmount = json['oweAmount'] is String
				? int.tryParse(json['oweAmount'])
				: json['oweAmount'].toInt();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['customerNum'] != null) {
		data.customerNum = json['customerNum'] is String
				? int.tryParse(json['customerNum'])
				: json['customerNum'].toInt();
	}
	if (json['shortageAmount'] != null) {
		data.shortageAmount = json['shortageAmount'] is String
				? int.tryParse(json['shortageAmount'])
				: json['shortageAmount'].toInt();
	}
	return data;
}

Map<String, dynamic> biCustomerTotalDoToJson(BiCustomerTotalDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['balance'] = entity.balance;
	data['orderOweAmount'] = entity.orderOweAmount;
	data['oweAmount'] = entity.oweAmount;
	data['shortageNum'] = entity.shortageNum;
	data['customerNum'] = entity.customerNum;
	data['shortageAmount'] = entity.shortageAmount;
	return data;
}
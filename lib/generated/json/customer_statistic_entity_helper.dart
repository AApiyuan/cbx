import 'package:haidai_flutter_module/page/verification/model/customer_statistic_entity.dart';

customerStatisticEntityFromJson(CustomerStatisticEntity data, Map<String, dynamic> json) {
	if (json['expense'] != null) {
		data.expense = json['expense'] is String
				? int.tryParse(json['expense'])
				: json['expense'].toInt();
	}
	if (json['remitAmount'] != null) {
		data.remitAmount = json['remitAmount'] is String
				? int.tryParse(json['remitAmount'])
				: json['remitAmount'].toInt();
	}
	if (json['tradeAmount'] != null) {
		data.tradeAmount = json['tradeAmount'] is String
				? int.tryParse(json['tradeAmount'])
				: json['tradeAmount'].toInt();
	}
	if (json['balance'] != null) {
		data.balance = json['balance'] is String
				? int.tryParse(json['balance'])
				: json['balance'].toInt();
	}
	if (json['income'] != null) {
		data.income = json['income'] is String
				? int.tryParse(json['income'])
				: json['income'].toInt();
	}
	if (json['wipeOffAmount'] != null) {
		data.wipeOffAmount = json['wipeOffAmount'] is String
				? int.tryParse(json['wipeOffAmount'])
				: json['wipeOffAmount'].toInt();
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
	if (json['tradeNum'] != null) {
		data.tradeNum = json['tradeNum'] is String
				? int.tryParse(json['tradeNum'])
				: json['tradeNum'].toInt();
	}
	if (json['deliveryNum'] != null) {
		data.deliveryNum = json['deliveryNum'] is String
				? int.tryParse(json['deliveryNum'])
				: json['deliveryNum'].toInt();
	}
	if (json['returnOweNum'] != null) {
		data.returnOweNum = json['returnOweNum'] is String
				? int.tryParse(json['returnOweNum'])
				: json['returnOweNum'].toInt();
	}
	if (json['returnNum'] != null) {
		data.returnNum = json['returnNum'] is String
				? int.tryParse(json['returnNum'])
				: json['returnNum'].toInt();
	}
	if (json['oweNum'] != null) {
		data.oweNum = json['oweNum'] is String
				? int.tryParse(json['oweNum'])
				: json['oweNum'].toInt();
	}
	return data;
}

Map<String, dynamic> customerStatisticEntityToJson(CustomerStatisticEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['expense'] = entity.expense;
	data['remitAmount'] = entity.remitAmount;
	data['tradeAmount'] = entity.tradeAmount;
	data['balance'] = entity.balance;
	data['income'] = entity.income;
	data['wipeOffAmount'] = entity.wipeOffAmount;
	data['orderOweAmount'] = entity.orderOweAmount;
	data['oweAmount'] = entity.oweAmount;
	data['tradeNum'] = entity.tradeNum;
	data['deliveryNum'] = entity.deliveryNum;
	data['returnOweNum'] = entity.returnOweNum;
	data['returnNum'] = entity.returnNum;
	data['oweNum'] = entity.oweNum;
	return data;
}
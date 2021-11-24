import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_do_entity.dart';

biCustomerDoEntityFromJson(BiCustomerDoEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	if (json['customerNamePinYin'] != null) {
		data.customerNamePinYin = json['customerNamePinYin'].toString();
	}
	if (json['customerPhone'] != null) {
		data.customerPhone = json['customerPhone'].toString();
	}
	if (json['levelTag'] != null) {
		data.levelTag = json['levelTag'].toString();
	}
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
	if (json['shortageAmount'] != null) {
		data.shortageAmount = json['shortageAmount'] is String
				? int.tryParse(json['shortageAmount'])
				: json['shortageAmount'].toInt();
	}
	if (json['merchandiserId'] != null) {
		data.merchandiserId = json['merchandiserId'] is String
				? int.tryParse(json['merchandiserId'])
				: json['merchandiserId'].toInt();
	}
	if (json['merchandiserName'] != null) {
		data.merchandiserName = json['merchandiserName'].toString();
	}
	if (json['address'] != null) {
		data.address = json['address'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	return data;
}

Map<String, dynamic> biCustomerDoEntityToJson(BiCustomerDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['customerName'] = entity.customerName;
	data['customerNamePinYin'] = entity.customerNamePinYin;
	data['customerPhone'] = entity.customerPhone;
	data['levelTag'] = entity.levelTag;
	data['balance'] = entity.balance;
	data['orderOweAmount'] = entity.orderOweAmount;
	data['oweAmount'] = entity.oweAmount;
	data['shortageNum'] = entity.shortageNum;
	data['shortageAmount'] = entity.shortageAmount;
	data['merchandiserId'] = entity.merchandiserId;
	data['merchandiserName'] = entity.merchandiserName;
	data['address'] = entity.address;
	data['status'] = entity.status;
	return data;
}
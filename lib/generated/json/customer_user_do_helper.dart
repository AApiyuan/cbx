import 'package:haidai_flutter_module/model/customer_user_do.dart';

customerUserDoFromJson(CustomerUserDo data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['bindPhone'] != null) {
		data.bindPhone = json['bindPhone'].toString();
	}
	if (json['wx'] != null) {
		data.wx = json['wx'].toString();
	}
	if (json['customerUserId'] != null) {
		data.customerUserId = json['customerUserId'] is String
				? int.tryParse(json['customerUserId'])
				: json['customerUserId'].toInt();
	}
	if (json['entryTime'] != null) {
		data.entryTime = json['entryTime'] is String
				? int.tryParse(json['entryTime'])
				: json['entryTime'].toInt();
	}
	if (json['noSelectedDepts'] != null) {
		data.noSelectedDepts = json['noSelectedDepts'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? int.tryParse(json['updatedBy'])
				: json['updatedBy'].toInt();
	}
	if (json['createdByName'] != null) {
		data.createdByName = json['createdByName'].toString();
	}
	if (json['updatedByName'] != null) {
		data.updatedByName = json['updatedByName'].toString();
	}
	return data;
}

Map<String, dynamic> customerUserDoToJson(CustomerUserDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['avatar'] = entity.avatar;
	data['bindPhone'] = entity.bindPhone;
	data['wx'] = entity.wx;
	data['customerUserId'] = entity.customerUserId;
	data['entryTime'] = entity.entryTime;
	data['noSelectedDepts'] = entity.noSelectedDepts;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}
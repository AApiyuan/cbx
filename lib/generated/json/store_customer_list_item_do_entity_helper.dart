import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';

storeCustomerListItemDoEntityFromJson(StoreCustomerListItemDoEntity data, Map<String, dynamic> json) {
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
	if (json['merchandiserId'] != null) {
		data.merchandiserId = json['merchandiserId'] is String
				? int.tryParse(json['merchandiserId'])
				: json['merchandiserId'].toInt();
	}
	if (json['merchandiserName'] != null) {
		data.merchandiserName = json['merchandiserName'].toString();
	}
	if (json['managerUserName'] != null) {
		data.managerUserName = json['managerUserName'].toString();
	}
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	if (json['customerPhone'] != null) {
		data.customerPhone = json['customerPhone'].toString();
	}
	if (json['customerNamePhone'] != null) {
		data.customerNamePhone = json['customerNamePhone'].toString();
	}
	if (json['customerNamePinYin'] != null) {
		data.customerNamePinYin = json['customerNamePinYin'].toString();
	}
	if (json['levelTag'] != null) {
		data.levelTag = json['levelTag'].toString();
	}
	if (json['star'] != null) {
		data.star = json['star'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['balance'] != null) {
		data.balance = json['balance'] is String
				? int.tryParse(json['balance'])
				: json['balance'].toInt();
	}
	if (json['oweAmount'] != null) {
		data.oweAmount = json['oweAmount'] is String
				? int.tryParse(json['oweAmount'])
				: json['oweAmount'].toInt();
	}
	if (json['oweNum'] != null) {
		data.oweNum = json['oweNum'] is String
				? int.tryParse(json['oweNum'])
				: json['oweNum'].toInt();
	}
	if (json['orderOweAmount'] != null) {
		data.orderOweAmount = json['orderOweAmount'] is String
				? int.tryParse(json['orderOweAmount'])
				: json['orderOweAmount'].toInt();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
	}
	if (json['tax'] != null) {
		data.tax = json['tax'] is String
				? int.tryParse(json['tax'])
				: json['tax'].toInt();
	}
	if (json['offline'] != null) {
		data.offline = json['offline'] is String
				? int.tryParse(json['offline'])
				: json['offline'].toInt();
	}
	return data;
}

Map<String, dynamic> storeCustomerListItemDoEntityToJson(StoreCustomerListItemDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	data['merchandiserId'] = entity.merchandiserId;
	data['merchandiserName'] = entity.merchandiserName;
	data['managerUserName'] = entity.managerUserName;
	data['customerName'] = entity.customerName;
	data['customerPhone'] = entity.customerPhone;
	data['customerNamePhone'] = entity.customerNamePhone;
	data['customerNamePinYin'] = entity.customerNamePinYin;
	data['levelTag'] = entity.levelTag;
	data['star'] = entity.star;
	data['status'] = entity.status;
	data['balance'] = entity.balance;
	data['oweAmount'] = entity.oweAmount;
	data['oweNum'] = entity.oweNum;
	data['orderOweAmount'] = entity.orderOweAmount;
	data['userId'] = entity.userId;
	data['tax'] = entity.tax;
	data['offline'] = entity.offline;
	return data;
}
import 'package:haidai_flutter_module/page/customer/model/rep/store_customer_create_req_entity.dart';

storeCustomerCreateReqEntityFromJson(StoreCustomerCreateReqEntity data, Map<String, dynamic> json) {
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	if (json['customerPhone'] != null) {
		data.customerPhone = json['customerPhone'].toString();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
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
	if (json['tax'] != null) {
		data.tax = json['tax'] is String
				? int.tryParse(json['tax'])
				: json['tax'].toInt();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['merchandiserId'] != null) {
		data.merchandiserId = json['merchandiserId'] is String
				? int.tryParse(json['merchandiserId'])
				: json['merchandiserId'].toInt();
	}
	return data;
}

Map<String, dynamic> storeCustomerCreateReqEntityToJson(StoreCustomerCreateReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerName'] = entity.customerName;
	data['customerPhone'] = entity.customerPhone;
	data['deptId'] = entity.deptId;
	data['levelTag'] = entity.levelTag;
	data['star'] = entity.star;
	data['status'] = entity.status;
	data['tax'] = entity.tax;
	data['id'] = entity.id;
	data['merchandiserId'] = entity.merchandiserId;
	return data;
}
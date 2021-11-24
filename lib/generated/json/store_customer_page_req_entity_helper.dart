import 'package:haidai_flutter_module/page/customer/model/rep/store_customer_page_req_entity.dart';

storeCustomerPageReqEntityFromJson(StoreCustomerPageReqEntity data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['orderBy'] != null) {
		data.orderBy = json['orderBy'];
	}
	if (json['merchandiserIds'] != null) {
		data.merchandiserIds = (json['merchandiserIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['selectType'] != null) {
		data.selectType = json['selectType'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['customerNamePhone'] != null) {
		data.customerNamePhone = json['customerNamePhone'].toString();
	}
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	return data;
}

Map<String, dynamic> storeCustomerPageReqEntityToJson(StoreCustomerPageReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['orderBy'] = entity.orderBy;
	data['merchandiserIds'] = entity.merchandiserIds;
	data['selectType'] = entity.selectType;
	data['status'] = entity.status;
	data['customerNamePhone'] = entity.customerNamePhone;
	data['customerName'] = entity.customerName;
	return data;
}
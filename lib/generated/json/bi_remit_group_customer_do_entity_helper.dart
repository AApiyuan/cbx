import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_group_customer_do_entity.dart';

biRemitGroupCustomerDoEntityFromJson(BiRemitGroupCustomerDoEntity data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
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
	if (json['totalAmount'] != null) {
		data.totalAmount = json['totalAmount'] is String
				? int.tryParse(json['totalAmount'])
				: json['totalAmount'].toInt();
	}
	return data;
}

Map<String, dynamic> biRemitGroupCustomerDoEntityToJson(BiRemitGroupCustomerDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['customerId'] = entity.customerId;
	data['customerName'] = entity.customerName;
	data['receivedAmount'] = entity.receivedAmount;
	data['refundAmount'] = entity.refundAmount;
	data['totalAmount'] = entity.totalAmount;
	return data;
}
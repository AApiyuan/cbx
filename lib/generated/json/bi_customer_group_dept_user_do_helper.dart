import 'package:haidai_flutter_module/page/bi/model/res/bi_customer_group_dept_user_do.dart';

biCustomerGroupDeptUserDoFromJson(BiCustomerGroupDeptUserDo data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['merchandiserId'] != null) {
		data.merchandiserId = json['merchandiserId'] is String
				? int.tryParse(json['merchandiserId'])
				: json['merchandiserId'].toInt();
	}
	if (json['merchandiserName'] != null) {
		data.merchandiserName = json['merchandiserName'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'];
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

Map<String, dynamic> biCustomerGroupDeptUserDoToJson(BiCustomerGroupDeptUserDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['merchandiserId'] = entity.merchandiserId;
	data['merchandiserName'] = entity.merchandiserName;
	data['status'] = entity.status;
	data['balance'] = entity.balance;
	data['orderOweAmount'] = entity.orderOweAmount;
	data['oweAmount'] = entity.oweAmount;
	data['shortageNum'] = entity.shortageNum;
	data['customerNum'] = entity.customerNum;
	data['shortageAmount'] = entity.shortageAmount;
	return data;
}
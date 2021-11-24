import 'package:haidai_flutter_module/model/print_req_entity.dart';

printReqEntityFromJson(PrintReqEntity data, Map<String, dynamic> json) {
	if (json['customerDeptConfigTypeList'] != null) {
		data.customerDeptConfigTypeList = (json['customerDeptConfigTypeList'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	if (json['customerDeptId'] != null) {
		data.customerDeptId = json['customerDeptId'] is String
				? int.tryParse(json['customerDeptId'])
				: json['customerDeptId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderRemitId'] != null) {
		data.orderRemitId = json['orderRemitId'] is String
				? int.tryParse(json['orderRemitId'])
				: json['orderRemitId'].toInt();
	}
	if (json['pageWidth'] != null) {
		data.pageWidth = json['pageWidth'].toString();
	}
	if (json['printTypeName'] != null) {
		data.printTypeName = json['printTypeName'].toString();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['userName'] != null) {
		data.userName = json['userName'].toString();
	}
	if (json['userPhone'] != null) {
		data.userPhone = json['userPhone'].toString();
	}
	return data;
}

Map<String, dynamic> printReqEntityToJson(PrintReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['customerDeptConfigTypeList'] = entity.customerDeptConfigTypeList;
	data['customerDeptId'] = entity.customerDeptId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderRemitId'] = entity.orderRemitId;
	data['pageWidth'] = entity.pageWidth;
	data['printTypeName'] = entity.printTypeName;
	data['deptName'] = entity.deptName;
	data['userName'] = entity.userName;
	data['userPhone'] = entity.userPhone;
	return data;
}
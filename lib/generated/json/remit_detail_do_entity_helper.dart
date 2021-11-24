import 'package:haidai_flutter_module/page/gathering_detail/model/remit_detail_do_entity.dart';

remitDetailDoEntityFromJson(RemitDetailDoEntity data, Map<String, dynamic> json) {
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
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['orderRemitSerial'] != null) {
		data.orderRemitSerial = json['orderRemitSerial'].toString();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['createUserId'] != null) {
		data.createUserId = json['createUserId'] is String
				? int.tryParse(json['createUserId'])
				: json['createUserId'].toInt();
	}
	if (json['merchandiserId'] != null) {
		data.merchandiserId = json['merchandiserId'] is String
				? int.tryParse(json['merchandiserId'])
				: json['merchandiserId'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['remitAmount'] != null) {
		data.remitAmount = json['remitAmount'] is String
				? int.tryParse(json['remitAmount'])
				: json['remitAmount'].toInt();
	}
	if (json['checkSaleAmount'] != null) {
		data.checkSaleAmount = json['checkSaleAmount'] is String
				? int.tryParse(json['checkSaleAmount'])
				: json['checkSaleAmount'].toInt();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['createUserName'] != null) {
		data.createUserName = json['createUserName'].toString();
	}
	if (json['merchandiserName'] != null) {
		data.merchandiserName = json['merchandiserName'].toString();
	}
	if (json['remarkList'] != null) {
		data.remarkList = (json['remarkList'] as List).map((v) => RemitDetailDoRemarkList().fromJson(v)).toList();
	}
	if (json['remitRecordMethodList'] != null) {
		data.remitRecordMethodList = (json['remitRecordMethodList'] as List).map((v) => RemitDetailDoRemitRecordMethodList().fromJson(v)).toList();
	}
	if (json['remitRefundMethodList'] != null) {
		data.remitRefundMethodList = (json['remitRefundMethodList'] as List).map((v) => v).toList().cast<dynamic>();
	}
	if (json['storeCustomerBalanceChangeLogList'] != null) {
		data.storeCustomerBalanceChangeLogList = (json['storeCustomerBalanceChangeLogList'] as List).map((v) => RemitDetailDoStoreCustomerBalanceChangeLogList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> remitDetailDoEntityToJson(RemitDetailDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['orderRemitSerial'] = entity.orderRemitSerial;
	data['orderSaleId'] = entity.orderSaleId;
	data['type'] = entity.type;
	data['createUserId'] = entity.createUserId;
	data['merchandiserId'] = entity.merchandiserId;
	data['customerId'] = entity.customerId;
	data['customizeTime'] = entity.customizeTime;
	data['remitAmount'] = entity.remitAmount;
	data['checkSaleAmount'] = entity.checkSaleAmount;
	data['status'] = entity.status;
	data['canceled'] = entity.canceled;
	data['createUserName'] = entity.createUserName;
	data['merchandiserName'] = entity.merchandiserName;
	data['remarkList'] =  entity.remarkList?.map((v) => v.toJson())?.toList();
	data['remitRecordMethodList'] =  entity.remitRecordMethodList?.map((v) => v.toJson())?.toList();
	data['remitRefundMethodList'] = entity.remitRefundMethodList;
	data['storeCustomerBalanceChangeLogList'] =  entity.storeCustomerBalanceChangeLogList?.map((v) => v.toJson())?.toList();
	return data;
}

remitDetailDoRemarkListFromJson(RemitDetailDoRemarkList data, Map<String, dynamic> json) {
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
	if (json['orderId'] != null) {
		data.orderId = json['orderId'] is String
				? int.tryParse(json['orderId'])
				: json['orderId'].toInt();
	}
	if (json['orderType'] != null) {
		data.orderType = json['orderType'].toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	return data;
}

Map<String, dynamic> remitDetailDoRemarkListToJson(RemitDetailDoRemarkList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['orderId'] = entity.orderId;
	data['orderType'] = entity.orderType;
	data['remark'] = entity.remark;
	return data;
}

remitDetailDoRemitRecordMethodListFromJson(RemitDetailDoRemitRecordMethodList data, Map<String, dynamic> json) {
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
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['orderRemitId'] != null) {
		data.orderRemitId = json['orderRemitId'] is String
				? int.tryParse(json['orderRemitId'])
				: json['orderRemitId'].toInt();
	}
	if (json['remitMethodId'] != null) {
		data.remitMethodId = json['remitMethodId'] is String
				? int.tryParse(json['remitMethodId'])
				: json['remitMethodId'].toInt();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
	}
	if (json['approveStatus'] != null) {
		data.approveStatus = json['approveStatus'].toString();
	}
	if (json['remitMethodName'] != null) {
		data.remitMethodName = json['remitMethodName'].toString();
	}
	return data;
}

Map<String, dynamic> remitDetailDoRemitRecordMethodListToJson(RemitDetailDoRemitRecordMethodList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['orderRemitId'] = entity.orderRemitId;
	data['remitMethodId'] = entity.remitMethodId;
	data['amount'] = entity.amount;
	data['approveStatus'] = entity.approveStatus;
	data['remitMethodName'] = entity.remitMethodName;
	return data;
}

remitDetailDoStoreCustomerBalanceChangeLogListFromJson(RemitDetailDoStoreCustomerBalanceChangeLogList data, Map<String, dynamic> json) {
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
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
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
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['orderRemitSerial'] != null) {
		data.orderRemitSerial = json['orderRemitSerial'].toString();
	}
	return data;
}

Map<String, dynamic> remitDetailDoStoreCustomerBalanceChangeLogListToJson(RemitDetailDoStoreCustomerBalanceChangeLogList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['customerId'] = entity.customerId;
	data['type'] = entity.type;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderRemitId'] = entity.orderRemitId;
	data['amount'] = entity.amount;
	data['canceled'] = entity.canceled;
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['orderRemitSerial'] = entity.orderRemitSerial;
	return data;
}
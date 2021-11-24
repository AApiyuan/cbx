import 'package:haidai_flutter_module/page/sale_detail/models/store_customer_balance_change_log_detail_do.dart';

storeCustomerBalanceChangeLogDetailDoFromJson(StoreCustomerBalanceChangeLogDetailDo data, Map<String, dynamic> json) {
	if (json['remitDetailDo'] != null) {
		data.remitDetailDo = StoreCustomerBalanceChangeLogDetailDoRemitDetailDo().fromJson(json['remitDetailDo']);
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
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'];
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
		data.canceled = json['canceled'];
	}
	if (json['canceledUserId'] != null) {
		data.canceledUserId = json['canceledUserId'] is String
				? int.tryParse(json['canceledUserId'])
				: json['canceledUserId'].toInt();
	}
	if (json['canceledTime'] != null) {
		data.canceledTime = json['canceledTime'].toString();
	}
	if (json['canceledUserName'] != null) {
		data.canceledUserName = json['canceledUserName'].toString();
	}
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['orderRemitSerial'] != null) {
		data.orderRemitSerial = json['orderRemitSerial'].toString();
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

Map<String, dynamic> storeCustomerBalanceChangeLogDetailDoToJson(StoreCustomerBalanceChangeLogDetailDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['remitDetailDo'] = entity.remitDetailDo?.toJson();
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['userId'] = entity.userId;
	data['customerId'] = entity.customerId;
	data['type'] = entity.type;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderRemitId'] = entity.orderRemitId;
	data['amount'] = entity.amount;
	data['canceled'] = entity.canceled;
	data['canceledUserId'] = entity.canceledUserId;
	data['canceledTime'] = entity.canceledTime;
	data['canceledUserName'] = entity.canceledUserName;
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['orderRemitSerial'] = entity.orderRemitSerial;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

storeCustomerBalanceChangeLogDetailDoRemitDetailDoFromJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDo data, Map<String, dynamic> json) {
	if (json['remarkList'] != null) {
		data.remarkList = (json['remarkList'] as List).map((v) => StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemarkList().fromJson(v)).toList();
	}
	if (json['remitRecordMethodList'] != null) {
		data.remitRecordMethodList = (json['remitRecordMethodList'] as List).map((v) => StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRecordMethodList().fromJson(v)).toList();
	}
	if (json['remitRefundMethodList'] != null) {
		data.remitRefundMethodList = (json['remitRefundMethodList'] as List).map((v) => StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRefundMethodList().fromJson(v)).toList();
	}
	if (json['storeCustomerBalanceChangeLogList'] != null) {
		data.storeCustomerBalanceChangeLogList = (json['storeCustomerBalanceChangeLogList'] as List).map((v) => StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomerBalanceChangeLogList().fromJson(v)).toList();
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
		data.type = json['type'];
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
		data.status = json['status'];
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'];
	}
	if (json['canceledUserId'] != null) {
		data.canceledUserId = json['canceledUserId'] is String
				? int.tryParse(json['canceledUserId'])
				: json['canceledUserId'].toInt();
	}
	if (json['canceledTime'] != null) {
		data.canceledTime = json['canceledTime'].toString();
	}
	if (json['canceledUserName'] != null) {
		data.canceledUserName = json['canceledUserName'].toString();
	}
	if (json['createUserName'] != null) {
		data.createUserName = json['createUserName'].toString();
	}
	if (json['merchandiserName'] != null) {
		data.merchandiserName = json['merchandiserName'].toString();
	}
	if (json['storeCustomer'] != null) {
		data.storeCustomer = StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomer().fromJson(json['storeCustomer']);
	}
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
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

Map<String, dynamic> storeCustomerBalanceChangeLogDetailDoRemitDetailDoToJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['remarkList'] =  entity.remarkList?.map((v) => v.toJson())?.toList();
	data['remitRecordMethodList'] =  entity.remitRecordMethodList?.map((v) => v.toJson())?.toList();
	data['remitRefundMethodList'] =  entity.remitRefundMethodList?.map((v) => v.toJson())?.toList();
	data['storeCustomerBalanceChangeLogList'] =  entity.storeCustomerBalanceChangeLogList?.map((v) => v.toJson())?.toList();
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
	data['canceledUserId'] = entity.canceledUserId;
	data['canceledTime'] = entity.canceledTime;
	data['canceledUserName'] = entity.canceledUserName;
	data['createUserName'] = entity.createUserName;
	data['merchandiserName'] = entity.merchandiserName;
	data['storeCustomer'] = entity.storeCustomer?.toJson();
	data['amount'] = entity.amount;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

storeCustomerBalanceChangeLogDetailDoRemitDetailDoRemarkListFromJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemarkList data, Map<String, dynamic> json) {
	if (json['orderId'] != null) {
		data.orderId = json['orderId'] is String
				? int.tryParse(json['orderId'])
				: json['orderId'].toInt();
	}
	if (json['orderType'] != null) {
		data.orderType = json['orderType'];
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
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

Map<String, dynamic> storeCustomerBalanceChangeLogDetailDoRemitDetailDoRemarkListToJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemarkList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderId'] = entity.orderId;
	data['orderType'] = entity.orderType;
	data['remark'] = entity.remark;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

storeCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRecordMethodListFromJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRecordMethodList data, Map<String, dynamic> json) {
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
		data.approveStatus = json['approveStatus'];
	}
	if (json['approveUserId'] != null) {
		data.approveUserId = json['approveUserId'] is String
				? int.tryParse(json['approveUserId'])
				: json['approveUserId'].toInt();
	}
	if (json['approveTime'] != null) {
		data.approveTime = json['approveTime'].toString();
	}
	if (json['remitMethodName'] != null) {
		data.remitMethodName = json['remitMethodName'].toString();
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

Map<String, dynamic> storeCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRecordMethodListToJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRecordMethodList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['orderRemitId'] = entity.orderRemitId;
	data['remitMethodId'] = entity.remitMethodId;
	data['amount'] = entity.amount;
	data['approveStatus'] = entity.approveStatus;
	data['approveUserId'] = entity.approveUserId;
	data['approveTime'] = entity.approveTime;
	data['remitMethodName'] = entity.remitMethodName;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

storeCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRefundMethodListFromJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRefundMethodList data, Map<String, dynamic> json) {
	if (json['payeeName'] != null) {
		data.payeeName = json['payeeName'].toString();
	}
	if (json['payeeNo'] != null) {
		data.payeeNo = json['payeeNo'].toString();
	}
	if (json['payeePlatform'] != null) {
		data.payeePlatform = json['payeePlatform'].toString();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
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
	if (json['executeStatus'] != null) {
		data.executeStatus = json['executeStatus'];
	}
	if (json['executeBy'] != null) {
		data.executeBy = json['executeBy'] is String
				? int.tryParse(json['executeBy'])
				: json['executeBy'].toInt();
	}
	if (json['executeTime'] != null) {
		data.executeTime = json['executeTime'].toString();
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

Map<String, dynamic> storeCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRefundMethodListToJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRefundMethodList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['payeeName'] = entity.payeeName;
	data['payeeNo'] = entity.payeeNo;
	data['payeePlatform'] = entity.payeePlatform;
	data['amount'] = entity.amount;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['orderRemitId'] = entity.orderRemitId;
	data['executeStatus'] = entity.executeStatus;
	data['executeBy'] = entity.executeBy;
	data['executeTime'] = entity.executeTime;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

storeCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomerBalanceChangeLogListFromJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomerBalanceChangeLogList data, Map<String, dynamic> json) {
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
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'];
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
		data.canceled = json['canceled'];
	}
	if (json['canceledUserId'] != null) {
		data.canceledUserId = json['canceledUserId'] is String
				? int.tryParse(json['canceledUserId'])
				: json['canceledUserId'].toInt();
	}
	if (json['canceledTime'] != null) {
		data.canceledTime = json['canceledTime'].toString();
	}
	if (json['canceledUserName'] != null) {
		data.canceledUserName = json['canceledUserName'].toString();
	}
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['orderRemitSerial'] != null) {
		data.orderRemitSerial = json['orderRemitSerial'].toString();
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

Map<String, dynamic> storeCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomerBalanceChangeLogListToJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomerBalanceChangeLogList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['userId'] = entity.userId;
	data['customerId'] = entity.customerId;
	data['type'] = entity.type;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderRemitId'] = entity.orderRemitId;
	data['amount'] = entity.amount;
	data['canceled'] = entity.canceled;
	data['canceledUserId'] = entity.canceledUserId;
	data['canceledTime'] = entity.canceledTime;
	data['canceledUserName'] = entity.canceledUserName;
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['orderRemitSerial'] = entity.orderRemitSerial;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

storeCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomerFromJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomer data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	if (json['levelTag'] != null) {
		data.levelTag = json['levelTag'];
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
	if (json['orderOweAmount'] != null) {
		data.orderOweAmount = json['orderOweAmount'] is String
				? int.tryParse(json['orderOweAmount'])
				: json['orderOweAmount'].toInt();
	}
	return data;
}

Map<String, dynamic> storeCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomerToJson(StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['customerName'] = entity.customerName;
	data['levelTag'] = entity.levelTag;
	data['balance'] = entity.balance;
	data['oweAmount'] = entity.oweAmount;
	data['orderOweAmount'] = entity.orderOweAmount;
	return data;
}
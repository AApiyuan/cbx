import 'package:haidai_flutter_module/page/bi/model/res/bi_remit_do.dart';

biRemitDoFromJson(BiRemitDo data, Map<String, dynamic> json) {
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
	if (json['orderRemitId'] != null) {
		data.orderRemitId = json['orderRemitId'] is String
				? int.tryParse(json['orderRemitId'])
				: json['orderRemitId'].toInt();
	}
	if (json['orderRemitSerial'] != null) {
		data.orderRemitSerial = json['orderRemitSerial'].toString();
	}
	if (json['orderRemitSerialNo'] != null) {
		data.orderRemitSerialNo = json['orderRemitSerialNo'] is String
				? int.tryParse(json['orderRemitSerialNo'])
				: json['orderRemitSerialNo'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['orderSaleSerialNo'] != null) {
		data.orderSaleSerialNo = json['orderSaleSerialNo'] is String
				? int.tryParse(json['orderSaleSerialNo'])
				: json['orderSaleSerialNo'].toInt();
	}
	if (json['orderSaleCustomizeTime'] != null) {
		data.orderSaleCustomizeTime = json['orderSaleCustomizeTime'] is String
				? int.tryParse(json['orderSaleCustomizeTime'])
				: json['orderSaleCustomizeTime'].toInt();
	}
	if (json['orderSaleCustomizeDate'] != null) {
		data.orderSaleCustomizeDate = json['orderSaleCustomizeDate'] is String
				? int.tryParse(json['orderSaleCustomizeDate'])
				: json['orderSaleCustomizeDate'].toInt();
	}
	if (json['orderSaleCustomizeDateTime'] != null) {
		data.orderSaleCustomizeDateTime = json['orderSaleCustomizeDateTime'] is String
				? int.tryParse(json['orderSaleCustomizeDateTime'])
				: json['orderSaleCustomizeDateTime'].toInt();
	}
	if (json['remarkList'] != null) {
		data.remarkList = (json['remarkList'] as List).map((v) => BiRemitDoRemarkList().fromJson(v)).toList();
	}
	if (json['type'] != null) {
		data.type = json['type'];
	}
	if (json['remitMethodId'] != null) {
		data.remitMethodId = json['remitMethodId'] is String
				? int.tryParse(json['remitMethodId'])
				: json['remitMethodId'].toInt();
	}
	if (json['remitMethodName'] != null) {
		data.remitMethodName = json['remitMethodName'].toString();
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
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['customizeDate'] != null) {
		data.customizeDate = json['customizeDate'] is String
				? int.tryParse(json['customizeDate'])
				: json['customizeDate'].toInt();
	}
	if (json['customizeDateTime'] != null) {
		data.customizeDateTime = json['customizeDateTime'] is String
				? int.tryParse(json['customizeDateTime'])
				: json['customizeDateTime'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'] is String
				? int.tryParse(json['createdTime'])
				: json['createdTime'].toInt();
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
	if (json['canceled'] != null) {
		data.canceled = json['canceled'];
	}
	if (json['canceledUserId'] != null) {
		data.canceledUserId = json['canceledUserId'] is String
				? int.tryParse(json['canceledUserId'])
				: json['canceledUserId'].toInt();
	}
	if (json['canceledTime'] != null) {
		data.canceledTime = json['canceledTime'] is String
				? int.tryParse(json['canceledTime'])
				: json['canceledTime'].toInt();
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
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	if (json['customerPhone'] != null) {
		data.customerPhone = json['customerPhone'].toString();
	}
	if (json['levelTag'] != null) {
		data.levelTag = json['levelTag'];
	}
	return data;
}

Map<String, dynamic> biRemitDoToJson(BiRemitDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['orderRemitId'] = entity.orderRemitId;
	data['orderRemitSerial'] = entity.orderRemitSerial;
	data['orderRemitSerialNo'] = entity.orderRemitSerialNo;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['orderSaleSerialNo'] = entity.orderSaleSerialNo;
	data['orderSaleCustomizeTime'] = entity.orderSaleCustomizeTime;
	data['orderSaleCustomizeDate'] = entity.orderSaleCustomizeDate;
	data['orderSaleCustomizeDateTime'] = entity.orderSaleCustomizeDateTime;
	data['remarkList'] =  entity.remarkList?.map((v) => v.toJson())?.toList();
	data['type'] = entity.type;
	data['remitMethodId'] = entity.remitMethodId;
	data['remitMethodName'] = entity.remitMethodName;
	data['receivedAmount'] = entity.receivedAmount;
	data['refundAmount'] = entity.refundAmount;
	data['totalAmount'] = entity.totalAmount;
	data['customizeTime'] = entity.customizeTime;
	data['customizeDate'] = entity.customizeDate;
	data['customizeDateTime'] = entity.customizeDateTime;
	data['createdTime'] = entity.createdTime;
	data['createUserId'] = entity.createUserId;
	data['merchandiserId'] = entity.merchandiserId;
	data['customerId'] = entity.customerId;
	data['canceled'] = entity.canceled;
	data['canceledUserId'] = entity.canceledUserId;
	data['canceledTime'] = entity.canceledTime;
	data['canceledUserName'] = entity.canceledUserName;
	data['createUserName'] = entity.createUserName;
	data['merchandiserName'] = entity.merchandiserName;
	data['customerName'] = entity.customerName;
	data['customerPhone'] = entity.customerPhone;
	data['levelTag'] = entity.levelTag;
	return data;
}

biRemitDoRemarkListFromJson(BiRemitDoRemarkList data, Map<String, dynamic> json) {
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
		data.createdTime = json['createdTime'] is String
				? int.tryParse(json['createdTime'])
				: json['createdTime'].toInt();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'] is String
				? int.tryParse(json['updatedTime'])
				: json['updatedTime'].toInt();
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

Map<String, dynamic> biRemitDoRemarkListToJson(BiRemitDoRemarkList entity) {
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
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_list_do_entity.dart';

transferListDoEntityFromJson(TransferListDoEntity data, Map<String, dynamic> json) {
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
	if (json['createdByName'] != null) {
		data.createdByName = json['createdByName'].toString();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['stockOutDeptId'] != null) {
		data.stockOutDeptId = json['stockOutDeptId'] is String
				? int.tryParse(json['stockOutDeptId'])
				: json['stockOutDeptId'].toInt();
	}
	if (json['stockOutDeptName'] != null) {
		data.stockOutDeptName = json['stockOutDeptName'].toString();
	}
	if (json['stockInDeptId'] != null) {
		data.stockInDeptId = json['stockInDeptId'] is String
				? int.tryParse(json['stockInDeptId'])
				: json['stockInDeptId'].toInt();
	}
	if (json['stockInDeptName'] != null) {
		data.stockInDeptName = json['stockInDeptName'].toString();
	}
	if (json['orderSerial'] != null) {
		data.orderSerial = json['orderSerial'].toString();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['orderStockOutId'] != null) {
		data.orderStockOutId = json['orderStockOutId'] is String
				? int.tryParse(json['orderStockOutId'])
				: json['orderStockOutId'].toInt();
	}
	if (json['stockOutNum'] != null) {
		data.stockOutNum = json['stockOutNum'] is String
				? int.tryParse(json['stockOutNum'])
				: json['stockOutNum'].toInt();
	}
	if (json['stockInNum'] != null) {
		data.stockInNum = json['stockInNum'] is String
				? int.tryParse(json['stockInNum'])
				: json['stockInNum'].toInt();
	}
	if (json['applyNum'] != null) {
		data.applyNum = json['applyNum'] is String
				? int.tryParse(json['applyNum'])
				: json['applyNum'].toInt();
	}
	if (json['stockOutStyleNum'] != null) {
		data.stockOutStyleNum = json['stockOutStyleNum'] is String
				? int.tryParse(json['stockOutStyleNum'])
				: json['stockOutStyleNum'].toInt();
	}
	if (json['stockInStyleNum'] != null) {
		data.stockInStyleNum = json['stockInStyleNum'] is String
				? int.tryParse(json['stockInStyleNum'])
				: json['stockInStyleNum'].toInt();
	}
	if (json['applyStyleNum'] != null) {
		data.applyStyleNum = json['applyStyleNum'] is String
				? int.tryParse(json['applyStyleNum'])
				: json['applyStyleNum'].toInt();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['difference'] != null) {
		data.difference = json['difference'].toString();
	}
	if (json['orderType'] != null) {
		data.orderType = json['orderType'].toString();
	}
	if (json['deliveryStatus'] != null) {
		data.deliveryStatus = json['deliveryStatus'].toString();
	}
	if (json['substandard'] != null) {
		data.substandard = json['substandard'].toString();
	}
	if (json['distribution'] != null) {
		data.distribution = json['distribution'].toString();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['remarks'] != null) {
		data.remarks = (json['remarks'] as List).map((v) => TransferListDoRemarks().fromJson(v)).toList();
	}
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['orderSaleCustomizeTime'] != null) {
		data.orderSaleCustomizeTime = json['orderSaleCustomizeTime'].toString();
	}
	if (json['storeCustomer'] != null) {
		data.storeCustomer = TransferListDoStoreCustomer().fromJson(json['storeCustomer']);
	}
	return data;
}

Map<String, dynamic> transferListDoEntityToJson(TransferListDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['createdByName'] = entity.createdByName;
	data['topDeptId'] = entity.topDeptId;
	data['stockOutDeptId'] = entity.stockOutDeptId;
	data['stockOutDeptName'] = entity.stockOutDeptName;
	data['stockInDeptId'] = entity.stockInDeptId;
	data['stockInDeptName'] = entity.stockInDeptName;
	data['orderSerial'] = entity.orderSerial;
	data['orderSaleId'] = entity.orderSaleId;
	data['customerId'] = entity.customerId;
	data['orderStockOutId'] = entity.orderStockOutId;
	data['stockOutNum'] = entity.stockOutNum;
	data['stockInNum'] = entity.stockInNum;
	data['applyNum'] = entity.applyNum;
	data['stockOutStyleNum'] = entity.stockOutStyleNum;
	data['stockInStyleNum'] = entity.stockInStyleNum;
	data['applyStyleNum'] = entity.applyStyleNum;
	data['status'] = entity.status;
	data['difference'] = entity.difference;
	data['orderType'] = entity.orderType;
	data['deliveryStatus'] = entity.deliveryStatus;
	data['substandard'] = entity.substandard;
	data['distribution'] = entity.distribution;
	data['canceled'] = entity.canceled;
	data['customizeTime'] = entity.customizeTime;
	data['remarks'] =  entity.remarks?.map((v) => v.toJson())?.toList();
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['orderSaleCustomizeTime'] = entity.orderSaleCustomizeTime;
	data['storeCustomer'] = entity.storeCustomer?.toJson();
	return data;
}

transferListDoRemarksFromJson(TransferListDoRemarks data, Map<String, dynamic> json) {
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
	if (json['createdByName'] != null) {
		data.createdByName = json['createdByName'].toString();
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

Map<String, dynamic> transferListDoRemarksToJson(TransferListDoRemarks entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['createdByName'] = entity.createdByName;
	data['orderId'] = entity.orderId;
	data['orderType'] = entity.orderType;
	data['remark'] = entity.remark;
	return data;
}

transferListDoStoreCustomerFromJson(TransferListDoStoreCustomer data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	if (json['levelTag'] != null) {
		data.levelTag = json['levelTag'].toString();
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

Map<String, dynamic> transferListDoStoreCustomerToJson(TransferListDoStoreCustomer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['customerName'] = entity.customerName;
	data['levelTag'] = entity.levelTag;
	data['balance'] = entity.balance;
	data['oweAmount'] = entity.oweAmount;
	data['orderOweAmount'] = entity.orderOweAmount;
	return data;
}
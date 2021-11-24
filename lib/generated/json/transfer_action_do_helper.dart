import 'package:haidai_flutter_module/page/transfer/model/res/transfer_action_do.dart';

transferActionDoFromJson(TransferActionDo data, Map<String, dynamic> json) {
	if (json['orderTransferId'] != null) {
		data.orderTransferId = json['orderTransferId'] is String
				? int.tryParse(json['orderTransferId'])
				: json['orderTransferId'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'];
	}
	if (json['orderStockDeptId'] != null) {
		data.orderStockDeptId = json['orderStockDeptId'] is String
				? int.tryParse(json['orderStockDeptId'])
				: json['orderStockDeptId'].toInt();
	}
	if (json['orderStockId'] != null) {
		data.orderStockId = json['orderStockId'] is String
				? int.tryParse(json['orderStockId'])
				: json['orderStockId'].toInt();
	}
	if (json['orderStockSerial'] != null) {
		data.orderStockSerial = json['orderStockSerial'] is String
				? int.tryParse(json['orderStockSerial'])
				: json['orderStockSerial'].toInt();
	}
	if (json['stockOutNum'] != null) {
		data.stockOutNum = json['stockOutNum'] is String
				? int.tryParse(json['stockOutNum'])
				: json['stockOutNum'].toInt();
	}
	if (json['stockOutStyleNum'] != null) {
		data.stockOutStyleNum = json['stockOutStyleNum'] is String
				? int.tryParse(json['stockOutStyleNum'])
				: json['stockOutStyleNum'].toInt();
	}
	if (json['stockInNum'] != null) {
		data.stockInNum = json['stockInNum'] is String
				? int.tryParse(json['stockInNum'])
				: json['stockInNum'].toInt();
	}
	if (json['stockInStyleNum'] != null) {
		data.stockInStyleNum = json['stockInStyleNum'] is String
				? int.tryParse(json['stockInStyleNum'])
				: json['stockInStyleNum'].toInt();
	}
	if (json['applyNum'] != null) {
		data.applyNum = json['applyNum'] is String
				? int.tryParse(json['applyNum'])
				: json['applyNum'].toInt();
	}
	if (json['applyStyleNum'] != null) {
		data.applyStyleNum = json['applyStyleNum'] is String
				? int.tryParse(json['applyStyleNum'])
				: json['applyStyleNum'].toInt();
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
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	if (json['orderDeliveryDeptId'] != null) {
		data.orderDeliveryDeptId = json['orderDeliveryDeptId'] is String
				? int.tryParse(json['orderDeliveryDeptId'])
				: json['orderDeliveryDeptId'].toInt();
	}
	if (json['orderDeliverySerial'] != null) {
		data.orderDeliverySerial = json['orderDeliverySerial'].toString();
	}
	if (json['orderDeliveryGoodsNum'] != null) {
		data.orderDeliveryGoodsNum = json['orderDeliveryGoodsNum'] is String
				? int.tryParse(json['orderDeliveryGoodsNum'])
				: json['orderDeliveryGoodsNum'].toInt();
	}
	if (json['orderDeliveryGoodsStyleNum'] != null) {
		data.orderDeliveryGoodsStyleNum = json['orderDeliveryGoodsStyleNum'] is String
				? int.tryParse(json['orderDeliveryGoodsStyleNum'])
				: json['orderDeliveryGoodsStyleNum'].toInt();
	}
	return data;
}

Map<String, dynamic> transferActionDoToJson(TransferActionDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderTransferId'] = entity.orderTransferId;
	data['type'] = entity.type;
	data['orderStockDeptId'] = entity.orderStockDeptId;
	data['orderStockId'] = entity.orderStockId;
	data['orderStockSerial'] = entity.orderStockSerial;
	data['stockOutNum'] = entity.stockOutNum;
	data['stockOutStyleNum'] = entity.stockOutStyleNum;
	data['stockInNum'] = entity.stockInNum;
	data['stockInStyleNum'] = entity.stockInStyleNum;
	data['applyNum'] = entity.applyNum;
	data['applyStyleNum'] = entity.applyStyleNum;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['canceled'] = entity.canceled;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	data['orderDeliveryDeptId'] = entity.orderDeliveryDeptId;
	data['orderDeliverySerial'] = entity.orderDeliverySerial;
	data['orderDeliveryGoodsNum'] = entity.orderDeliveryGoodsNum;
	data['orderDeliveryGoodsStyleNum'] = entity.orderDeliveryGoodsStyleNum;
	return data;
}
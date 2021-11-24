import 'package:haidai_flutter_module/page/sale_operation/models/sale_action_detail_do.dart';

saleActionDetailDoFromJson(SaleActionDetailDo data, Map<String, dynamic> json) {
	if (json['type'] != null) {
		data.type = json['type'];
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? int.tryParse(json['createdBy'])
				: json['createdBy'].toInt();
	}
	if (json['createdByName'] != null) {
		data.createdByName = json['createdByName'].toString();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['orderSerial'] != null) {
		data.orderSerial = json['orderSerial'].toString();
	}
	if (json['orderId'] != null) {
		data.orderId = json['orderId'] is String
				? int.tryParse(json['orderId'])
				: json['orderId'].toInt();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
	}
	if (json['goodsStyleNum'] != null) {
		data.goodsStyleNum = json['goodsStyleNum'] is String
				? int.tryParse(json['goodsStyleNum'])
				: json['goodsStyleNum'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['normalSaleNum'] != null) {
		data.normalSaleNum = json['normalSaleNum'] is String
				? int.tryParse(json['normalSaleNum'])
				: json['normalSaleNum'].toInt();
	}
	if (json['returnGoodsNum'] != null) {
		data.returnGoodsNum = json['returnGoodsNum'] is String
				? int.tryParse(json['returnGoodsNum'])
				: json['returnGoodsNum'].toInt();
	}
	if (json['changeBackOrderGoodsNum'] != null) {
		data.changeBackOrderGoodsNum = json['changeBackOrderGoodsNum'] is String
				? int.tryParse(json['changeBackOrderGoodsNum'])
				: json['changeBackOrderGoodsNum'].toInt();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['warehouseName'] != null) {
		data.warehouseName = json['warehouseName'].toString();
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
	if (json['substandard'] != null) {
		data.substandard = json['substandard'].toString();
	}
	return data;
}

Map<String, dynamic> saleActionDetailDoToJson(SaleActionDetailDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['type'] = entity.type;
	data['createdBy'] = entity.createdBy;
	data['createdByName'] = entity.createdByName;
	data['createdTime'] = entity.createdTime;
	data['orderSerial'] = entity.orderSerial;
	data['orderId'] = entity.orderId;
	data['amount'] = entity.amount;
	data['goodsStyleNum'] = entity.goodsStyleNum;
	data['goodsNum'] = entity.goodsNum;
	data['normalSaleNum'] = entity.normalSaleNum;
	data['returnGoodsNum'] = entity.returnGoodsNum;
	data['changeBackOrderGoodsNum'] = entity.changeBackOrderGoodsNum;
	data['warehouseId'] = entity.warehouseId;
	data['warehouseName'] = entity.warehouseName;
	data['canceled'] = entity.canceled;
	data['canceledUserId'] = entity.canceledUserId;
	data['canceledTime'] = entity.canceledTime;
	data['canceledUserName'] = entity.canceledUserName;
	data['substandard'] = entity.substandard;
	return data;
}
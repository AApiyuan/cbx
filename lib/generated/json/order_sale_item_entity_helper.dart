import 'package:haidai_flutter_module/page/verification/model/order_sale_item_entity.dart';

orderSaleItemEntityFromJson(OrderSaleItemEntity data, Map<String, dynamic> json) {
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['taxOriginalAmount'] != null) {
		data.taxOriginalAmount = json['taxOriginalAmount'] is String
				? double.tryParse(json['taxOriginalAmount'])
				: json['taxOriginalAmount'].toDouble();
	}
	if (json['balanceAmount'] != null) {
		data.balanceAmount = json['balanceAmount'] is String
				? double.tryParse(json['balanceAmount'])
				: json['balanceAmount'].toDouble();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['merchandiserId'] != null) {
		data.merchandiserId = json['merchandiserId'] is String
				? double.tryParse(json['merchandiserId'])
				: json['merchandiserId'].toDouble();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['configDistribution'] != null) {
		data.configDistribution = json['configDistribution'].toString();
	}
	if (json['decrementAmount'] != null) {
		data.decrementAmount = json['decrementAmount'] is String
				? double.tryParse(json['decrementAmount'])
				: json['decrementAmount'].toDouble();
	}
	if (json['canceledNum'] != null) {
		data.canceledNum = json['canceledNum'] is String
				? double.tryParse(json['canceledNum'])
				: json['canceledNum'].toDouble();
	}
	if (json['wipeOffAmount'] != null) {
		data.wipeOffAmount = json['wipeOffAmount'] is String
				? double.tryParse(json['wipeOffAmount'])
				: json['wipeOffAmount'].toDouble();
	}
	if (json['decrementStyleNum'] != null) {
		data.decrementStyleNum = json['decrementStyleNum'] is String
				? double.tryParse(json['decrementStyleNum'])
				: json['decrementStyleNum'].toDouble();
	}
	if (json['taxReceivableAmount'] != null) {
		data.taxReceivableAmount = json['taxReceivableAmount'] is String
				? double.tryParse(json['taxReceivableAmount'])
				: json['taxReceivableAmount'].toDouble();
	}
	if (json['originalAmount'] != null) {
		data.originalAmount = json['originalAmount'] is String
				? double.tryParse(json['originalAmount'])
				: json['originalAmount'].toDouble();
	}
	if (json['decrementNum'] != null) {
		data.decrementNum = json['decrementNum'] is String
				? double.tryParse(json['decrementNum'])
				: json['decrementNum'].toDouble();
	}
	if (json['normalSaleAmount'] != null) {
		data.normalSaleAmount = json['normalSaleAmount'] is String
				? double.tryParse(json['normalSaleAmount'])
				: json['normalSaleAmount'].toDouble();
	}
	if (json['updatedByName'] != null) {
		data.updatedByName = json['updatedByName'].toString();
	}
	if (json['incrementStyleNum'] != null) {
		data.incrementStyleNum = json['incrementStyleNum'] is String
				? double.tryParse(json['incrementStyleNum'])
				: json['incrementStyleNum'].toDouble();
	}
	if (json['discountAmount'] != null) {
		data.discountAmount = json['discountAmount'] is String
				? double.tryParse(json['discountAmount'])
				: json['discountAmount'].toDouble();
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'] is String
				? double.tryParse(json['updatedBy'])
				: json['updatedBy'].toDouble();
	}
	if (json['incrementNum'] != null) {
		data.incrementNum = json['incrementNum'] is String
				? double.tryParse(json['incrementNum'])
				: json['incrementNum'].toDouble();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? double.tryParse(json['topDeptId'])
				: json['topDeptId'].toDouble();
	}
	if (json['incrementAmount'] != null) {
		data.incrementAmount = json['incrementAmount'] is String
				? double.tryParse(json['incrementAmount'])
				: json['incrementAmount'].toDouble();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['canceledAmount'] != null) {
		data.canceledAmount = json['canceledAmount'] is String
				? double.tryParse(json['canceledAmount'])
				: json['canceledAmount'].toDouble();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['changeBackOrderGoodsTaxAmount'] != null) {
		data.changeBackOrderGoodsTaxAmount = json['changeBackOrderGoodsTaxAmount'] is String
				? double.tryParse(json['changeBackOrderGoodsTaxAmount'])
				: json['changeBackOrderGoodsTaxAmount'].toDouble();
	}
	if (json['changeBackOrderGoodsStyleNum'] != null) {
		data.changeBackOrderGoodsStyleNum = json['changeBackOrderGoodsStyleNum'] is String
				? double.tryParse(json['changeBackOrderGoodsStyleNum'])
				: json['changeBackOrderGoodsStyleNum'].toDouble();
	}
	if (json['createUserId'] != null) {
		data.createUserId = json['createUserId'] is String
				? double.tryParse(json['createUserId'])
				: json['createUserId'].toDouble();
	}
	if (json['decrementTaxAmount'] != null) {
		data.decrementTaxAmount = json['decrementTaxAmount'] is String
				? double.tryParse(json['decrementTaxAmount'])
				: json['decrementTaxAmount'].toDouble();
	}
	if (json['normalSaleNum'] != null) {
		data.normalSaleNum = json['normalSaleNum'] is String
				? double.tryParse(json['normalSaleNum'])
				: json['normalSaleNum'].toDouble();
	}
	if (json['returnGoodsAmount'] != null) {
		data.returnGoodsAmount = json['returnGoodsAmount'] is String
				? double.tryParse(json['returnGoodsAmount'])
				: json['returnGoodsAmount'].toDouble();
	}
	if (json['storeCustomer'] != null) {
		data.storeCustomer = OrderSaleItemStoreCustomer().fromJson(json['storeCustomer']);
	}
	if (json['checkAmount'] != null) {
		data.checkAmount = json['checkAmount'] is String
				? double.tryParse(json['checkAmount'])
				: json['checkAmount'].toDouble();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['returnGoodsNum'] != null) {
		data.returnGoodsNum = json['returnGoodsNum'] is String
				? double.tryParse(json['returnGoodsNum'])
				: json['returnGoodsNum'].toDouble();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? double.tryParse(json['customerId'])
				: json['customerId'].toDouble();
	}
	if (json['createdBy'] != null) {
		data.createdBy = json['createdBy'] is String
				? double.tryParse(json['createdBy'])
				: json['createdBy'].toDouble();
	}
	if (json['changeBackOrderGoodsAmount'] != null) {
		data.changeBackOrderGoodsAmount = json['changeBackOrderGoodsAmount'] is String
				? double.tryParse(json['changeBackOrderGoodsAmount'])
				: json['changeBackOrderGoodsAmount'].toDouble();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? double.tryParse(json['shortageNum'])
				: json['shortageNum'].toDouble();
	}
	if (json['returnGoodsStyleNum'] != null) {
		data.returnGoodsStyleNum = json['returnGoodsStyleNum'] is String
				? double.tryParse(json['returnGoodsStyleNum'])
				: json['returnGoodsStyleNum'].toDouble();
	}
	if (json['changeBackOrderGoodsNum'] != null) {
		data.changeBackOrderGoodsNum = json['changeBackOrderGoodsNum'] is String
				? double.tryParse(json['changeBackOrderGoodsNum'])
				: json['changeBackOrderGoodsNum'].toDouble();
	}
	if (json['deliveryAmount'] != null) {
		data.deliveryAmount = json['deliveryAmount'] is String
				? double.tryParse(json['deliveryAmount'])
				: json['deliveryAmount'].toDouble();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? double.tryParse(json['warehouseId'])
				: json['warehouseId'].toDouble();
	}
	if (json['deliveryNum'] != null) {
		data.deliveryNum = json['deliveryNum'] is String
				? double.tryParse(json['deliveryNum'])
				: json['deliveryNum'].toDouble();
	}
	if (json['normalSaleStyleNum'] != null) {
		data.normalSaleStyleNum = json['normalSaleStyleNum'] is String
				? double.tryParse(json['normalSaleStyleNum'])
				: json['normalSaleStyleNum'].toDouble();
	}
	if (json['normalSaleTaxAmount'] != null) {
		data.normalSaleTaxAmount = json['normalSaleTaxAmount'] is String
				? double.tryParse(json['normalSaleTaxAmount'])
				: json['normalSaleTaxAmount'].toDouble();
	}
	if (json['createdByName'] != null) {
		data.createdByName = json['createdByName'].toString();
	}
	if (json['shortageAmount'] != null) {
		data.shortageAmount = json['shortageAmount'] is String
				? double.tryParse(json['shortageAmount'])
				: json['shortageAmount'].toDouble();
	}
	if (json['incrementTaxAmount'] != null) {
		data.incrementTaxAmount = json['incrementTaxAmount'] is String
				? double.tryParse(json['incrementTaxAmount'])
				: json['incrementTaxAmount'].toDouble();
	}
	if (json['tax'] != null) {
		data.tax = json['tax'] is String
				? double.tryParse(json['tax'])
				: json['tax'].toDouble();
	}
	if (json['createUserName'] != null) {
		data.createUserName = json['createUserName'].toString();
	}
	if (json['printNum'] != null) {
		data.printNum = json['printNum'] is String
				? double.tryParse(json['printNum'])
				: json['printNum'].toDouble();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? double.tryParse(json['deptId'])
				: json['deptId'].toDouble();
	}
	if (json['returnGoodsTaxAmount'] != null) {
		data.returnGoodsTaxAmount = json['returnGoodsTaxAmount'] is String
				? double.tryParse(json['returnGoodsTaxAmount'])
				: json['returnGoodsTaxAmount'].toDouble();
	}
	if (json['substandard'] != null) {
		data.substandard = json['substandard'].toString();
	}
	if (json['merchandiserName'] != null) {
		data.merchandiserName = json['merchandiserName'].toString();
	}
	if (json['taxAmount'] != null) {
		data.taxAmount = json['taxAmount'] is String
				? double.tryParse(json['taxAmount'])
				: json['taxAmount'].toDouble();
	}
	if (json['updatedTime'] != null) {
		data.updatedTime = json['updatedTime'].toString();
	}
	if (json['receivableAmount'] != null) {
		data.receivableAmount = json['receivableAmount'] is String
				? double.tryParse(json['receivableAmount'])
				: json['receivableAmount'].toDouble();
	}
	if (json['writeOffAmount'] != null) {
		data.writeOffAmount = json['writeOffAmount'] is String
				? double.tryParse(json['writeOffAmount'])
				: json['writeOffAmount'].toDouble();
	}
	if (json['tempWriteOffAmount'] != null) {
		data.tempWriteOffAmount = json['tempWriteOffAmount'] is String
				? double.tryParse(json['tempWriteOffAmount'])
				: json['tempWriteOffAmount'].toDouble();
	}
	if (json['isCheck'] != null) {
		data.isCheck = json['isCheck'];
	}
	return data;
}

Map<String, dynamic> orderSaleItemEntityToJson(OrderSaleItemEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['taxOriginalAmount'] = entity.taxOriginalAmount;
	data['balanceAmount'] = entity.balanceAmount;
	data['createdTime'] = entity.createdTime;
	data['id'] = entity.id;
	data['merchandiserId'] = entity.merchandiserId;
	data['customizeTime'] = entity.customizeTime;
	data['configDistribution'] = entity.configDistribution;
	data['decrementAmount'] = entity.decrementAmount;
	data['canceledNum'] = entity.canceledNum;
	data['wipeOffAmount'] = entity.wipeOffAmount;
	data['decrementStyleNum'] = entity.decrementStyleNum;
	data['taxReceivableAmount'] = entity.taxReceivableAmount;
	data['originalAmount'] = entity.originalAmount;
	data['decrementNum'] = entity.decrementNum;
	data['normalSaleAmount'] = entity.normalSaleAmount;
	data['updatedByName'] = entity.updatedByName;
	data['incrementStyleNum'] = entity.incrementStyleNum;
	data['discountAmount'] = entity.discountAmount;
	data['updatedBy'] = entity.updatedBy;
	data['incrementNum'] = entity.incrementNum;
	data['topDeptId'] = entity.topDeptId;
	data['incrementAmount'] = entity.incrementAmount;
	data['status'] = entity.status;
	data['canceledAmount'] = entity.canceledAmount;
	data['type'] = entity.type;
	data['changeBackOrderGoodsTaxAmount'] = entity.changeBackOrderGoodsTaxAmount;
	data['changeBackOrderGoodsStyleNum'] = entity.changeBackOrderGoodsStyleNum;
	data['createUserId'] = entity.createUserId;
	data['decrementTaxAmount'] = entity.decrementTaxAmount;
	data['normalSaleNum'] = entity.normalSaleNum;
	data['returnGoodsAmount'] = entity.returnGoodsAmount;
	data['storeCustomer'] = entity.storeCustomer?.toJson();
	data['checkAmount'] = entity.checkAmount;
	data['canceled'] = entity.canceled;
	data['returnGoodsNum'] = entity.returnGoodsNum;
	data['customerId'] = entity.customerId;
	data['createdBy'] = entity.createdBy;
	data['changeBackOrderGoodsAmount'] = entity.changeBackOrderGoodsAmount;
	data['shortageNum'] = entity.shortageNum;
	data['returnGoodsStyleNum'] = entity.returnGoodsStyleNum;
	data['changeBackOrderGoodsNum'] = entity.changeBackOrderGoodsNum;
	data['deliveryAmount'] = entity.deliveryAmount;
	data['warehouseId'] = entity.warehouseId;
	data['deliveryNum'] = entity.deliveryNum;
	data['normalSaleStyleNum'] = entity.normalSaleStyleNum;
	data['normalSaleTaxAmount'] = entity.normalSaleTaxAmount;
	data['createdByName'] = entity.createdByName;
	data['shortageAmount'] = entity.shortageAmount;
	data['incrementTaxAmount'] = entity.incrementTaxAmount;
	data['tax'] = entity.tax;
	data['createUserName'] = entity.createUserName;
	data['printNum'] = entity.printNum;
	data['deptId'] = entity.deptId;
	data['returnGoodsTaxAmount'] = entity.returnGoodsTaxAmount;
	data['substandard'] = entity.substandard;
	data['merchandiserName'] = entity.merchandiserName;
	data['taxAmount'] = entity.taxAmount;
	data['updatedTime'] = entity.updatedTime;
	data['receivableAmount'] = entity.receivableAmount;
	data['writeOffAmount'] = entity.writeOffAmount;
	data['tempWriteOffAmount'] = entity.tempWriteOffAmount;
	data['isCheck'] = entity.isCheck;
	return data;
}

orderSaleItemStoreCustomerFromJson(OrderSaleItemStoreCustomer data, Map<String, dynamic> json) {
	if (json['orderOweAmount'] != null) {
		data.orderOweAmount = json['orderOweAmount'] is String
				? double.tryParse(json['orderOweAmount'])
				: json['orderOweAmount'].toDouble();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? double.tryParse(json['id'])
				: json['id'].toDouble();
	}
	if (json['levelTag'] != null) {
		data.levelTag = json['levelTag'].toString();
	}
	if (json['oweAmount'] != null) {
		data.oweAmount = json['oweAmount'] is String
				? double.tryParse(json['oweAmount'])
				: json['oweAmount'].toDouble();
	}
	if (json['balance'] != null) {
		data.balance = json['balance'] is String
				? double.tryParse(json['balance'])
				: json['balance'].toDouble();
	}
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	return data;
}

Map<String, dynamic> orderSaleItemStoreCustomerToJson(OrderSaleItemStoreCustomer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderOweAmount'] = entity.orderOweAmount;
	data['id'] = entity.id;
	data['levelTag'] = entity.levelTag;
	data['oweAmount'] = entity.oweAmount;
	data['balance'] = entity.balance;
	data['customerName'] = entity.customerName;
	return data;
}
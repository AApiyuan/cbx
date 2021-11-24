import 'package:haidai_flutter_module/page/stock/model/res/order_stock_new_do.dart';
import 'package:haidai_flutter_module/model/customer_do.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/model/store_goods_base_do.dart';

orderStockNewDoFromJson(OrderStockNewDo data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
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
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['packageId'] != null) {
		data.packageId = json['packageId'] is String
				? int.tryParse(json['packageId'])
				: json['packageId'].toInt();
	}
	if (json['orderSerial'] != null) {
		data.orderSerial = json['orderSerial'].toString();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['orderType'] != null) {
		data.orderType = json['orderType'];
	}
	if (json['orderLabel'] != null) {
		data.orderLabel = json['orderLabel'] is String
				? int.tryParse(json['orderLabel'])
				: json['orderLabel'].toInt();
	}
	if (json['orderLabelName'] != null) {
		data.orderLabelName = json['orderLabelName'].toString();
	}
	if (json['addNum'] != null) {
		data.addNum = json['addNum'] is String
				? int.tryParse(json['addNum'])
				: json['addNum'].toInt();
	}
	if (json['subtractNum'] != null) {
		data.subtractNum = json['subtractNum'] is String
				? int.tryParse(json['subtractNum'])
				: json['subtractNum'].toInt();
	}
	if (json['amount'] != null) {
		data.amount = json['amount'] is String
				? int.tryParse(json['amount'])
				: json['amount'].toInt();
	}
	if (json['addAmount'] != null) {
		data.addAmount = json['addAmount'] is String
				? int.tryParse(json['addAmount'])
				: json['addAmount'].toInt();
	}
	if (json['subtractAmount'] != null) {
		data.subtractAmount = json['subtractAmount'] is String
				? int.tryParse(json['subtractAmount'])
				: json['subtractAmount'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['customerDo'] != null) {
		data.customerDo = CustomerDo().fromJson(json['customerDo']);
	}
	if (json['supplierId'] != null) {
		data.supplierId = json['supplierId'] is String
				? int.tryParse(json['supplierId'])
				: json['supplierId'].toInt();
	}
	if (json['supplierName'] != null) {
		data.supplierName = json['supplierName'] is String
				? int.tryParse(json['supplierName'])
				: json['supplierName'].toInt();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderDistributionId'] != null) {
		data.orderDistributionId = json['orderDistributionId'] is String
				? int.tryParse(json['orderDistributionId'])
				: json['orderDistributionId'].toInt();
	}
	if (json['orderTransferId'] != null) {
		data.orderTransferId = json['orderTransferId'] is String
				? int.tryParse(json['orderTransferId'])
				: json['orderTransferId'].toInt();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'];
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'];
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['canceledUserId'] != null) {
		data.canceledUserId = json['canceledUserId'] is String
				? int.tryParse(json['canceledUserId'])
				: json['canceledUserId'].toInt();
	}
	if (json['canceledUserName'] != null) {
		data.canceledUserName = json['canceledUserName'].toString();
	}
	if (json['canceledTime'] != null) {
		data.canceledTime = json['canceledTime'].toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['changeReason'] != null) {
		data.changeReason = json['changeReason'].toString();
	}
	if (json['goods'] != null) {
		data.goods = (json['goods'] as List).map((v) => OrderStockNewDoGoods().fromJson(v)).toList();
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

Map<String, dynamic> orderStockNewDoToJson(OrderStockNewDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['stockOutDeptId'] = entity.stockOutDeptId;
	data['stockOutDeptName'] = entity.stockOutDeptName;
	data['stockInDeptId'] = entity.stockInDeptId;
	data['stockInDeptName'] = entity.stockInDeptName;
	data['topDeptId'] = entity.topDeptId;
	data['packageId'] = entity.packageId;
	data['orderSerial'] = entity.orderSerial;
	data['customizeTime'] = entity.customizeTime;
	data['orderType'] = entity.orderType;
	data['orderLabel'] = entity.orderLabel;
	data['orderLabelName'] = entity.orderLabelName;
	data['addNum'] = entity.addNum;
	data['subtractNum'] = entity.subtractNum;
	data['amount'] = entity.amount;
	data['addAmount'] = entity.addAmount;
	data['subtractAmount'] = entity.subtractAmount;
	data['customerId'] = entity.customerId;
	data['customerDo'] = entity.customerDo?.toJson();
	data['supplierId'] = entity.supplierId;
	data['supplierName'] = entity.supplierName;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderDistributionId'] = entity.orderDistributionId;
	data['orderTransferId'] = entity.orderTransferId;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['canceled'] = entity.canceled;
	data['status'] = entity.status;
	data['canceledUserId'] = entity.canceledUserId;
	data['canceledUserName'] = entity.canceledUserName;
	data['canceledTime'] = entity.canceledTime;
	data['remark'] = entity.remark;
	data['changeReason'] = entity.changeReason;
	data['goods'] =  entity.goods?.map((v) => v.toJson())?.toList();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

orderStockNewDoGoodsFromJson(OrderStockNewDoGoods data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['orderStockId'] != null) {
		data.orderStockId = json['orderStockId'] is String
				? int.tryParse(json['orderStockId'])
				: json['orderStockId'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['addNum'] != null) {
		data.addNum = json['addNum'] is String
				? int.tryParse(json['addNum'])
				: json['addNum'].toInt();
	}
	if (json['subtractNum'] != null) {
		data.subtractNum = json['subtractNum'] is String
				? int.tryParse(json['subtractNum'])
				: json['subtractNum'].toInt();
	}
	if (json['substandardNum'] != null) {
		data.substandardNum = json['substandardNum'] is String
				? int.tryParse(json['substandardNum'])
				: json['substandardNum'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['storeGoodsBaseDo'] != null) {
		data.storeGoodsBaseDo = Goods().fromJson(json['storeGoodsBaseDo']);
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'];
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
	if (json['orderGoodsVoList'] != null) {
		data.orderGoodsVoList = (json['orderGoodsVoList'] as List).map((v) => SkuInfoEntity().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> orderStockNewDoGoodsToJson(OrderStockNewDoGoods entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['orderStockId'] = entity.orderStockId;
	data['deptId'] = entity.deptId;
	data['addNum'] = entity.addNum;
	data['subtractNum'] = entity.subtractNum;
	data['substandardNum'] = entity.substandardNum;
	data['goodsId'] = entity.goodsId;
	data['storeGoodsBaseDo'] = entity.storeGoodsBaseDo?.toJson();
	data['remark'] = entity.remark;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['canceled'] = entity.canceled;
	data['canceledUserId'] = entity.canceledUserId;
	data['canceledTime'] = entity.canceledTime;
	data['orderGoodsVoList'] =  entity.orderGoodsVoList?.map((v) => v.toJson())?.toList();
	return data;
}
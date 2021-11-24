import 'package:haidai_flutter_module/page/transfer/model/res/transfer_do.dart';
import 'package:haidai_flutter_module/model/customer_do.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/remark.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_action_do.dart';

transferDoFromJson(TransferDo data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['curType'] != null) {
		data.curType = json['curType'].toString();
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
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['orderSaleCustomizeTime'] != null) {
		data.orderSaleCustomizeTime = json['orderSaleCustomizeTime'].toString();
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
	if (json['customerName'] != null) {
		data.customerName = json['customerName'].toString();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	if (json['orderStockInId'] != null) {
		data.orderStockInId = json['orderStockInId'] is String
				? int.tryParse(json['orderStockInId'])
				: json['orderStockInId'].toInt();
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
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['shortageStyleNum'] != null) {
		data.shortageStyleNum = json['shortageStyleNum'] is String
				? int.tryParse(json['shortageStyleNum'])
				: json['shortageStyleNum'].toInt();
	}
	if (json['notDistributionNum'] != null) {
		data.notDistributionNum = json['notDistributionNum'] is String
				? int.tryParse(json['notDistributionNum'])
				: json['notDistributionNum'].toInt();
	}
	if (json['notDistributionStyleNum'] != null) {
		data.notDistributionStyleNum = json['notDistributionStyleNum'] is String
				? int.tryParse(json['notDistributionStyleNum'])
				: json['notDistributionStyleNum'].toInt();
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['difference'] != null) {
		data.difference = json['difference'];
	}
	if (json['differanceMore'] != null) {
		data.differanceMore = json['differanceMore'] is String
				? int.tryParse(json['differanceMore'])
				: json['differanceMore'].toInt();
	}
	if (json['differanceLess'] != null) {
		data.differanceLess = json['differanceLess'] is String
				? int.tryParse(json['differanceLess'])
				: json['differanceLess'].toInt();
	}
	if (json['orderType'] != null) {
		data.orderType = json['orderType'];
	}
	if (json['deliveryStatus'] != null) {
		data.deliveryStatus = json['deliveryStatus'];
	}
	if (json['substandard'] != null) {
		data.substandard = json['substandard'];
	}
	if (json['distribution'] != null) {
		data.distribution = json['distribution'];
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
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
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
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
	if (json['goods'] != null) {
		data.goods = (json['goods'] as List).map((v) => TransferDoGoods().fromJson(v)).toList();
	}
	if (json['remarks'] != null) {
		data.remarks = (json['remarks'] as List).map((v) => Remark().fromJson(v)).toList();
	}
	if (json['storeCustomer'] != null) {
		data.storeCustomer = CustomerDo().fromJson(json['storeCustomer']);
	}
	if (json['transferActionDo'] != null) {
		data.transferActionDo = TransferActionDo().fromJson(json['transferActionDo']);
	}
	return data;
}

Map<String, dynamic> transferDoToJson(TransferDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['topDeptId'] = entity.topDeptId;
	data['curType'] = entity.curType;
	data['stockOutDeptId'] = entity.stockOutDeptId;
	data['stockOutDeptName'] = entity.stockOutDeptName;
	data['stockInDeptId'] = entity.stockInDeptId;
	data['stockInDeptName'] = entity.stockInDeptName;
	data['orderSerial'] = entity.orderSerial;
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['orderSaleCustomizeTime'] = entity.orderSaleCustomizeTime;
	data['orderSaleId'] = entity.orderSaleId;
	data['customerId'] = entity.customerId;
	data['customerName'] = entity.customerName;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	data['orderStockInId'] = entity.orderStockInId;
	data['orderStockOutId'] = entity.orderStockOutId;
	data['stockOutNum'] = entity.stockOutNum;
	data['stockInNum'] = entity.stockInNum;
	data['applyNum'] = entity.applyNum;
	data['stockOutStyleNum'] = entity.stockOutStyleNum;
	data['stockInStyleNum'] = entity.stockInStyleNum;
	data['applyStyleNum'] = entity.applyStyleNum;
	data['shortageNum'] = entity.shortageNum;
	data['shortageStyleNum'] = entity.shortageStyleNum;
	data['notDistributionNum'] = entity.notDistributionNum;
	data['notDistributionStyleNum'] = entity.notDistributionStyleNum;
	data['status'] = entity.status;
	data['difference'] = entity.difference;
	data['differanceMore'] = entity.differanceMore;
	data['differanceLess'] = entity.differanceLess;
	data['orderType'] = entity.orderType;
	data['deliveryStatus'] = entity.deliveryStatus;
	data['substandard'] = entity.substandard;
	data['distribution'] = entity.distribution;
	data['canceled'] = entity.canceled;
	data['canceledUserId'] = entity.canceledUserId;
	data['canceledUserName'] = entity.canceledUserName;
	data['canceledTime'] = entity.canceledTime;
	data['customizeTime'] = entity.customizeTime;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['goods'] =  entity.goods?.map((v) => v.toJson())?.toList();
	data['remarks'] =  entity.remarks?.map((v) => v.toJson())?.toList();
	data['storeCustomer'] = entity.storeCustomer?.toJson();
	data['transferActionDo'] = entity.transferActionDo?.toJson();
	return data;
}

transferDoGoodsFromJson(TransferDoGoods data, Map<String, dynamic> json) {
	if (json['orderTransferId'] != null) {
		data.orderTransferId = json['orderTransferId'] is String
				? int.tryParse(json['orderTransferId'])
				: json['orderTransferId'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
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
	if (json['stockNum'] != null) {
		data.stockNum = json['stockNum'] is String
				? int.tryParse(json['stockNum'])
				: json['stockNum'].toInt();
	}
	if (json['substandardNum'] != null) {
		data.substandardNum = json['substandardNum'] is String
				? int.tryParse(json['substandardNum'])
				: json['substandardNum'].toInt();
	}
	if (json['applyNum'] != null) {
		data.applyNum = json['applyNum'] is String
				? int.tryParse(json['applyNum'])
				: json['applyNum'].toInt();
	}
	if (json['notDistributionNum'] != null) {
		data.notDistributionNum = json['notDistributionNum'] is String
				? int.tryParse(json['notDistributionNum'])
				: json['notDistributionNum'].toInt();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['differanceMore'] != null) {
		data.differanceMore = json['differanceMore'] is String
				? int.tryParse(json['differanceMore'])
				: json['differanceMore'].toInt();
	}
	if (json['differanceLess'] != null) {
		data.differanceLess = json['differanceLess'] is String
				? int.tryParse(json['differanceLess'])
				: json['differanceLess'].toInt();
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
	if (json['remarks'] != null) {
		data.remarks = (json['remarks'] as List).map((v) => Remark().fromJson(v)).toList();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['storeGoodsBaseDo'] != null) {
		data.storeGoodsBaseDo = Goods().fromJson(json['storeGoodsBaseDo']);
	}
	if (json['orderGoodsVoList'] != null) {
		data.orderGoodsVoList = (json['orderGoodsVoList'] as List).map((v) => SkuInfoEntity().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> transferDoGoodsToJson(TransferDoGoods entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderTransferId'] = entity.orderTransferId;
	data['goodsId'] = entity.goodsId;
	data['orderSaleId'] = entity.orderSaleId;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['stockOutNum'] = entity.stockOutNum;
	data['stockInNum'] = entity.stockInNum;
	data['stockNum'] = entity.stockNum;
	data['substandardNum'] = entity.substandardNum;
	data['applyNum'] = entity.applyNum;
	data['notDistributionNum'] = entity.notDistributionNum;
	data['shortageNum'] = entity.shortageNum;
	data['differanceMore'] = entity.differanceMore;
	data['differanceLess'] = entity.differanceLess;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['remarks'] =  entity.remarks?.map((v) => v.toJson())?.toList();
	data['remark'] = entity.remark;
	data['storeGoodsBaseDo'] = entity.storeGoodsBaseDo?.toJson();
	data['orderGoodsVoList'] =  entity.orderGoodsVoList?.map((v) => v.toJson())?.toList();
	return data;
}
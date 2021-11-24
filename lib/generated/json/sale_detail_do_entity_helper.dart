import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/discount_template_detail_entity.dart';

saleDetailDoEntityFromJson(SaleDetailDoEntity data, Map<String, dynamic> json) {
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
	if (json['topDeptId'] != null) {
		data.topDeptId = json['topDeptId'] is String
				? int.tryParse(json['topDeptId'])
				: json['topDeptId'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['configDistribution'] != null) {
		data.configDistribution = json['configDistribution'].toString();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['orderSaleSerial'] != null) {
		data.orderSaleSerial = json['orderSaleSerial'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
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
	if (json['customerAddress'] != null) {
		data.customerAddress = json['customerAddress'].toString();
	}
	if (json['tax'] != null) {
		data.tax = json['tax'] is String
				? int.tryParse(json['tax'])
				: json['tax'].toInt();
	}
	if (json['originalAmount'] != null) {
		data.originalAmount = json['originalAmount'] is String
				? int.tryParse(json['originalAmount'])
				: json['originalAmount'].toInt();
	}
	if (json['taxOriginalAmount'] != null) {
		data.taxOriginalAmount = json['taxOriginalAmount'] is String
				? int.tryParse(json['taxOriginalAmount'])
				: json['taxOriginalAmount'].toInt();
	}
	if (json['receivableAmount'] != null) {
		data.receivableAmount = json['receivableAmount'] is String
				? int.tryParse(json['receivableAmount'])
				: json['receivableAmount'].toInt();
	}
	if (json['taxAmount'] != null) {
		data.taxAmount = json['taxAmount'] is String
				? int.tryParse(json['taxAmount'])
				: json['taxAmount'].toInt();
	}
	if (json['discountAmount'] != null) {
		data.discountAmount = json['discountAmount'] is String
				? int.tryParse(json['discountAmount'])
				: json['discountAmount'].toInt();
	}
	if (json['taxReceivableAmount'] != null) {
		data.taxReceivableAmount = json['taxReceivableAmount'] is String
				? int.tryParse(json['taxReceivableAmount'])
				: json['taxReceivableAmount'].toInt();
	}
	if (json['checkAmount'] != null) {
		data.checkAmount = json['checkAmount'] is String
				? int.tryParse(json['checkAmount'])
				: json['checkAmount'].toInt();
	}
	if (json['balanceAmount'] != null) {
		data.balanceAmount = json['balanceAmount'] is String
				? int.tryParse(json['balanceAmount'])
				: json['balanceAmount'].toInt();
	}
	if (json['wipeOffAmount'] != null) {
		data.wipeOffAmount = json['wipeOffAmount'] is String
				? int.tryParse(json['wipeOffAmount'])
				: json['wipeOffAmount'].toInt();
	}
	if (json['deliveryNum'] != null) {
		data.deliveryNum = json['deliveryNum'] is String
				? int.tryParse(json['deliveryNum'])
				: json['deliveryNum'].toInt();
	}
	if (json['deliveryAmount'] != null) {
		data.deliveryAmount = json['deliveryAmount'] is String
				? int.tryParse(json['deliveryAmount'])
				: json['deliveryAmount'].toInt();
	}
	if (json['canceledNum'] != null) {
		data.canceledNum = json['canceledNum'] is String
				? int.tryParse(json['canceledNum'])
				: json['canceledNum'].toInt();
	}
	if (json['canceledAmount'] != null) {
		data.canceledAmount = json['canceledAmount'] is String
				? int.tryParse(json['canceledAmount'])
				: json['canceledAmount'].toInt();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['shortageAmount'] != null) {
		data.shortageAmount = json['shortageAmount'] is String
				? int.tryParse(json['shortageAmount'])
				: json['shortageAmount'].toInt();
	}
	if (json['incrementStyleNum'] != null) {
		data.incrementStyleNum = json['incrementStyleNum'] is String
				? int.tryParse(json['incrementStyleNum'])
				: json['incrementStyleNum'].toInt();
	}
	if (json['decrementStyleNum'] != null) {
		data.decrementStyleNum = json['decrementStyleNum'] is String
				? int.tryParse(json['decrementStyleNum'])
				: json['decrementStyleNum'].toInt();
	}
	if (json['incrementNum'] != null) {
		data.incrementNum = json['incrementNum'] is String
				? int.tryParse(json['incrementNum'])
				: json['incrementNum'].toInt();
	}
	if (json['decrementNum'] != null) {
		data.decrementNum = json['decrementNum'] is String
				? int.tryParse(json['decrementNum'])
				: json['decrementNum'].toInt();
	}
	if (json['incrementAmount'] != null) {
		data.incrementAmount = json['incrementAmount'] is String
				? int.tryParse(json['incrementAmount'])
				: json['incrementAmount'].toInt();
	}
	if (json['decrementAmount'] != null) {
		data.decrementAmount = json['decrementAmount'] is String
				? int.tryParse(json['decrementAmount'])
				: json['decrementAmount'].toInt();
	}
	if (json['incrementTaxAmount'] != null) {
		data.incrementTaxAmount = json['incrementTaxAmount'] is String
				? int.tryParse(json['incrementTaxAmount'])
				: json['incrementTaxAmount'].toInt();
	}
	if (json['decrementTaxAmount'] != null) {
		data.decrementTaxAmount = json['decrementTaxAmount'] is String
				? int.tryParse(json['decrementTaxAmount'])
				: json['decrementTaxAmount'].toInt();
	}
	if (json['normalSaleStyleNum'] != null) {
		data.normalSaleStyleNum = json['normalSaleStyleNum'] is String
				? int.tryParse(json['normalSaleStyleNum'])
				: json['normalSaleStyleNum'].toInt();
	}
	if (json['normalSaleNum'] != null) {
		data.normalSaleNum = json['normalSaleNum'] is String
				? int.tryParse(json['normalSaleNum'])
				: json['normalSaleNum'].toInt();
	}
	if (json['normalSaleAmount'] != null) {
		data.normalSaleAmount = json['normalSaleAmount'] is String
				? int.tryParse(json['normalSaleAmount'])
				: json['normalSaleAmount'].toInt();
	}
	if (json['normalSaleTaxAmount'] != null) {
		data.normalSaleTaxAmount = json['normalSaleTaxAmount'] is String
				? int.tryParse(json['normalSaleTaxAmount'])
				: json['normalSaleTaxAmount'].toInt();
	}
	if (json['returnGoodsStyleNum'] != null) {
		data.returnGoodsStyleNum = json['returnGoodsStyleNum'] is String
				? int.tryParse(json['returnGoodsStyleNum'])
				: json['returnGoodsStyleNum'].toInt();
	}
	if (json['returnGoodsNum'] != null) {
		data.returnGoodsNum = json['returnGoodsNum'] is String
				? int.tryParse(json['returnGoodsNum'])
				: json['returnGoodsNum'].toInt();
	}
	if (json['returnGoodsAmount'] != null) {
		data.returnGoodsAmount = json['returnGoodsAmount'] is String
				? int.tryParse(json['returnGoodsAmount'])
				: json['returnGoodsAmount'].toInt();
	}
	if (json['returnGoodsTaxAmount'] != null) {
		data.returnGoodsTaxAmount = json['returnGoodsTaxAmount'] is String
				? int.tryParse(json['returnGoodsTaxAmount'])
				: json['returnGoodsTaxAmount'].toInt();
	}
	if (json['changeBackOrderGoodsStyleNum'] != null) {
		data.changeBackOrderGoodsStyleNum = json['changeBackOrderGoodsStyleNum'] is String
				? int.tryParse(json['changeBackOrderGoodsStyleNum'])
				: json['changeBackOrderGoodsStyleNum'].toInt();
	}
	if (json['changeBackOrderGoodsNum'] != null) {
		data.changeBackOrderGoodsNum = json['changeBackOrderGoodsNum'] is String
				? int.tryParse(json['changeBackOrderGoodsNum'])
				: json['changeBackOrderGoodsNum'].toInt();
	}
	if (json['changeBackOrderGoodsAmount'] != null) {
		data.changeBackOrderGoodsAmount = json['changeBackOrderGoodsAmount'] is String
				? int.tryParse(json['changeBackOrderGoodsAmount'])
				: json['changeBackOrderGoodsAmount'].toInt();
	}
	if (json['changeBackOrderGoodsTaxAmount'] != null) {
		data.changeBackOrderGoodsTaxAmount = json['changeBackOrderGoodsTaxAmount'] is String
				? int.tryParse(json['changeBackOrderGoodsTaxAmount'])
				: json['changeBackOrderGoodsTaxAmount'].toInt();
	}
	if (json['substandard'] != null) {
		data.substandard = json['substandard'].toString();
	}
	if (json['printDistributionNum'] != null) {
		data.printDistributionNum = json['printDistributionNum'] is String
				? int.tryParse(json['printDistributionNum'])
				: json['printDistributionNum'].toInt();
	}
	if (json['distributionNum'] != null) {
		data.distributionNum = json['distributionNum'] is String
				? int.tryParse(json['distributionNum'])
				: json['distributionNum'].toInt();
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
	if (json['storeCustomer'] != null) {
		data.storeCustomer = SaleDetailDoStoreCustomer().fromJson(json['storeCustomer']);
	}
	if (json['printNum'] != null) {
		data.printNum = json['printNum'] is String
				? int.tryParse(json['printNum'])
				: json['printNum'].toInt();
	}
	if (json['remarkList'] != null) {
		data.remarkList = (json['remarkList'] as List).map((v) => SaleDetailDoRemarkList().fromJson(v)).toList();
	}
	if (json['saleGoodsList'] != null) {
		data.saleGoodsList = (json['saleGoodsList'] as List).map((v) => SaleDetailDoSaleGoodsList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> saleDetailDoEntityToJson(SaleDetailDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['topDeptId'] = entity.topDeptId;
	data['deptId'] = entity.deptId;
	data['configDistribution'] = entity.configDistribution;
	data['warehouseId'] = entity.warehouseId;
	data['orderSaleSerial'] = entity.orderSaleSerial;
	data['type'] = entity.type;
	data['customizeTime'] = entity.customizeTime;
	data['createUserId'] = entity.createUserId;
	data['merchandiserId'] = entity.merchandiserId;
	data['customerId'] = entity.customerId;
	data['customerAddress'] = entity.customerAddress;
	data['tax'] = entity.tax;
	data['originalAmount'] = entity.originalAmount;
	data['taxOriginalAmount'] = entity.taxOriginalAmount;
	data['receivableAmount'] = entity.receivableAmount;
	data['taxAmount'] = entity.taxAmount;
	data['discountAmount'] = entity.discountAmount;
	data['taxReceivableAmount'] = entity.taxReceivableAmount;
	data['checkAmount'] = entity.checkAmount;
	data['balanceAmount'] = entity.balanceAmount;
	data['wipeOffAmount'] = entity.wipeOffAmount;
	data['deliveryNum'] = entity.deliveryNum;
	data['deliveryAmount'] = entity.deliveryAmount;
	data['canceledNum'] = entity.canceledNum;
	data['canceledAmount'] = entity.canceledAmount;
	data['shortageNum'] = entity.shortageNum;
	data['shortageAmount'] = entity.shortageAmount;
	data['incrementStyleNum'] = entity.incrementStyleNum;
	data['decrementStyleNum'] = entity.decrementStyleNum;
	data['incrementNum'] = entity.incrementNum;
	data['decrementNum'] = entity.decrementNum;
	data['incrementAmount'] = entity.incrementAmount;
	data['decrementAmount'] = entity.decrementAmount;
	data['incrementTaxAmount'] = entity.incrementTaxAmount;
	data['decrementTaxAmount'] = entity.decrementTaxAmount;
	data['normalSaleStyleNum'] = entity.normalSaleStyleNum;
	data['normalSaleNum'] = entity.normalSaleNum;
	data['normalSaleAmount'] = entity.normalSaleAmount;
	data['normalSaleTaxAmount'] = entity.normalSaleTaxAmount;
	data['returnGoodsStyleNum'] = entity.returnGoodsStyleNum;
	data['returnGoodsNum'] = entity.returnGoodsNum;
	data['returnGoodsAmount'] = entity.returnGoodsAmount;
	data['returnGoodsTaxAmount'] = entity.returnGoodsTaxAmount;
	data['changeBackOrderGoodsStyleNum'] = entity.changeBackOrderGoodsStyleNum;
	data['changeBackOrderGoodsNum'] = entity.changeBackOrderGoodsNum;
	data['changeBackOrderGoodsAmount'] = entity.changeBackOrderGoodsAmount;
	data['changeBackOrderGoodsTaxAmount'] = entity.changeBackOrderGoodsTaxAmount;
	data['substandard'] = entity.substandard;
	data['printDistributionNum'] = entity.printDistributionNum;
	data['distributionNum'] = entity.distributionNum;
	data['status'] = entity.status;
	data['canceled'] = entity.canceled;
	data['createUserName'] = entity.createUserName;
	data['merchandiserName'] = entity.merchandiserName;
	data['storeCustomer'] = entity.storeCustomer?.toJson();
	data['printNum'] = entity.printNum;
	data['remarkList'] =  entity.remarkList?.map((v) => v.toJson())?.toList();
	data['saleGoodsList'] =  entity.saleGoodsList?.map((v) => v.toJson())?.toList();
	return data;
}

saleDetailDoStoreCustomerFromJson(SaleDetailDoStoreCustomer data, Map<String, dynamic> json) {
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

Map<String, dynamic> saleDetailDoStoreCustomerToJson(SaleDetailDoStoreCustomer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['customerName'] = entity.customerName;
	data['levelTag'] = entity.levelTag;
	data['balance'] = entity.balance;
	data['oweAmount'] = entity.oweAmount;
	data['orderOweAmount'] = entity.orderOweAmount;
	return data;
}

saleDetailDoRemarkListFromJson(SaleDetailDoRemarkList data, Map<String, dynamic> json) {
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

Map<String, dynamic> saleDetailDoRemarkListToJson(SaleDetailDoRemarkList entity) {
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

saleDetailDoSaleGoodsListFromJson(SaleDetailDoSaleGoodsList data, Map<String, dynamic> json) {
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
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['relationOrderSaleId'] != null) {
		data.relationOrderSaleId = json['relationOrderSaleId'] is String
				? int.tryParse(json['relationOrderSaleId'])
				: json['relationOrderSaleId'].toInt();
	}
	if (json['relationOrderSaleGoodsId'] != null) {
		data.relationOrderSaleGoodsId = json['relationOrderSaleGoodsId'] is String
				? int.tryParse(json['relationOrderSaleGoodsId'])
				: json['relationOrderSaleGoodsId'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['deliveryNum'] != null) {
		data.deliveryNum = json['deliveryNum'] is String
				? int.tryParse(json['deliveryNum'])
				: json['deliveryNum'].toInt();
	}
	if (json['canceledNum'] != null) {
		data.canceledNum = json['canceledNum'] is String
				? int.tryParse(json['canceledNum'])
				: json['canceledNum'].toInt();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['salePrice'] != null) {
		data.salePrice = json['salePrice'] is String
				? int.tryParse(json['salePrice'])
				: json['salePrice'].toInt();
	}
	if (json['taxSalePrice'] != null) {
		data.taxSalePrice = json['taxSalePrice'] is String
				? int.tryParse(json['taxSalePrice'])
				: json['taxSalePrice'].toInt();
	}
	if (json['price'] != null) {
		data.price = json['price'] is String
				? int.tryParse(json['price'])
				: json['price'].toInt();
	}
	if (json['taxPrice'] != null) {
		data.taxPrice = json['taxPrice'] is String
				? int.tryParse(json['taxPrice'])
				: json['taxPrice'].toInt();
	}
	if (json['originalAmount'] != null) {
		data.originalAmount = json['originalAmount'] is String
				? int.tryParse(json['originalAmount'])
				: json['originalAmount'].toInt();
	}
	if (json['taxOriginalAmount'] != null) {
		data.taxOriginalAmount = json['taxOriginalAmount'] is String
				? int.tryParse(json['taxOriginalAmount'])
				: json['taxOriginalAmount'].toInt();
	}
	if (json['receivableAmount'] != null) {
		data.receivableAmount = json['receivableAmount'] is String
				? int.tryParse(json['receivableAmount'])
				: json['receivableAmount'].toInt();
	}
	if (json['taxAmount'] != null) {
		data.taxAmount = json['taxAmount'] is String
				? int.tryParse(json['taxAmount'])
				: json['taxAmount'].toInt();
	}
	if (json['discountAmount'] != null) {
		data.discountAmount = json['discountAmount'] is String
				? int.tryParse(json['discountAmount'])
				: json['discountAmount'].toInt();
	}
	if (json['taxReceivableAmount'] != null) {
		data.taxReceivableAmount = json['taxReceivableAmount'] is String
				? int.tryParse(json['taxReceivableAmount'])
				: json['taxReceivableAmount'].toInt();
	}
	if (json['discountType'] != null) {
		data.discountType = json['discountType'].toString();
	}
	if (json['discount'] != null) {
		data.discount = json['discount'] is String
				? int.tryParse(json['discount'])
				: json['discount'].toInt();
	}
	if (json['discountTemplateId'] != null) {
		data.discountTemplateId = json['discountTemplateId'] is String
				? int.tryParse(json['discountTemplateId'])
				: json['discountTemplateId'].toInt();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['storeGoods'] != null) {
		data.storeGoods = SaleDetailDoSaleGoodsListStoreGoods().fromJson(json['storeGoods']);
	}
	if (json['discountTemplateDetail'] != null) {
		data.discountTemplateDetail = DiscountTemplateDetailEntity().fromJson(json['discountTemplateDetail']);
	}
	if (json['orderGoodsVoList'] != null) {
		data.orderGoodsVoList = (json['orderGoodsVoList'] as List).map((v) => SkuInfoEntity().fromJson(v)).toList();
	}
	if (json['saleGoodsSku'] != null) {
		data.saleGoodsSku = (json['saleGoodsSku'] as List).map((v) => SaleDetailDoSaleGoodsListSaleGoodsSku().fromJson(v)).toList();
	}
	if (json['relationOrderSaleCustomizeTime'] != null) {
		data.relationOrderSaleCustomizeTime = json['relationOrderSaleCustomizeTime'].toString();
	}
	if (json['relationOrderSaleSerial'] != null) {
		data.relationOrderSaleSerial = json['relationOrderSaleSerial'].toString();
	}
	return data;
}

Map<String, dynamic> saleDetailDoSaleGoodsListToJson(SaleDetailDoSaleGoodsList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['customerId'] = entity.customerId;
	data['orderSaleId'] = entity.orderSaleId;
	data['customizeTime'] = entity.customizeTime;
	data['type'] = entity.type;
	data['relationOrderSaleId'] = entity.relationOrderSaleId;
	data['relationOrderSaleGoodsId'] = entity.relationOrderSaleGoodsId;
	data['goodsId'] = entity.goodsId;
	data['goodsSerial'] = entity.goodsSerial;
	data['goodsNum'] = entity.goodsNum;
	data['deliveryNum'] = entity.deliveryNum;
	data['canceledNum'] = entity.canceledNum;
	data['shortageNum'] = entity.shortageNum;
	data['salePrice'] = entity.salePrice;
	data['taxSalePrice'] = entity.taxSalePrice;
	data['price'] = entity.price;
	data['taxPrice'] = entity.taxPrice;
	data['originalAmount'] = entity.originalAmount;
	data['taxOriginalAmount'] = entity.taxOriginalAmount;
	data['receivableAmount'] = entity.receivableAmount;
	data['taxAmount'] = entity.taxAmount;
	data['discountAmount'] = entity.discountAmount;
	data['taxReceivableAmount'] = entity.taxReceivableAmount;
	data['discountType'] = entity.discountType;
	data['discount'] = entity.discount;
	data['discountTemplateId'] = entity.discountTemplateId;
	data['remark'] = entity.remark;
	data['storeGoods'] = entity.storeGoods?.toJson();
	data['discountTemplateDetail'] = entity.discountTemplateDetail?.toJson();
	data['orderGoodsVoList'] =  entity.orderGoodsVoList?.map((v) => v.toJson())?.toList();
	data['saleGoodsSku'] =  entity.saleGoodsSku?.map((v) => v.toJson())?.toList();
	data['relationOrderSaleCustomizeTime'] = entity.relationOrderSaleCustomizeTime;
	data['relationOrderSaleSerial'] = entity.relationOrderSaleSerial;
	return data;
}

saleDetailDoSaleGoodsListStoreGoodsFromJson(SaleDetailDoSaleGoodsListStoreGoods data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['goodsSerial'] != null) {
		data.goodsSerial = json['goodsSerial'].toString();
	}
	if (json['goodsNameSerial'] != null) {
		data.goodsNameSerial = json['goodsNameSerial'].toString();
	}
	if (json['imgPath'] != null) {
		data.imgPath = json['imgPath'].toString();
	}
	if (json['cover'] != null) {
		data.cover = json['cover'].toString();
	}
	if (json['goodsName'] != null) {
		data.goodsName = json['goodsName'].toString();
	}
	if (json['goods'] != null) {
		data.goods = Goods().fromJson(json['goods']);
	}
	return data;
}

Map<String, dynamic> saleDetailDoSaleGoodsListStoreGoodsToJson(SaleDetailDoSaleGoodsListStoreGoods entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['goodsSerial'] = entity.goodsSerial;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['imgPath'] = entity.imgPath;
	data['cover'] = entity.cover;
	data['goodsName'] = entity.goodsName;
	data['goods'] = entity.goods?.toJson();
	return data;
}

saleDetailDoSaleGoodsListOrderGoodsVoListFromJson(SaleDetailDoSaleGoodsListOrderGoodsVoList data, Map<String, dynamic> json) {
	if (json['goodsColor'] != null) {
		data.goodsColor = SaleDetailDoSaleGoodsListOrderGoodsVoListGoodsColor().fromJson(json['goodsColor']);
	}
	if (json['sizes'] != null) {
		data.sizes = (json['sizes'] as List).map((v) => SaleDetailDoSaleGoodsListOrderGoodsVoListSizes().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> saleDetailDoSaleGoodsListOrderGoodsVoListToJson(SaleDetailDoSaleGoodsListOrderGoodsVoList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsColor'] = entity.goodsColor?.toJson();
	data['sizes'] =  entity.sizes?.map((v) => v.toJson())?.toList();
	return data;
}

saleDetailDoSaleGoodsListOrderGoodsVoListGoodsColorFromJson(SaleDetailDoSaleGoodsListOrderGoodsVoListGoodsColor data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	return data;
}

Map<String, dynamic> saleDetailDoSaleGoodsListOrderGoodsVoListGoodsColorToJson(SaleDetailDoSaleGoodsListOrderGoodsVoListGoodsColor entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	return data;
}

saleDetailDoSaleGoodsListOrderGoodsVoListSizesFromJson(SaleDetailDoSaleGoodsListOrderGoodsVoListSizes data, Map<String, dynamic> json) {
	if (json['goodsSize'] != null) {
		data.goodsSize = SaleDetailDoSaleGoodsListOrderGoodsVoListSizesGoodsSize().fromJson(json['goodsSize']);
	}
	if (json['data'] != null) {
		data.data = SaleDetailDoSaleGoodsListOrderGoodsVoListSizesData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> saleDetailDoSaleGoodsListOrderGoodsVoListSizesToJson(SaleDetailDoSaleGoodsListOrderGoodsVoListSizes entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsSize'] = entity.goodsSize?.toJson();
	data['data'] = entity.data?.toJson();
	return data;
}

saleDetailDoSaleGoodsListOrderGoodsVoListSizesGoodsSizeFromJson(SaleDetailDoSaleGoodsListOrderGoodsVoListSizesGoodsSize data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	return data;
}

Map<String, dynamic> saleDetailDoSaleGoodsListOrderGoodsVoListSizesGoodsSizeToJson(SaleDetailDoSaleGoodsListOrderGoodsVoListSizesGoodsSize entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['code'] = entity.code;
	data['sort'] = entity.sort;
	return data;
}

saleDetailDoSaleGoodsListOrderGoodsVoListSizesDataFromJson(SaleDetailDoSaleGoodsListOrderGoodsVoListSizesData data, Map<String, dynamic> json) {
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
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['skuId'] != null) {
		data.skuId = json['skuId'] is String
				? int.tryParse(json['skuId'])
				: json['skuId'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['deliveryNum'] != null) {
		data.deliveryNum = json['deliveryNum'] is String
				? int.tryParse(json['deliveryNum'])
				: json['deliveryNum'].toInt();
	}
	if (json['distributionNum'] != null) {
		data.distributionNum = json['distributionNum'] is String
				? int.tryParse(json['distributionNum'])
				: json['distributionNum'].toInt();
	}
	if (json['canceledNum'] != null) {
		data.canceledNum = json['canceledNum'] is String
				? int.tryParse(json['canceledNum'])
				: json['canceledNum'].toInt();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['salePrice'] != null) {
		data.salePrice = json['salePrice'] is String
				? int.tryParse(json['salePrice'])
				: json['salePrice'].toInt();
	}
	if (json['taxSalePrice'] != null) {
		data.taxSalePrice = json['taxSalePrice'] is String
				? int.tryParse(json['taxSalePrice'])
				: json['taxSalePrice'].toInt();
	}
	if (json['price'] != null) {
		data.price = json['price'] is String
				? int.tryParse(json['price'])
				: json['price'].toInt();
	}
	if (json['taxPrice'] != null) {
		data.taxPrice = json['taxPrice'] is String
				? int.tryParse(json['taxPrice'])
				: json['taxPrice'].toInt();
	}
	if (json['originalAmount'] != null) {
		data.originalAmount = json['originalAmount'] is String
				? int.tryParse(json['originalAmount'])
				: json['originalAmount'].toInt();
	}
	if (json['taxOriginalAmount'] != null) {
		data.taxOriginalAmount = json['taxOriginalAmount'] is String
				? int.tryParse(json['taxOriginalAmount'])
				: json['taxOriginalAmount'].toInt();
	}
	if (json['receivableAmount'] != null) {
		data.receivableAmount = json['receivableAmount'] is String
				? int.tryParse(json['receivableAmount'])
				: json['receivableAmount'].toInt();
	}
	if (json['taxAmount'] != null) {
		data.taxAmount = json['taxAmount'] is String
				? int.tryParse(json['taxAmount'])
				: json['taxAmount'].toInt();
	}
	if (json['discountAmount'] != null) {
		data.discountAmount = json['discountAmount'] is String
				? int.tryParse(json['discountAmount'])
				: json['discountAmount'].toInt();
	}
	if (json['taxReceivableAmount'] != null) {
		data.taxReceivableAmount = json['taxReceivableAmount'] is String
				? int.tryParse(json['taxReceivableAmount'])
				: json['taxReceivableAmount'].toInt();
	}
	return data;
}

Map<String, dynamic> saleDetailDoSaleGoodsListOrderGoodsVoListSizesDataToJson(SaleDetailDoSaleGoodsListOrderGoodsVoListSizesData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['customerId'] = entity.customerId;
	data['orderSaleId'] = entity.orderSaleId;
	data['customizeTime'] = entity.customizeTime;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['type'] = entity.type;
	data['goodsId'] = entity.goodsId;
	data['skuId'] = entity.skuId;
	data['goodsNum'] = entity.goodsNum;
	data['deliveryNum'] = entity.deliveryNum;
	data['distributionNum'] = entity.distributionNum;
	data['canceledNum'] = entity.canceledNum;
	data['shortageNum'] = entity.shortageNum;
	data['salePrice'] = entity.salePrice;
	data['taxSalePrice'] = entity.taxSalePrice;
	data['price'] = entity.price;
	data['taxPrice'] = entity.taxPrice;
	data['originalAmount'] = entity.originalAmount;
	data['taxOriginalAmount'] = entity.taxOriginalAmount;
	data['receivableAmount'] = entity.receivableAmount;
	data['taxAmount'] = entity.taxAmount;
	data['discountAmount'] = entity.discountAmount;
	data['taxReceivableAmount'] = entity.taxReceivableAmount;
	return data;
}

saleDetailDoSaleGoodsListSaleGoodsSkuFromJson(SaleDetailDoSaleGoodsListSaleGoodsSku data, Map<String, dynamic> json) {
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
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['orderSaleId'] != null) {
		data.orderSaleId = json['orderSaleId'] is String
				? int.tryParse(json['orderSaleId'])
				: json['orderSaleId'].toInt();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['orderSaleGoodsId'] != null) {
		data.orderSaleGoodsId = json['orderSaleGoodsId'] is String
				? int.tryParse(json['orderSaleGoodsId'])
				: json['orderSaleGoodsId'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['skuId'] != null) {
		data.skuId = json['skuId'] is String
				? int.tryParse(json['skuId'])
				: json['skuId'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['deliveryNum'] != null) {
		data.deliveryNum = json['deliveryNum'] is String
				? int.tryParse(json['deliveryNum'])
				: json['deliveryNum'].toInt();
	}
	if (json['distributionNum'] != null) {
		data.distributionNum = json['distributionNum'] is String
				? int.tryParse(json['distributionNum'])
				: json['distributionNum'].toInt();
	}
	if (json['canceledNum'] != null) {
		data.canceledNum = json['canceledNum'] is String
				? int.tryParse(json['canceledNum'])
				: json['canceledNum'].toInt();
	}
	if (json['shortageNum'] != null) {
		data.shortageNum = json['shortageNum'] is String
				? int.tryParse(json['shortageNum'])
				: json['shortageNum'].toInt();
	}
	if (json['salePrice'] != null) {
		data.salePrice = json['salePrice'] is String
				? int.tryParse(json['salePrice'])
				: json['salePrice'].toInt();
	}
	if (json['taxSalePrice'] != null) {
		data.taxSalePrice = json['taxSalePrice'] is String
				? int.tryParse(json['taxSalePrice'])
				: json['taxSalePrice'].toInt();
	}
	if (json['price'] != null) {
		data.price = json['price'] is String
				? int.tryParse(json['price'])
				: json['price'].toInt();
	}
	if (json['taxPrice'] != null) {
		data.taxPrice = json['taxPrice'] is String
				? int.tryParse(json['taxPrice'])
				: json['taxPrice'].toInt();
	}
	if (json['originalAmount'] != null) {
		data.originalAmount = json['originalAmount'] is String
				? int.tryParse(json['originalAmount'])
				: json['originalAmount'].toInt();
	}
	if (json['taxOriginalAmount'] != null) {
		data.taxOriginalAmount = json['taxOriginalAmount'] is String
				? int.tryParse(json['taxOriginalAmount'])
				: json['taxOriginalAmount'].toInt();
	}
	if (json['receivableAmount'] != null) {
		data.receivableAmount = json['receivableAmount'] is String
				? int.tryParse(json['receivableAmount'])
				: json['receivableAmount'].toInt();
	}
	if (json['taxAmount'] != null) {
		data.taxAmount = json['taxAmount'] is String
				? int.tryParse(json['taxAmount'])
				: json['taxAmount'].toInt();
	}
	if (json['discountAmount'] != null) {
		data.discountAmount = json['discountAmount'] is String
				? int.tryParse(json['discountAmount'])
				: json['discountAmount'].toInt();
	}
	if (json['taxReceivableAmount'] != null) {
		data.taxReceivableAmount = json['taxReceivableAmount'] is String
				? int.tryParse(json['taxReceivableAmount'])
				: json['taxReceivableAmount'].toInt();
	}
	return data;
}

Map<String, dynamic> saleDetailDoSaleGoodsListSaleGoodsSkuToJson(SaleDetailDoSaleGoodsListSaleGoodsSku entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['customerId'] = entity.customerId;
	data['orderSaleId'] = entity.orderSaleId;
	data['customizeTime'] = entity.customizeTime;
	data['orderSaleGoodsId'] = entity.orderSaleGoodsId;
	data['type'] = entity.type;
	data['goodsId'] = entity.goodsId;
	data['skuId'] = entity.skuId;
	data['goodsNum'] = entity.goodsNum;
	data['deliveryNum'] = entity.deliveryNum;
	data['distributionNum'] = entity.distributionNum;
	data['canceledNum'] = entity.canceledNum;
	data['shortageNum'] = entity.shortageNum;
	data['salePrice'] = entity.salePrice;
	data['taxSalePrice'] = entity.taxSalePrice;
	data['price'] = entity.price;
	data['taxPrice'] = entity.taxPrice;
	data['originalAmount'] = entity.originalAmount;
	data['taxOriginalAmount'] = entity.taxOriginalAmount;
	data['receivableAmount'] = entity.receivableAmount;
	data['taxAmount'] = entity.taxAmount;
	data['discountAmount'] = entity.discountAmount;
	data['taxReceivableAmount'] = entity.taxReceivableAmount;
	return data;
}
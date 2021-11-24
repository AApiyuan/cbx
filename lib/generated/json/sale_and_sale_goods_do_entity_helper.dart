import 'package:haidai_flutter_module/page/goods/model/sale_and_sale_goods_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';

saleAndSaleGoodsDoEntityFromJson(SaleAndSaleGoodsDoEntity data, Map<String, dynamic> json) {
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
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['saleGoodsList'] != null) {
		data.saleGoodsList = (json['saleGoodsList'] as List).map((v) => SaleDetailDoSaleGoodsList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> saleAndSaleGoodsDoEntityToJson(SaleAndSaleGoodsDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['topDeptId'] = entity.topDeptId;
	data['deptId'] = entity.deptId;
	data['configDistribution'] = entity.configDistribution;
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
	data['status'] = entity.status;
	data['canceled'] = entity.canceled;
	data['saleGoodsList'] =  entity.saleGoodsList?.map((v) => v.toJson())?.toList();
	return data;
}
import 'package:haidai_flutter_module/model/rep/store_goods_sku_req_entity.dart';

storeGoodsSkuReqEntityFromJson(StoreGoodsSkuReqEntity data, Map<String, dynamic> json) {
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['returnGoodsPrice'] != null) {
		data.returnGoodsPrice = json['returnGoodsPrice'];
	}
	if (json['returnStock'] != null) {
		data.returnStock = json['returnStock'];
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['returnCustomerPrice'] != null) {
		data.returnCustomerPrice = json['returnCustomerPrice'];
	}
	if (json['returnCustomerOweNum'] != null) {
		data.returnCustomerOweNum = json['returnCustomerOweNum'];
	}
	if (json['returnCustomerDeliveryNum'] != null) {
		data.returnCustomerDeliveryNum = json['returnCustomerDeliveryNum'];
	}
	return data;
}

Map<String, dynamic> storeGoodsSkuReqEntityToJson(StoreGoodsSkuReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['goodsId'] = entity.goodsId;
	data['deptId'] = entity.deptId;
	data['returnGoodsPrice'] = entity.returnGoodsPrice;
	data['returnStock'] = entity.returnStock;
	data['customerId'] = entity.customerId;
	data['returnCustomerPrice'] = entity.returnCustomerPrice;
	data['returnCustomerOweNum'] = entity.returnCustomerOweNum;
	data['returnCustomerDeliveryNum'] = entity.returnCustomerDeliveryNum;
	return data;
}
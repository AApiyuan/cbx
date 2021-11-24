import 'package:haidai_flutter_module/page/goods/model/req/sale_goods_sku_distribution_req_entity.dart';

saleGoodsSkuDistributionReqEntityFromJson(SaleGoodsSkuDistributionReqEntity data, Map<String, dynamic> json) {
	if (json['orderSaleGoodsIds'] != null) {
		data.orderSaleGoodsIds = (json['orderSaleGoodsIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['orderDeliveryId'] != null) {
		data.orderDeliveryId = json['orderDeliveryId'] is String
				? int.tryParse(json['orderDeliveryId'])
				: json['orderDeliveryId'].toInt();
	}
	return data;
}

Map<String, dynamic> saleGoodsSkuDistributionReqEntityToJson(SaleGoodsSkuDistributionReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderSaleGoodsIds'] = entity.orderSaleGoodsIds;
	data['status'] = entity.status;
	data['warehouseId'] = entity.warehouseId;
	data['orderDeliveryId'] = entity.orderDeliveryId;
	return data;
}
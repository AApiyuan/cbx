import 'package:haidai_flutter_module/model/rep/inventory_goods_sku_req_entity.dart';

inventoryGoodsSkuReqEntityFromJson(InventoryGoodsSkuReqEntity data, Map<String, dynamic> json) {
	if (json['orderInventoryId'] != null) {
		data.orderInventoryId = json['orderInventoryId'] is String
				? int.tryParse(json['orderInventoryId'])
				: json['orderInventoryId'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['getAllSku'] != null) {
		data.getAllSku = json['getAllSku'];
	}
	return data;
}

Map<String, dynamic> inventoryGoodsSkuReqEntityToJson(InventoryGoodsSkuReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderInventoryId'] = entity.orderInventoryId;
	data['goodsId'] = entity.goodsId;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['getAllSku'] = entity.getAllSku;
	return data;
}
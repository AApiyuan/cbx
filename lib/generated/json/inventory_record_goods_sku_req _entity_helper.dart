import 'package:haidai_flutter_module/model/rep/inventory_record_goods_sku_req _entity.dart';

inventoryRecordGoodsSkuReqFromJson(InventoryRecordGoodsSkuReq data, Map<String, dynamic> json) {
	if (json['orderInventoryRecordId'] != null) {
		data.orderInventoryRecordId = json['orderInventoryRecordId'] is String
				? int.tryParse(json['orderInventoryRecordId'])
				: json['orderInventoryRecordId'].toInt();
	}
	if (json['goodsId'] != null) {
		data.goodsId = json['goodsId'] is String
				? int.tryParse(json['goodsId'])
				: json['goodsId'].toInt();
	}
	if (json['getAllSku'] != null) {
		data.getAllSku = json['getAllSku'];
	}
	return data;
}

Map<String, dynamic> inventoryRecordGoodsSkuReqToJson(InventoryRecordGoodsSkuReq entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderInventoryRecordId'] = entity.orderInventoryRecordId;
	data['goodsId'] = entity.goodsId;
	data['getAllSku'] = entity.getAllSku;
	return data;
}
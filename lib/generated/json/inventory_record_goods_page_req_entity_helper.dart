import 'package:haidai_flutter_module/model/rep/inventory_record_goods_page_req_entity.dart';

inventoryRecordGoodsPageReqEntityFromJson(InventoryRecordGoodsPageReqEntity data, Map<String, dynamic> json) {
	if (json['inventoryRecordId'] != null) {
		data.inventoryRecordId = json['inventoryRecordId'] is String
				? int.tryParse(json['inventoryRecordId'])
				: json['inventoryRecordId'].toInt();
	}
	if (json['goodsNameSerial'] != null) {
		data.goodsNameSerial = json['goodsNameSerial'].toString();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	return data;
}

Map<String, dynamic> inventoryRecordGoodsPageReqEntityToJson(InventoryRecordGoodsPageReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['inventoryRecordId'] = entity.inventoryRecordId;
	data['goodsNameSerial'] = entity.goodsNameSerial;
	data['orderGoodsType'] = entity.orderGoodsType;
	return data;
}
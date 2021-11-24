import 'package:haidai_flutter_module/model/checkCenter/inventory_record_item_do_entity.dart';

inventoryRecordItemDoEntityFromJson(InventoryRecordItemDoEntity data, Map<String, dynamic> json) {
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
	if (json['orderInventoryId'] != null) {
		data.orderInventoryId = json['orderInventoryId'] is String
				? int.tryParse(json['orderInventoryId'])
				: json['orderInventoryId'].toInt();
	}
	if (json['recordImg'] != null) {
		data.recordImg = json['recordImg'].toString();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	if (json['goodsStyleNum'] != null) {
		data.goodsStyleNum = json['goodsStyleNum'] is String
				? int.tryParse(json['goodsStyleNum'])
				: json['goodsStyleNum'].toInt();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createdTime'] != null) {
		data.createdTime = json['createdTime'].toString();
	}
	return data;
}

Map<String, dynamic> inventoryRecordItemDoEntityToJson(InventoryRecordItemDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['orderInventoryId'] = entity.orderInventoryId;
	data['recordImg'] = entity.recordImg;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['goodsNum'] = entity.goodsNum;
	data['goodsStyleNum'] = entity.goodsStyleNum;
	data['canceled'] = entity.canceled;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	return data;
}
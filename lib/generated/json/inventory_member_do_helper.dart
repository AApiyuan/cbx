import 'package:haidai_flutter_module/model/checkCenter/inventory_member_do.dart';

inventoryMemberDoFromJson(InventoryMemberDo data, Map<String, dynamic> json) {
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['userName'] != null) {
		data.userName = json['userName'].toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
	}
	if (json['goodsStyleNum'] != null) {
		data.goodsStyleNum = json['goodsStyleNum'] is String
				? int.tryParse(json['goodsStyleNum'])
				: json['goodsStyleNum'].toInt();
	}
	if (json['goodsNum'] != null) {
		data.goodsNum = json['goodsNum'] is String
				? int.tryParse(json['goodsNum'])
				: json['goodsNum'].toInt();
	}
	return data;
}

Map<String, dynamic> inventoryMemberDoToJson(InventoryMemberDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderGoodsType'] = entity.orderGoodsType;
	data['userName'] = entity.userName;
	data['userId'] = entity.userId;
	data['goodsStyleNum'] = entity.goodsStyleNum;
	data['goodsNum'] = entity.goodsNum;
	return data;
}
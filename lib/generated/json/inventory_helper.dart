import 'package:haidai_flutter_module/model/inventory.dart';

inventoryFromJson(Inventory data, Map<String, dynamic> json) {
	if (json['orderSerial'] != null) {
		data.orderSerial = json['orderSerial'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'];
	}
	if (json['normalInventoryMembers'] != null) {
		data.normalInventoryMembers = (json['normalInventoryMembers'] as List).map((v) => InventoryNormalInventoryMember().fromJson(v)).toList();
	}
	if (json['substandardInventoryMembers'] != null) {
		data.substandardInventoryMembers = (json['substandardInventoryMembers'] as List).map((v) => InventorySubstandardInventoryMember().fromJson(v)).toList();
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
	return data;
}

Map<String, dynamic> inventoryToJson(Inventory entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderSerial'] = entity.orderSerial;
	data['status'] = entity.status;
	data['normalInventoryMembers'] =  entity.normalInventoryMembers?.map((v) => v.toJson())?.toList();
	data['substandardInventoryMembers'] =  entity.substandardInventoryMembers?.map((v) => v.toJson())?.toList();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

inventoryNormalInventoryMemberFromJson(InventoryNormalInventoryMember data, Map<String, dynamic> json) {
	if (json['orderInventoryId'] != null) {
		data.orderInventoryId = json['orderInventoryId'] is String
				? int.tryParse(json['orderInventoryId'])
				: json['orderInventoryId'].toInt();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'];
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['times'] != null) {
		data.times = json['times'] is String
				? int.tryParse(json['times'])
				: json['times'].toInt();
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
	return data;
}

Map<String, dynamic> inventoryNormalInventoryMemberToJson(InventoryNormalInventoryMember entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderInventoryId'] = entity.orderInventoryId;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['name'] = entity.name;
	data['times'] = entity.times;
	data['goodsStyleNum'] = entity.goodsStyleNum;
	data['goodsNum'] = entity.goodsNum;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}

inventorySubstandardInventoryMemberFromJson(InventorySubstandardInventoryMember data, Map<String, dynamic> json) {
	if (json['orderInventoryId'] != null) {
		data.orderInventoryId = json['orderInventoryId'] is String
				? int.tryParse(json['orderInventoryId'])
				: json['orderInventoryId'].toInt();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'];
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['times'] != null) {
		data.times = json['times'] is String
				? int.tryParse(json['times'])
				: json['times'].toInt();
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
	return data;
}

Map<String, dynamic> inventorySubstandardInventoryMemberToJson(InventorySubstandardInventoryMember entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderInventoryId'] = entity.orderInventoryId;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['name'] = entity.name;
	data['times'] = entity.times;
	data['goodsStyleNum'] = entity.goodsStyleNum;
	data['goodsNum'] = entity.goodsNum;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}
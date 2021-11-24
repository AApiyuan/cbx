import 'package:haidai_flutter_module/model/checkCenter/inventory_do_entity.dart';

inventoryDoEntityFromJson(InventoryDoEntity data, Map<String, dynamic> json) {
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
		data.createdBy = json['createdBy'];
	}
	if (json['updatedBy'] != null) {
		data.updatedBy = json['updatedBy'];
	}
	if (json['createdByName'] != null) {
		data.createdByName = json['createdByName'];
	}
	if (json['updatedByName'] != null) {
		data.updatedByName = json['updatedByName'];
	}
	if (json['orderSerial'] != null) {
		data.orderSerial = json['orderSerial'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['normalInventoryMembers'] != null) {
		data.normalInventoryMembers = (json['normalInventoryMembers'] as List).map((v) => InventoryDoNormalInventoryMember().fromJson(v)).toList();
	}
	if (json['substandardInventoryMembers'] != null) {
		data.substandardInventoryMembers = (json['substandardInventoryMembers'] as List).map((v) => InventoryDoSubstandardInventoryMember().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> inventoryDoEntityToJson(InventoryDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	data['orderSerial'] = entity.orderSerial;
	data['status'] = entity.status;
	data['normalInventoryMembers'] =  entity.normalInventoryMembers?.map((v) => v.toJson())?.toList();
	data['substandardInventoryMembers'] =  entity.substandardInventoryMembers?.map((v) => v.toJson())?.toList();
	return data;
}

inventoryDoNormalInventoryMemberFromJson(InventoryDoNormalInventoryMember data, Map<String, dynamic> json) {
	if (json['orderInventoryId'] != null) {
		data.orderInventoryId = json['orderInventoryId'] is String
				? int.tryParse(json['orderInventoryId'])
				: json['orderInventoryId'].toInt();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['userName'] != null) {
		data.userName = json['userName'].toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
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
	return data;
}

Map<String, dynamic> inventoryDoNormalInventoryMemberToJson(InventoryDoNormalInventoryMember entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderInventoryId'] = entity.orderInventoryId;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['name'] = entity.name;
	data['userName'] = entity.userName;
	data['userId'] = entity.userId;
	data['times'] = entity.times;
	data['goodsStyleNum'] = entity.goodsStyleNum;
	data['goodsNum'] = entity.goodsNum;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	return data;
}

inventoryDoSubstandardInventoryMemberFromJson(InventoryDoSubstandardInventoryMember data, Map<String, dynamic> json) {
	if (json['orderInventoryId'] != null) {
		data.orderInventoryId = json['orderInventoryId'] is String
				? int.tryParse(json['orderInventoryId'])
				: json['orderInventoryId'].toInt();
	}
	if (json['orderGoodsType'] != null) {
		data.orderGoodsType = json['orderGoodsType'].toString();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['userName'] != null) {
		data.userName = json['userName'].toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId'] is String
				? int.tryParse(json['userId'])
				: json['userId'].toInt();
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
	return data;
}

Map<String, dynamic> inventoryDoSubstandardInventoryMemberToJson(InventoryDoSubstandardInventoryMember entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderInventoryId'] = entity.orderInventoryId;
	data['orderGoodsType'] = entity.orderGoodsType;
	data['name'] = entity.name;
	data['userName'] = entity.userName;
	data['userId'] = entity.userId;
	data['times'] = entity.times;
	data['goodsStyleNum'] = entity.goodsStyleNum;
	data['goodsNum'] = entity.goodsNum;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	return data;
}
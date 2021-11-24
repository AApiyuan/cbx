import 'package:haidai_flutter_module/model/rep/inventory_history_pagereq_entity.dart';

inventoryHistoryPagereqEntityFromJson(InventoryHistoryPagereqEntity data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? num.tryParse(json['deptId'])
				: json['deptId'];
	}
	if (json['deptIds'] != null) {
		data.deptIds = (json['deptIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['startTime'] != null) {
		data.startTime = json['startTime'].toString();
	}
	if (json['endTime'] != null) {
		data.endTime = json['endTime'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['normalFinish'] != null) {
		data.normalFinish = json['normalFinish'].toString();
	}
	if (json['substandardFinish'] != null) {
		data.substandardFinish = json['substandardFinish'].toString();
	}
	return data;
}

Map<String, dynamic> inventoryHistoryPagereqEntityToJson(InventoryHistoryPagereqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['deptIds'] = entity.deptIds;
	data['startTime'] = entity.startTime;
	data['endTime'] = entity.endTime;
	data['status'] = entity.status;
	data['normalFinish'] = entity.normalFinish;
	data['substandardFinish'] = entity.substandardFinish;
	return data;
}
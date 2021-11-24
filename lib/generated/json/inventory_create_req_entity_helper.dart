import 'package:haidai_flutter_module/model/checkCenter/inventory_create_req_entity.dart';

inventoryCreateReqEntityFromJson(InventoryCreateReqEntity data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	return data;
}

Map<String, dynamic> inventoryCreateReqEntityToJson(InventoryCreateReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	return data;
}
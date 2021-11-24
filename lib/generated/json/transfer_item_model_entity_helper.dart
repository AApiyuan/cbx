import 'package:haidai_flutter_module/page/transfer/model/res/transfer_item_model_entity.dart';

transferItemModelEntityFromJson(TransferItemModelEntity data, Map<String, dynamic> json) {
	if (json['time'] != null) {
		data.time = json['time'].toString();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['orderInfo'] != null) {
		data.orderInfo = json['orderInfo'].toString();
	}
	if (json['orderType'] != null) {
		data.orderType = json['orderType'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['remarks'] != null) {
		data.remarks = json['remarks'].toString();
	}
	if (json['numInfo'] != null) {
		data.numInfo = json['numInfo'].toString();
	}
	if (json['difference'] != null) {
		data.difference = json['difference'].toString();
	}
	if (json['actions'] != null) {
		data.actions = (json['actions'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	return data;
}

Map<String, dynamic> transferItemModelEntityToJson(TransferItemModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['time'] = entity.time;
	data['deptName'] = entity.deptName;
	data['orderInfo'] = entity.orderInfo;
	data['orderType'] = entity.orderType;
	data['status'] = entity.status;
	data['remarks'] = entity.remarks;
	data['numInfo'] = entity.numInfo;
	data['difference'] = entity.difference;
	data['actions'] = entity.actions;
	return data;
}
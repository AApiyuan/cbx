import 'package:haidai_flutter_module/page/stock/model/req/order_stock_update_dto.dart';

orderStockUpdateDtoFromJson(OrderStockUpdateDto data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['changeReason'] != null) {
		data.changeReason = json['changeReason'].toString();
	}
	if (json['remarks'] != null) {
		data.remarks = (json['remarks'] as List).map((v) => OrderStockUpdateDtoRemarks().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> orderStockUpdateDtoToJson(OrderStockUpdateDto entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['remark'] = entity.remark;
	data['changeReason'] = entity.changeReason;
	data['remarks'] =  entity.remarks?.map((v) => v.toJson())?.toList();
	return data;
}

orderStockUpdateDtoRemarksFromJson(OrderStockUpdateDtoRemarks data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	return data;
}

Map<String, dynamic> orderStockUpdateDtoRemarksToJson(OrderStockUpdateDtoRemarks entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['remark'] = entity.remark;
	return data;
}
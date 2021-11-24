import 'package:haidai_flutter_module/page/direct_deliver/model/req/delivery_create_delivery_req_entity.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/res/delivery_detail_do_entity.dart';

deliveryCreateDeliveryReqEntityFromJson(DeliveryCreateDeliveryReqEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['warehouseId'] != null) {
		data.warehouseId = json['warehouseId'] is String
				? int.tryParse(json['warehouseId'])
				: json['warehouseId'].toInt();
	}
	if (json['customerId'] != null) {
		data.customerId = json['customerId'] is String
				? int.tryParse(json['customerId'])
				: json['customerId'].toInt();
	}
	if (json['customizeTime'] != null) {
		data.customizeTime = json['customizeTime'].toString();
	}
	if (json['customerAddress'] != null) {
		data.customerAddress = json['customerAddress'].toString();
	}
	if (json['logisticsCompanyId'] != null) {
		data.logisticsCompanyId = json['logisticsCompanyId'] is String
				? int.tryParse(json['logisticsCompanyId'])
				: json['logisticsCompanyId'].toInt();
	}
	if (json['logisticsCompanyName'] != null) {
		data.logisticsCompanyName = json['logisticsCompanyName'].toString();
	}
	if (json['logisticsNo'] != null) {
		data.logisticsNo = json['logisticsNo'].toString();
	}
	if (json['consigneeImg'] != null) {
		data.consigneeImg = json['consigneeImg'].toString();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'].toString();
	}
	if (json['deliveryGoodsList'] != null) {
		data.deliveryGoodsList = (json['deliveryGoodsList'] as List).map((v) => DeliveryDetailDoDeliveryGoodsList().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> deliveryCreateDeliveryReqEntityToJson(DeliveryCreateDeliveryReqEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['deptId'] = entity.deptId;
	data['warehouseId'] = entity.warehouseId;
	data['customerId'] = entity.customerId;
	data['customizeTime'] = entity.customizeTime;
	data['customerAddress'] = entity.customerAddress;
	data['logisticsCompanyId'] = entity.logisticsCompanyId;
	data['logisticsCompanyName'] = entity.logisticsCompanyName;
	data['logisticsNo'] = entity.logisticsNo;
	data['consigneeImg'] = entity.consigneeImg;
	data['remark'] = entity.remark;
	data['deliveryGoodsList'] =  entity.deliveryGoodsList?.map((v) => v.toJson())?.toList();
	return data;
}
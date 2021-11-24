import 'package:haidai_flutter_module/model/inventory_report_entity.dart';

inventoryReportEntityFromJson(InventoryReportEntity data, Map<String, dynamic> json) {
	if (json['orderSerial'] != null) {
		data.orderSerial = json['orderSerial'].toString();
	}
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
	if (json['inventoryNum'] != null) {
		data.inventoryNum = json['inventoryNum'] is String
				? int.tryParse(json['inventoryNum'])
				: json['inventoryNum'].toInt();
	}
	if (json['inventoryStyleNum'] != null) {
		data.inventoryStyleNum = json['inventoryStyleNum'] is String
				? int.tryParse(json['inventoryStyleNum'])
				: json['inventoryStyleNum'].toInt();
	}
	if (json['noInventoryStyleNum'] != null) {
		data.noInventoryStyleNum = json['noInventoryStyleNum'] is String
				? int.tryParse(json['noInventoryStyleNum'])
				: json['noInventoryStyleNum'].toInt();
	}
	if (json['totalGoodsStyleNum'] != null) {
		data.totalGoodsStyleNum = json['totalGoodsStyleNum'] is String
				? int.tryParse(json['totalGoodsStyleNum'])
				: json['totalGoodsStyleNum'].toInt();
	}
	if (json['totalGoodsNum'] != null) {
		data.totalGoodsNum = json['totalGoodsNum'] is String
				? int.tryParse(json['totalGoodsNum'])
				: json['totalGoodsNum'].toInt();
	}
	if (json['substandardInventoryNum'] != null) {
		data.substandardInventoryNum = json['substandardInventoryNum'] is String
				? int.tryParse(json['substandardInventoryNum'])
				: json['substandardInventoryNum'].toInt();
	}
	if (json['substandardInventoryStyleNum'] != null) {
		data.substandardInventoryStyleNum = json['substandardInventoryStyleNum'] is String
				? int.tryParse(json['substandardInventoryStyleNum'])
				: json['substandardInventoryStyleNum'].toInt();
	}
	if (json['substandardNoInventoryStyleNum'] != null) {
		data.substandardNoInventoryStyleNum = json['substandardNoInventoryStyleNum'] is String
				? int.tryParse(json['substandardNoInventoryStyleNum'])
				: json['substandardNoInventoryStyleNum'].toInt();
	}
	if (json['totalSubstandardStyleNum'] != null) {
		data.totalSubstandardStyleNum = json['totalSubstandardStyleNum'] is String
				? int.tryParse(json['totalSubstandardStyleNum'])
				: json['totalSubstandardStyleNum'].toInt();
	}
	if (json['totalSubstandardNum'] != null) {
		data.totalSubstandardNum = json['totalSubstandardNum'] is String
				? int.tryParse(json['totalSubstandardNum'])
				: json['totalSubstandardNum'].toInt();
	}
	if (json['profitNormalStyleNum'] != null) {
		data.profitNormalStyleNum = json['profitNormalStyleNum'] is String
				? int.tryParse(json['profitNormalStyleNum'])
				: json['profitNormalStyleNum'].toInt();
	}
	if (json['profitNormalNum'] != null) {
		data.profitNormalNum = json['profitNormalNum'] is String
				? int.tryParse(json['profitNormalNum'])
				: json['profitNormalNum'].toInt();
	}
	if (json['profitSubstandardStyleNum'] != null) {
		data.profitSubstandardStyleNum = json['profitSubstandardStyleNum'] is String
				? int.tryParse(json['profitSubstandardStyleNum'])
				: json['profitSubstandardStyleNum'].toInt();
	}
	if (json['profitSubstandardNum'] != null) {
		data.profitSubstandardNum = json['profitSubstandardNum'] is String
				? int.tryParse(json['profitSubstandardNum'])
				: json['profitSubstandardNum'].toInt();
	}
	if (json['lossNormalStyleNum'] != null) {
		data.lossNormalStyleNum = json['lossNormalStyleNum'] is String
				? int.tryParse(json['lossNormalStyleNum'])
				: json['lossNormalStyleNum'].toInt();
	}
	if (json['lossNormalNum'] != null) {
		data.lossNormalNum = json['lossNormalNum'] is String
				? int.tryParse(json['lossNormalNum'])
				: json['lossNormalNum'].toInt();
	}
	if (json['lossSubstandardStyleNum'] != null) {
		data.lossSubstandardStyleNum = json['lossSubstandardStyleNum'] is String
				? int.tryParse(json['lossSubstandardStyleNum'])
				: json['lossSubstandardStyleNum'].toInt();
	}
	if (json['lossSubstandardNum'] != null) {
		data.lossSubstandardNum = json['lossSubstandardNum'] is String
				? int.tryParse(json['lossSubstandardNum'])
				: json['lossSubstandardNum'].toInt();
	}
	if (json['noProfitNormalStyleNum'] != null) {
		data.noProfitNormalStyleNum = json['noProfitNormalStyleNum'] is String
				? int.tryParse(json['noProfitNormalStyleNum'])
				: json['noProfitNormalStyleNum'].toInt();
	}
	if (json['noProfitNormalNum'] != null) {
		data.noProfitNormalNum = json['noProfitNormalNum'] is String
				? int.tryParse(json['noProfitNormalNum'])
				: json['noProfitNormalNum'].toInt();
	}
	if (json['noProfitSubstandardStyleNum'] != null) {
		data.noProfitSubstandardStyleNum = json['noProfitSubstandardStyleNum'] is String
				? int.tryParse(json['noProfitSubstandardStyleNum'])
				: json['noProfitSubstandardStyleNum'].toInt();
	}
	if (json['noProfitSubstandardNum'] != null) {
		data.noProfitSubstandardNum = json['noProfitSubstandardNum'] is String
				? int.tryParse(json['noProfitSubstandardNum'])
				: json['noProfitSubstandardNum'].toInt();
	}
	if (json['noLossNormalStyleNum'] != null) {
		data.noLossNormalStyleNum = json['noLossNormalStyleNum'] is String
				? int.tryParse(json['noLossNormalStyleNum'])
				: json['noLossNormalStyleNum'].toInt();
	}
	if (json['noLossNormalNum'] != null) {
		data.noLossNormalNum = json['noLossNormalNum'] is String
				? int.tryParse(json['noLossNormalNum'])
				: json['noLossNormalNum'].toInt();
	}
	if (json['noLossSubstandardStyleNum'] != null) {
		data.noLossSubstandardStyleNum = json['noLossSubstandardStyleNum'] is String
				? int.tryParse(json['noLossSubstandardStyleNum'])
				: json['noLossSubstandardStyleNum'].toInt();
	}
	if (json['noLossSubstandardNum'] != null) {
		data.noLossSubstandardNum = json['noLossSubstandardNum'] is String
				? int.tryParse(json['noLossSubstandardNum'])
				: json['noLossSubstandardNum'].toInt();
	}
	if (json['totalInventoryNum'] != null) {
		data.totalInventoryNum = json['totalInventoryNum'] is String
				? int.tryParse(json['totalInventoryNum'])
				: json['totalInventoryNum'].toInt();
	}
	if (json['totalSubstandardInventoryNum'] != null) {
		data.totalSubstandardInventoryNum = json['totalSubstandardInventoryNum'] is String
				? int.tryParse(json['totalSubstandardInventoryNum'])
				: json['totalSubstandardInventoryNum'].toInt();
	}
	if (json['regenerate'] != null) {
		data.regenerate = json['regenerate'].toString();
	}
	if (json['startTime'] != null) {
		data.startTime = json['startTime'].toString();
	}
	if (json['endTime'] != null) {
		data.endTime = json['endTime'].toString();
	}
	if (json['canceled'] != null) {
		data.canceled = json['canceled'].toString();
	}
	if (json['canceledUserId'] != null) {
		data.canceledUserId = json['canceledUserId'] is String
				? int.tryParse(json['canceledUserId'])
				: json['canceledUserId'].toInt();
	}
	if (json['canceledTime'] != null) {
		data.canceledTime = json['canceledTime'].toString();
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

Map<String, dynamic> inventoryReportEntityToJson(InventoryReportEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['orderSerial'] = entity.orderSerial;
	data['deptId'] = entity.deptId;
	data['topDeptId'] = entity.topDeptId;
	data['inventoryNum'] = entity.inventoryNum;
	data['inventoryStyleNum'] = entity.inventoryStyleNum;
	data['noInventoryStyleNum'] = entity.noInventoryStyleNum;
	data['totalGoodsStyleNum'] = entity.totalGoodsStyleNum;
	data['totalGoodsNum'] = entity.totalGoodsNum;
	data['substandardInventoryNum'] = entity.substandardInventoryNum;
	data['substandardInventoryStyleNum'] = entity.substandardInventoryStyleNum;
	data['substandardNoInventoryStyleNum'] = entity.substandardNoInventoryStyleNum;
	data['totalSubstandardStyleNum'] = entity.totalSubstandardStyleNum;
	data['totalSubstandardNum'] = entity.totalSubstandardNum;
	data['profitNormalStyleNum'] = entity.profitNormalStyleNum;
	data['profitNormalNum'] = entity.profitNormalNum;
	data['profitSubstandardStyleNum'] = entity.profitSubstandardStyleNum;
	data['profitSubstandardNum'] = entity.profitSubstandardNum;
	data['lossNormalStyleNum'] = entity.lossNormalStyleNum;
	data['lossNormalNum'] = entity.lossNormalNum;
	data['lossSubstandardStyleNum'] = entity.lossSubstandardStyleNum;
	data['lossSubstandardNum'] = entity.lossSubstandardNum;
	data['noProfitNormalStyleNum'] = entity.noProfitNormalStyleNum;
	data['noProfitNormalNum'] = entity.noProfitNormalNum;
	data['noProfitSubstandardStyleNum'] = entity.noProfitSubstandardStyleNum;
	data['noProfitSubstandardNum'] = entity.noProfitSubstandardNum;
	data['noLossNormalStyleNum'] = entity.noLossNormalStyleNum;
	data['noLossNormalNum'] = entity.noLossNormalNum;
	data['noLossSubstandardStyleNum'] = entity.noLossSubstandardStyleNum;
	data['noLossSubstandardNum'] = entity.noLossSubstandardNum;
	data['totalInventoryNum'] = entity.totalInventoryNum;
	data['totalSubstandardInventoryNum'] = entity.totalSubstandardInventoryNum;
	data['regenerate'] = entity.regenerate;
	data['startTime'] = entity.startTime;
	data['endTime'] = entity.endTime;
	data['canceled'] = entity.canceled;
	data['canceledUserId'] = entity.canceledUserId;
	data['canceledTime'] = entity.canceledTime;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}
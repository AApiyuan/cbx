import 'package:haidai_flutter_module/page/transfer/model/res/distribution_salegroup_entity.dart';

distributionSalegroupEntityFromJson(DistributionSalegroupEntity data, Map<String, dynamic> json) {
	if (json['deptId'] != null) {
		data.deptId = json['deptId'].toString();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	if (json['notDistributionNum'] != null) {
		data.notDistributionNum = json['notDistributionNum'].toString();
	}
	return data;
}

Map<String, dynamic> distributionSalegroupEntityToJson(DistributionSalegroupEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['notDistributionNum'] = entity.notDistributionNum;
	return data;
}
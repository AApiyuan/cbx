import 'package:haidai_flutter_module/model/store/res/customer_dept_detail_do.dart';

customerDeptDetailDoFromJson(CustomerDeptDetailDo data, Map<String, dynamic> json) {
	if (json['phone'] != null) {
		data.phone = json['phone'].toString();
	}
	if (json['marketId'] != null) {
		data.marketId = json['marketId'] is String
				? int.tryParse(json['marketId'])
				: json['marketId'].toInt();
	}
	if (json['province'] != null) {
		data.province = json['province'].toString();
	}
	if (json['provinceCode'] != null) {
		data.provinceCode = json['provinceCode'].toString();
	}
	if (json['city'] != null) {
		data.city = json['city'].toString();
	}
	if (json['cityCode'] != null) {
		data.cityCode = json['cityCode'].toString();
	}
	if (json['district'] != null) {
		data.district = json['district'].toString();
	}
	if (json['districtCode'] != null) {
		data.districtCode = json['districtCode'].toString();
	}
	if (json['address'] != null) {
		data.address = json['address'].toString();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['logo'] != null) {
		data.logo = json['logo'].toString();
	}
	if (json['photoAlbumHeader'] != null) {
		data.photoAlbumHeader = json['photoAlbumHeader'].toString();
	}
	if (json['wx'] != null) {
		data.wx = json['wx'].toString();
	}
	if (json['enableTime'] != null) {
		data.enableTime = json['enableTime'] is String
				? int.tryParse(json['enableTime'])
				: json['enableTime'].toInt();
	}
	if (json['longtitude'] != null) {
		data.longtitude = json['longtitude'] is String
				? int.tryParse(json['longtitude'])
				: json['longtitude'].toInt();
	}
	if (json['latitude'] != null) {
		data.latitude = json['latitude'] is String
				? int.tryParse(json['latitude'])
				: json['latitude'].toInt();
	}
	if (json['firstActivatedTime'] != null) {
		data.firstActivatedTime = json['firstActivatedTime'].toString();
	}
	if (json['baseExpiryDate'] != null) {
		data.baseExpiryDate = json['baseExpiryDate'].toString();
	}
	if (json['offlineExpiryDate'] != null) {
		data.offlineExpiryDate = json['offlineExpiryDate'].toString();
	}
	if (json['appBiExpiryDate'] != null) {
		data.appBiExpiryDate = json['appBiExpiryDate'].toString();
	}
	if (json['substandardStockExpiryDate'] != null) {
		data.substandardStockExpiryDate = json['substandardStockExpiryDate'].toString();
	}
	if (json['transferExpiryDate'] != null) {
		data.transferExpiryDate = json['transferExpiryDate'].toString();
	}
	if (json['dataBackgroundExpiryDate'] != null) {
		data.dataBackgroundExpiryDate = json['dataBackgroundExpiryDate'].toString();
	}
	if (json['customerQuotationExpiryDate'] != null) {
		data.customerQuotationExpiryDate = json['customerQuotationExpiryDate'].toString();
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

Map<String, dynamic> customerDeptDetailDoToJson(CustomerDeptDetailDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['phone'] = entity.phone;
	data['marketId'] = entity.marketId;
	data['province'] = entity.province;
	data['provinceCode'] = entity.provinceCode;
	data['city'] = entity.city;
	data['cityCode'] = entity.cityCode;
	data['district'] = entity.district;
	data['districtCode'] = entity.districtCode;
	data['address'] = entity.address;
	data['deptId'] = entity.deptId;
	data['logo'] = entity.logo;
	data['photoAlbumHeader'] = entity.photoAlbumHeader;
	data['wx'] = entity.wx;
	data['enableTime'] = entity.enableTime;
	data['longtitude'] = entity.longtitude;
	data['latitude'] = entity.latitude;
	data['firstActivatedTime'] = entity.firstActivatedTime;
	data['baseExpiryDate'] = entity.baseExpiryDate;
	data['offlineExpiryDate'] = entity.offlineExpiryDate;
	data['appBiExpiryDate'] = entity.appBiExpiryDate;
	data['substandardStockExpiryDate'] = entity.substandardStockExpiryDate;
	data['transferExpiryDate'] = entity.transferExpiryDate;
	data['dataBackgroundExpiryDate'] = entity.dataBackgroundExpiryDate;
	data['customerQuotationExpiryDate'] = entity.customerQuotationExpiryDate;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}
import 'package:haidai_flutter_module/page/help/model/res/admin_video_do.dart';

adminVideoDoFromJson(AdminVideoDo data, Map<String, dynamic> json) {
	if (json['serial'] != null) {
		data.serial = json['serial'].toString();
	}
	if (json['coverUrl'] != null) {
		data.coverUrl = json['coverUrl'].toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort'] is String
				? int.tryParse(json['sort'])
				: json['sort'].toInt();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['videoLdUrl'] != null) {
		data.videoLdUrl = json['videoLdUrl'].toString();
	}
	if (json['videoSdUrl'] != null) {
		data.videoSdUrl = json['videoSdUrl'].toString();
	}
	if (json['videoHdUrl'] != null) {
		data.videoHdUrl = json['videoHdUrl'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'];
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

Map<String, dynamic> adminVideoDoToJson(AdminVideoDo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['serial'] = entity.serial;
	data['coverUrl'] = entity.coverUrl;
	data['sort'] = entity.sort;
	data['title'] = entity.title;
	data['videoLdUrl'] = entity.videoLdUrl;
	data['videoSdUrl'] = entity.videoSdUrl;
	data['videoHdUrl'] = entity.videoHdUrl;
	data['status'] = entity.status;
	data['id'] = entity.id;
	data['createdTime'] = entity.createdTime;
	data['updatedTime'] = entity.updatedTime;
	data['createdBy'] = entity.createdBy;
	data['updatedBy'] = entity.updatedBy;
	data['createdByName'] = entity.createdByName;
	data['updatedByName'] = entity.updatedByName;
	return data;
}
import 'package:haidai_flutter_module/page/customer/model/merchandiser_user_do_entity.dart';

merchandiserUserDoEntityFromJson(MerchandiserUserDoEntity data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['bindPhone'] != null) {
		data.bindPhone = json['bindPhone'].toString();
	}
	if (json['roleName'] != null) {
		data.roleName = json['roleName'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	return data;
}

Map<String, dynamic> merchandiserUserDoEntityToJson(MerchandiserUserDoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['bindPhone'] = entity.bindPhone;
	data['roleName'] = entity.roleName;
	data['status'] = entity.status;
	return data;
}
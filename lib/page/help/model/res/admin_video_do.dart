import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class AdminVideoDo with JsonConvert<AdminVideoDo> {
	String? serial;
	String? coverUrl;
	int? sort;
	String? title;
	String? videoLdUrl;
	String? videoSdUrl;
	String? videoHdUrl;
	dynamic? status;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiRemitPageReq with JsonConvert<BiRemitPageReq> {
	int? topDeptId;
	String? customizeStartTime;
	String? customizeEndTime;
	List<int>? customerDeptIds;
	List<int>? customerIds;
	List<BiRemitPageReqMerchandiserUserList>? merchandiserUserList;
	List<BiRemitPageReqCreateUserUserList>? createUserUserList;
	String? canceled;
	List<BiRemitPageReqLevelTags>? levelTags;
	List<BiRemitPageReqTypes>? types;
	dynamic? status;
	List<String>? excludeColumnFiledNames;
	List<int>? remitMethodIds;
	String? selectType;
	bool? filterMerchandiser;
}

class BiRemitPageReqMerchandiserUserList with JsonConvert<BiRemitPageReqMerchandiserUserList> {
	int? id;
	int? deptId;
}

class BiRemitPageReqCreateUserUserList with JsonConvert<BiRemitPageReqCreateUserUserList> {
	int? id;
	int? deptId;
}

class BiRemitPageReqLevelTags with JsonConvert<BiRemitPageReqLevelTags> {
	int? value;
	String? desc;
}

class BiRemitPageReqTypes with JsonConvert<BiRemitPageReqTypes> {
	int? value;
	String? desc;
}

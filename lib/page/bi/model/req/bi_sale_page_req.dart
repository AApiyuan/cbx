import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/req/merchandiser_user_list.dart';

class BiSalePageReq with JsonConvert<BiSalePageReq> {
	int? topDeptId;
	String? customizeStartTime;
	String? customizeEndTime;
	String? onSaleStartTime;
	String? onSaleEndTime;
	List<int>? customerDeptIds;
	List<int>? remitMethodIds;
	List<int>? customerIds;
	List<MerchandiserUserList>? merchandiserUserList;
	List<BiSalePageReqCreateUserUserList>? createUserUserList;
	String? canceled;
	List<BiSalePageReqLevelTags>? levelTags;
	List<String>? excludeColumnFiledNames;
	String? selectType;
	String? type;
	String? status;
	OrderBy? orderBy;
	bool? toAllDept;
	bool? filterMerchandiser;
}

class BiSalePageReqMerchandiserUserList with JsonConvert<BiSalePageReqMerchandiserUserList> {
	int? id;
	int? deptId;
}

class BiSalePageReqCreateUserUserList with JsonConvert<BiSalePageReqCreateUserUserList> {
	int? id;
	int? deptId;
}

class BiSalePageReqLevelTags with JsonConvert<BiSalePageReqLevelTags> {
	int? value;
	String? desc;
}

class BiSalePageReqOrderBy with JsonConvert<BiSalePageReqOrderBy> {
	String? field;
	String? by;
}

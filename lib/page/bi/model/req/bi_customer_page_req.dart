import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/bi/model/req/merchandiser_user_list.dart';

class BiCustomerPageReq with JsonConvert<BiCustomerPageReq> {
	int? topDeptId;
	List<int>? customerDeptIds;
	List<int>? customerIds;
	List<MerchandiserUserList>? merchandiserUserList;
	List<BiCustomerPageReqLevelTags>? levelTags;
	String? createdStartTime;
	String? createdEndTime;
	List<String>? excludeColumnFiledNames;
	bool? toAllDept;
	OrderBy? orderBy;
	bool? filterMerchandiser;
}

class BiCustomerPageReqMerchandiserUserList with JsonConvert<BiCustomerPageReqMerchandiserUserList> {
	int? id;
	int? deptId;
}

class BiCustomerPageReqLevelTags with JsonConvert<BiCustomerPageReqLevelTags> {
	int? value;
	String? desc;
}

class BiCustomerPageReqOrderBy with JsonConvert<BiCustomerPageReqOrderBy> {
	String? field;
	String? by;
}

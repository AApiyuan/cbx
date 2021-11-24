import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class CustomerDeptConfigReq with JsonConvert<CustomerDeptConfigReq> {
	int? customerDeptId;
	List<String>? groupTypeList;
	List<String>? typeList;
}

import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class StoreDictReqEntity with JsonConvert<StoreDictReqEntity> {
	int? customerDeptId;
	String? dictType;
	String? status;
	int? parentId;
}

import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class StoreCustomerCreateReqEntity with JsonConvert<StoreCustomerCreateReqEntity> {
	String? customerName;
	String? customerPhone;
	int? deptId;
	String? levelTag;
	String? star;
	String? status;
	int? tax;
	int? id;
	int? merchandiserId;
}

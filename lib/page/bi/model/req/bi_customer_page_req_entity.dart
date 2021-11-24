import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';

class BiCustomerPageReqEntity with JsonConvert<BiCustomerPageReqEntity> {
	int? topDeptId;
	List<int>? customerDeptIds;
	OrderBy? orderBy;
	bool? filterMerchandiser;
}

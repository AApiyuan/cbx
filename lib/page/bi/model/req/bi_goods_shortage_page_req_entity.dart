import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';

class BiGoodsShortagePageReqEntity with JsonConvert<BiGoodsShortagePageReqEntity> {
	int? topDeptId;
	List<int>? customerDeptIds;
	List<int>? goodsIds;
	bool? toAllDept;
	OrderBy? orderBy;
	bool? filterMerchandiser;
}

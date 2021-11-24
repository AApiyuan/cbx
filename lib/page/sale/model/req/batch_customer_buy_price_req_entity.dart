import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BatchCustomerBuyPriceReqEntity with JsonConvert<BatchCustomerBuyPriceReqEntity> {
	int? customerId;
	int? deptId;
	List<int>? goodsIds;
}

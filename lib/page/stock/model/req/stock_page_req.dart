import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class StockPageReq with JsonConvert<StockPageReq> {
	int? deptId;
	int? createdBy;
	List<int>? createdBys;
	int? goodsId;
	String? canceled;
	String? orderGoodsType;
	int? customerId;
	int? supplierId;
	String? startTime;
	String? endTime;
	String? orderType;
	List<String>? orderTypes;
}

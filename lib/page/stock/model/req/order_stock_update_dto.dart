import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class OrderStockUpdateDto with JsonConvert<OrderStockUpdateDto> {
	int? id;
	String? remark;
	String? changeReason;
	List<OrderStockUpdateDtoRemarks>? remarks;
}

class OrderStockUpdateDtoRemarks with JsonConvert<OrderStockUpdateDtoRemarks> {
	int? id;
	String? remark;
}

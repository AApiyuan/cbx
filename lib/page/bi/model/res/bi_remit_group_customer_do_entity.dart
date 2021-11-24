import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiRemitGroupCustomerDoEntity with JsonConvert<BiRemitGroupCustomerDoEntity> {
	int? deptId;
	String? deptName;
	int? customerId;
	String? customerName;
	int? receivedAmount;
	int? refundAmount;
	int? totalAmount;
}

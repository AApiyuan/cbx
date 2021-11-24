import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class CustomerDo with JsonConvert<CustomerDo> {
	int? id;
	String? customerName;
	dynamic? levelTag;
	int? balance;
	int? oweAmount;
	int? orderOweAmount;
}

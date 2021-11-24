import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiCustomerDo with JsonConvert<BiCustomerDo> {
	int? id;
	int? deptId;
	String? deptName;
	String? customerName;
	String? customerNamePinYin;
	String? customerPhone;
	dynamic? levelTag;
	int? balance;
	int? orderOweAmount;
	int? oweAmount;
	int? shortageNum;
	int? shortageAmount;
	int? merchandiserId;
	String? merchandiserName;
	String? address;
	dynamic? status;
}

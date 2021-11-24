import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class StoreCustomerPageReqEntity with JsonConvert<StoreCustomerPageReqEntity> {
	int? deptId;
// ignore: unnecessary_question_mark
	dynamic? orderBy;
	List<int>? merchandiserIds;
	String? selectType;
	String? status;
	String? customerNamePhone;
	String? customerName;
}

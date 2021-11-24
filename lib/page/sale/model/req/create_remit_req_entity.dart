import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class CreateRemitReqEntity with JsonConvert<CreateRemitReqEntity> {
	int? customerId;
	int? deptId;
	int? orderSaleId;
	int? remitAmount;
	List<CreateRemitReqRemitRecordMethodDoList>? remitRecordMethodDoList;
	List<CreateRemitReqReqList>? reqList;
	String? type;
	String? customizeTime;
	String? remark;
}

class CreateRemitReqRemitRecordMethodDoList with JsonConvert<CreateRemitReqRemitRecordMethodDoList> {
	int? amount;
	int? remitMethodId;
}

class CreateRemitReqReqList with JsonConvert<CreateRemitReqReqList> {
	int? amount;
	int? customerId;
	int? orderSaleId;
}

import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class TransferItemModelEntity with JsonConvert<TransferItemModelEntity> {
	String? time;
	String? deptName;
	String? orderInfo;
	String? orderType;
	String? status;
	String? remarks;
	String? numInfo;
	String? difference;
	List<String>? actions;
}

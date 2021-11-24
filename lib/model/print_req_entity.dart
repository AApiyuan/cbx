import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class PrintReqEntity with JsonConvert<PrintReqEntity> {
	List<String>? customerDeptConfigTypeList;
	int? customerDeptId;
	int? orderSaleId;
	int? orderRemitId;
	String? pageWidth;
	String? printTypeName;
	String? deptName;
	String? userName;
	String? userPhone;
}

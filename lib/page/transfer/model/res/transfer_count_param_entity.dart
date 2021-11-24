import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class TransferCountParamEntity with JsonConvert<TransferCountParamEntity> {
	int? createdBy;
	int? deptId;
	int? goodsId;
	int? stockOutDeptId;
	int? stockInDeptId;
	String? orderSerial;
	dynamic? status;
	List<String>? statusEnumList;
	String? difference;
	int? orderType;
	String? canceled;
	int? substandard;
	String? startDate;
	String? endDate;
	int? orderSaleId;
	int? otherDeptId;
}

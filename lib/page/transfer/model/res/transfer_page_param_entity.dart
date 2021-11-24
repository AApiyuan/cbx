import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class TransferPageParamEntity with JsonConvert<TransferPageParamEntity> {
	int? createdBy;
	int? deptId;
	int? goodsId;
	int? stockOutDeptId;
	int? stockInDeptId;
	int? customerId;
	String? orderSerial;
	String? status;
	List<String>? statusEnumList;
	String? difference;
	String? orderType;
	String? canceled;
	String? substandard;
	String? distribution;
	String? startDate;
	String? endDate;
	int? orderSaleId;
	String? selectType;
	int? otherDeptId;
}

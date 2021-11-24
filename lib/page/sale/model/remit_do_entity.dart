import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class RemitDoEntity with JsonConvert<RemitDoEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	int? deptId;
	int? topDeptId;
	String? orderRemitSerial;
	int? orderSaleId;
	String? type;
	int? createUserId;
	int? merchandiserId;
	int? customerId;
	String? customizeTime;
	int? remitAmount;
	int? checkSaleAmount;
	String? status;
	String? canceled;
}

import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiRemitDo with JsonConvert<BiRemitDo> {
	int? id;
	int? deptId;
	String? deptName;
	int? orderRemitId;
	String? orderRemitSerial;
	int? orderRemitSerialNo;
	int? orderSaleId;
	String? orderSaleSerial;
	int? orderSaleSerialNo;
	int? orderSaleCustomizeTime;
	int? orderSaleCustomizeDate;
	int? orderSaleCustomizeDateTime;
	List<BiRemitDoRemarkList>? remarkList;
	dynamic? type;
	int? remitMethodId;
	String? remitMethodName;
	int? receivedAmount;
	int? refundAmount;
	int? totalAmount;
	String? customizeTime;
	int? customizeDate;
	int? customizeDateTime;
	int? createdTime;
	int? createUserId;
	int? merchandiserId;
	int? customerId;
	dynamic? canceled;
	int? canceledUserId;
	int? canceledTime;
	String? canceledUserName;
	String? createUserName;
	String? merchandiserName;
	String? customerName;
	String? customerPhone;
	dynamic? levelTag;
}

class BiRemitDoRemarkList with JsonConvert<BiRemitDoRemarkList> {
	int? orderId;
	dynamic? orderType;
	String? remark;
	int? id;
	int? createdTime;
	int? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

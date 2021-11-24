import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class RemitDetailDoEntity with JsonConvert<RemitDetailDoEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
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
	String? createUserName;
	String? merchandiserName;
	List<RemitDetailDoRemarkList>? remarkList;
	List<RemitDetailDoRemitRecordMethodList>? remitRecordMethodList;
	List<dynamic>? remitRefundMethodList;
	List<RemitDetailDoStoreCustomerBalanceChangeLogList>? storeCustomerBalanceChangeLogList;
}

class RemitDetailDoRemarkList with JsonConvert<RemitDetailDoRemarkList> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
	int? orderId;
	String? orderType;
	String? remark;
}

class RemitDetailDoRemitRecordMethodList with JsonConvert<RemitDetailDoRemitRecordMethodList> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	int? deptId;
	int? topDeptId;
	int? orderRemitId;
	int? remitMethodId;
	int? amount;
	String? approveStatus;
	String? remitMethodName;
}

class RemitDetailDoStoreCustomerBalanceChangeLogList with JsonConvert<RemitDetailDoStoreCustomerBalanceChangeLogList> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
	int? deptId;
	int? topDeptId;
	int? customerId;
	String? type;
	int? orderSaleId;
	int? orderRemitId;
	int? amount;
	String? canceled;
	String? orderSaleSerial;
	String? orderRemitSerial;
}

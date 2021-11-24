import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class StoreCustomerBalanceChangeLogDetailDo with JsonConvert<StoreCustomerBalanceChangeLogDetailDo> {
	StoreCustomerBalanceChangeLogDetailDoRemitDetailDo? remitDetailDo;
	int? deptId;
	int? topDeptId;
	int? userId;
	int? customerId;
	dynamic? type;
	int? orderSaleId;
	int? orderRemitId;
	int? amount;
	dynamic? canceled;
	int? canceledUserId;
	String? canceledTime;
	String? canceledUserName;
	String? orderSaleSerial;
	String? orderRemitSerial;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class StoreCustomerBalanceChangeLogDetailDoRemitDetailDo with JsonConvert<StoreCustomerBalanceChangeLogDetailDoRemitDetailDo> {
	List<StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemarkList>? remarkList;
	List<StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRecordMethodList>? remitRecordMethodList;
	List<StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRefundMethodList>? remitRefundMethodList;
	List<StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomerBalanceChangeLogList>? storeCustomerBalanceChangeLogList;
	int? deptId;
	int? topDeptId;
	String? orderRemitSerial;
	int? orderSaleId;
	dynamic? type;
	int? createUserId;
	int? merchandiserId;
	int? customerId;
	String? customizeTime;
	int? remitAmount;
	int? checkSaleAmount;
	dynamic? status;
	dynamic? canceled;
	int? canceledUserId;
	String? canceledTime;
	String? canceledUserName;
	String? createUserName;
	String? merchandiserName;
	StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomer? storeCustomer;
	int? amount;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemarkList with JsonConvert<StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemarkList> {
	int? orderId;
	dynamic? orderType;
	String? remark;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRecordMethodList with JsonConvert<StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRecordMethodList> {
	int? deptId;
	int? topDeptId;
	int? orderRemitId;
	int? remitMethodId;
	int? amount;
	dynamic? approveStatus;
	int? approveUserId;
	String? approveTime;
	String? remitMethodName;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRefundMethodList with JsonConvert<StoreCustomerBalanceChangeLogDetailDoRemitDetailDoRemitRefundMethodList> {
	String? payeeName;
	String? payeeNo;
	String? payeePlatform;
	int? amount;
	int? deptId;
	int? topDeptId;
	int? orderRemitId;
	dynamic? executeStatus;
	int? executeBy;
	String? executeTime;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomerBalanceChangeLogList with JsonConvert<StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomerBalanceChangeLogList> {
	int? deptId;
	int? topDeptId;
	int? userId;
	int? customerId;
	dynamic? type;
	int? orderSaleId;
	int? orderRemitId;
	int? amount;
	dynamic? canceled;
	int? canceledUserId;
	String? canceledTime;
	String? canceledUserName;
	String? orderSaleSerial;
	String? orderRemitSerial;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomer with JsonConvert<StoreCustomerBalanceChangeLogDetailDoRemitDetailDoStoreCustomer> {
	int? id;
	String? customerName;
	dynamic? levelTag;
	int? balance;
	int? oweAmount;
	int? orderOweAmount;
}

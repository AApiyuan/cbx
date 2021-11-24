import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class TransferListDoEntity with JsonConvert<TransferListDoEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	String? createdByName;
	int? topDeptId;
	int? stockOutDeptId;
	String? stockOutDeptName;
	int? stockInDeptId;
	String? stockInDeptName;
	String? orderSerial;
	int? orderSaleId;
	int? customerId;
	int? orderStockOutId;
	int? stockOutNum;
	int? stockInNum;
	int? applyNum;
	int? stockOutStyleNum;
	int? stockInStyleNum;
	int? applyStyleNum;
	String? status;
	String? difference;
	String? orderType;
	String? deliveryStatus;
	String? substandard;
	String? distribution;
	String? canceled;
	String? customizeTime;
	List<TransferListDoRemarks>? remarks;
	String? orderSaleSerial;
	String? orderSaleCustomizeTime;
	TransferListDoStoreCustomer? storeCustomer;
}

class TransferListDoRemarks with JsonConvert<TransferListDoRemarks> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	String? createdByName;
	int? orderId;
	String? orderType;
	String? remark;
}

class TransferListDoStoreCustomer with JsonConvert<TransferListDoStoreCustomer> {
	int? id;
	String? customerName;
	String? levelTag;
	int? balance;
	int? oweAmount;
	int? orderOweAmount;
}

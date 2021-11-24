import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class TransferDistributionListEntity with JsonConvert<TransferDistributionListEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
	int? topDeptId;
	int? deptId;
	String? configDistribution;
	int? warehouseId;
	String? orderSaleSerial;
	String? customizeTime;
	int? createUserId;
	int? merchandiserId;
	int? customerId;
	int? tax;
	int? originalAmount;
	int? taxOriginalAmount;
	int? receivableAmount;
	int? taxAmount;
	int? discountAmount;
	int? taxReceivableAmount;
	int? checkAmount;
	int? balanceAmount;
	int? wipeOffAmount;
	int? deliveryNum;
	int? deliveryAmount;
	int? canceledNum;
	int? canceledAmount;
	int? shortageNum;
	int? shortageAmount;
	int? incrementStyleNum;
	int? decrementStyleNum;
	int? incrementNum;
	int? decrementNum;
	int? incrementAmount;
	int? decrementAmount;
	int? incrementTaxAmount;
	int? decrementTaxAmount;
	int? normalSaleStyleNum;
	int? normalSaleNum;
	int? normalSaleAmount;
	int? normalSaleTaxAmount;
	int? returnGoodsStyleNum;
	int? returnGoodsNum;
	int? returnGoodsAmount;
	int? returnGoodsTaxAmount;
	int? changeBackOrderGoodsStyleNum;
	int? changeBackOrderGoodsNum;
	int? changeBackOrderGoodsAmount;
	int? changeBackOrderGoodsTaxAmount;
	int? distributionNum;
	String? substandard;
	String? status;
	String? canceled;
	String? createUserName;
	String? merchandiserName;
	String? deptName;
	TransferDistributionListStoreCustomer? storeCustomer;
	int? printNum;
	List<TransferDistributionListRemarkList>? remarkList;
	int? notDistributionStyleNum;
	int? notDistributionNum;
}

class TransferDistributionListStoreCustomer with JsonConvert<TransferDistributionListStoreCustomer> {
	int? id;
	String? customerName;
	String? levelTag;
	int? balance;
	int? oweAmount;
	int? orderOweAmount;
}

class TransferDistributionListRemarkList with JsonConvert<TransferDistributionListRemarkList> {
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

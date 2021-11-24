import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class OrderSaleItemEntity with JsonConvert<OrderSaleItemEntity> {
	String? orderSaleSerial;
	double? taxOriginalAmount;
	double? balanceAmount;
	String? createdTime;
	int? id;
	double? merchandiserId;
	String? customizeTime;
	String? configDistribution;
	double? decrementAmount;
	double? canceledNum;
	double? wipeOffAmount;
	double? decrementStyleNum;
	double? taxReceivableAmount;
	double? originalAmount;
	double? decrementNum;
	double? normalSaleAmount;
	String? updatedByName;
	double? incrementStyleNum;
	double? discountAmount;
	double? updatedBy;
	double? incrementNum;
	double? topDeptId;
	double? incrementAmount;
	String? status;
	double? canceledAmount;
	String? type;
	double? changeBackOrderGoodsTaxAmount;
	double? changeBackOrderGoodsStyleNum;
	double? createUserId;
	double? decrementTaxAmount;
	double? normalSaleNum;
	double? returnGoodsAmount;
	OrderSaleItemStoreCustomer? storeCustomer;
	double? checkAmount;
	String? canceled;
	double? returnGoodsNum;
	double? customerId;
	double? createdBy;
	double? changeBackOrderGoodsAmount;
	double? shortageNum;
	double? returnGoodsStyleNum;
	double? changeBackOrderGoodsNum;
	double? deliveryAmount;
	double? warehouseId;
	double? deliveryNum;
	double? normalSaleStyleNum;
	double? normalSaleTaxAmount;
	String? createdByName;
	double? shortageAmount;
	double? incrementTaxAmount;
	double? tax;
	String? createUserName;
	double? printNum;
	double? deptId;
	double? returnGoodsTaxAmount;
	String? substandard;
	String? merchandiserName;
	double? taxAmount;
	String? updatedTime;
	double? receivableAmount;

	double writeOffAmount = 0.0;
	double tempWriteOffAmount = 0.0;
	bool isCheck = false;

}

class OrderSaleItemStoreCustomer with JsonConvert<OrderSaleItemStoreCustomer> {
	double? orderOweAmount;
	double? id;
	String? levelTag;
	double? oweAmount;
	double? balance;
	String? customerName;
}

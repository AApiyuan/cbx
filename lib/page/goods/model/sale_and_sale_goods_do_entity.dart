import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';

class SaleAndSaleGoodsDoEntity with JsonConvert<SaleAndSaleGoodsDoEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	int? topDeptId;
	int? deptId;
	String? configDistribution;
	String? orderSaleSerial;
	String? type;
	String? customizeTime;
	int? createUserId;
	int? merchandiserId;
	int? customerId;
	String? customerAddress;
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
	String? substandard;
	int? printDistributionNum;
	String? status;
	String? canceled;
	List<SaleDetailDoSaleGoodsList>? saleGoodsList;
}

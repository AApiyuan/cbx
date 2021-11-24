import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiSaleGoodsGroupCustomerDoEntity with JsonConvert<BiSaleGoodsGroupCustomerDoEntity> {
	int? deptId;
	String? deptName;
	int? customerId;
	String? customerName;
	int? normalSaleGoodsNum;
	int? normalSaleAmount;
	int? normalSaleTaxAmount;
	int? returnGoodsNum;
	int? returnAmount;
	int? changeBackOrderGoodsNum;
	int? changeBackOrderAmount;
	int? saleGoodsNum;
	int? saleAmount;
	int? saleTaxAmount;
	int? shortageNum;
	int? shortageAmount;
}

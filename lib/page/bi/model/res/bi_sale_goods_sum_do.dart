import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiSaleGoodsSumDo with JsonConvert<BiSaleGoodsSumDo> {
	int? normalSaleGoodsNum;
	int? normalSaleAmount;
	int? normalSaleTaxAmount;
	int? returnSubStandardGoodsNum;
	int? returnGoodsNum;
	int? returnAmount;
	int? changeBackOrderGoodsNum;
	int? changeBackOrderAmount;
	int? saleGoodsNum;
	int? saleAmount;
	int? saleTaxAmount;
	int? deliveryNum;
	int? deliveryAmount;
	int? canceledNum;
	int? canceledAmount;
	int? shortageNum;
	int? shortageAmount;
}

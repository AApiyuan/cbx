import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiSaleGoodsGroupTimeDo with JsonConvert<BiSaleGoodsGroupTimeDo> {
	String? timeTitle;
	String? timeTitleShorthand;
	int? normalSaleGoodsNum;
	int? normalSaleAmount;
	int? normalSaleTaxAmount;
	int? returnGoodsNum;
	int? returnAmount;
	int? changeBackOrderGoodsNum;
	int? changeBackOrderAmount;
	double? saleGoodsNum;
	int? saleAmount;
	double? saleTaxAmount;
	int? shortageNum;
	int? shortageAmount;
}

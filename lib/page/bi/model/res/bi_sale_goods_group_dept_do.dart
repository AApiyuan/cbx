import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiSaleGoodsGroupDeptDo with JsonConvert<BiSaleGoodsGroupDeptDo> {
	int? deptId;
	String? deptName;
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

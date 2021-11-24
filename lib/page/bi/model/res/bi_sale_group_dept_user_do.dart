import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiSaleGroupDeptUserDo with JsonConvert<BiSaleGroupDeptUserDo> {
	int? deptId;
	String? deptName;
	int? merchandiserId;
	String? merchandiserName;
	String? bindPhone;
	String? entryTime;
	dynamic? status;
	int? orderSaleNum;
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
	int receivedAmount = 0;
	int refundAmount = 0;
	int totalAmount = 0;
}

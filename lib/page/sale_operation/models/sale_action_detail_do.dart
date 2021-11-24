import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class SaleActionDetailDo with JsonConvert<SaleActionDetailDo> {
	dynamic? type;
	int? createdBy;
	String? createdByName;
	String? createdTime;
	String? orderSerial;
	int? orderId;
	int? amount;
	int? goodsStyleNum;
	int? goodsNum;
	int? normalSaleNum;
	int? returnGoodsNum;
	int? changeBackOrderGoodsNum;
	int? warehouseId;
	String? warehouseName;
	dynamic? canceled;
	int? canceledUserId;
	String? canceledTime;
	String? canceledUserName;
	String? substandard;
}

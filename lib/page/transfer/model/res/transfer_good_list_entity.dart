import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class TransferGoodListEntity with JsonConvert<TransferGoodListEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	int? deptId;
	String? goodsSerial;
	String? onSaleTime;
	String? status;
	int? sailingPrice;
	int? takingPrice;
	int? packagePrice;
	int? goodsClassify;
	String? cover;
	String? goodsName;
	String? imgPath;
	int? customerDeliveryNum;
}

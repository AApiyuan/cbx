import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class StoreGoodsSkuReqEntity with JsonConvert<StoreGoodsSkuReqEntity> {
	int? goodsId;
	int? deptId;
	bool? returnGoodsPrice;
	bool? returnStock;
	int? customerId;
	bool? returnCustomerPrice;
	bool? returnCustomerOweNum;
	bool? returnCustomerDeliveryNum;
}

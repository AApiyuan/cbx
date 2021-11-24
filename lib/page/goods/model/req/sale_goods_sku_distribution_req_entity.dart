import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class SaleGoodsSkuDistributionReqEntity with JsonConvert<SaleGoodsSkuDistributionReqEntity> {
	List<int>? orderSaleGoodsIds;
	String? status;
	int? warehouseId;
	int? orderDeliveryId;
}

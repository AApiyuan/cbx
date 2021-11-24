import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class SaleUpdateReqEntity with JsonConvert<SaleUpdateReqEntity> {
	int? orderSaleId;
	int? merchandiserId;
	int? wipeOffAmount;
	String? configDistribution;
	int? warehouseId;
	int? distributorId;
}

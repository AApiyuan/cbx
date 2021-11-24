import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class SaleCreateDeliveryReqEntity with JsonConvert<SaleCreateDeliveryReqEntity> {
	int? deptId;
	int? warehouseId;
	int? customerId;
	int? orderSaleId;
	int? orderDeliveryId;//发货单id
}

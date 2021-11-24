import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';
import 'package:haidai_flutter_module/page/direct_deliver/model/res/delivery_detail_do_entity.dart';

class DeliveryCreateDeliveryReqEntity with JsonConvert<DeliveryCreateDeliveryReqEntity> {
	int? id;
	int? deptId;
	int? warehouseId;
	int? customerId;
	String? customizeTime;
	String? customerAddress;
	int? logisticsCompanyId;
	String? logisticsCompanyName;
	String? logisticsNo;
	String? consigneeImg;
	String? remark;
	List<DeliveryDetailDoDeliveryGoodsList>? deliveryGoodsList;
}

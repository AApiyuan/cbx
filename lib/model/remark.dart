import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class Remark with JsonConvert<Remark> {
	int? orderId;
	int? orderGoodsId;
	dynamic? orderType;
	String? remark;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

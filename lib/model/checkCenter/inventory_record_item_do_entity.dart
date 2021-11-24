import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class InventoryRecordItemDoEntity with JsonConvert<InventoryRecordItemDoEntity> {
	int? deptId;
	int? topDeptId;
	int? orderInventoryId;
	String? recordImg;
	String? orderGoodsType;
	int? goodsNum;
	int? goodsStyleNum;
	String? canceled;
	int? id;
	String? createdTime;
}

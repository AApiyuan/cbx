import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class InventoryHistoryPagereqEntity with JsonConvert<InventoryHistoryPagereqEntity> {
	num? deptId;
	List<int>? deptIds;
	String? startTime;
	String? endTime;
	String? status;
	String? normalFinish;
	String? substandardFinish;
}

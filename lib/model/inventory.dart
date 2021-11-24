import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class Inventory with JsonConvert<Inventory> {
	String? orderSerial;
	dynamic status;
	List<InventoryNormalInventoryMember>? normalInventoryMembers;
	List<InventorySubstandardInventoryMember>? substandardInventoryMembers;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class InventoryNormalInventoryMember with JsonConvert<InventoryNormalInventoryMember> {
	int? orderInventoryId;
	dynamic orderGoodsType;
	String? name;
	int? times;
	int? goodsStyleNum;
	int? goodsNum;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

class InventorySubstandardInventoryMember with JsonConvert<InventorySubstandardInventoryMember> {
	int? orderInventoryId;
	dynamic orderGoodsType;
	String? name;
	int? times;
	int? goodsStyleNum;
	int? goodsNum;
	int? id;
	String? createdTime;
	String? updatedTime;
	int? createdBy;
	int? updatedBy;
	String? createdByName;
	String? updatedByName;
}

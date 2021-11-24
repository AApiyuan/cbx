import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class InventoryDoEntity with JsonConvert<InventoryDoEntity> {
	int? id;
	String? createdTime;
	String? updatedTime;
	dynamic createdBy;
	dynamic updatedBy;
	dynamic createdByName;
	dynamic updatedByName;
	String? orderSerial;
	String? status;
	List<InventoryDoNormalInventoryMember>? normalInventoryMembers;
	List<InventoryDoSubstandardInventoryMember>? substandardInventoryMembers;
}

class InventoryDoNormalInventoryMember with JsonConvert<InventoryDoNormalInventoryMember> {
	int? orderInventoryId;
	String? orderGoodsType;
	String? name;
	String? userName;
	int? userId;
	int? times;
	int? goodsStyleNum;
	int? goodsNum;
	int? id;
	String? createdTime;
	String? updatedTime;
}

class InventoryDoSubstandardInventoryMember with JsonConvert<InventoryDoSubstandardInventoryMember> {
	int? orderInventoryId;
	String? orderGoodsType;
	String? name;
	String? userName;
	int? userId;
	int? times;
	int? goodsStyleNum;
	int? goodsNum;
	int? id;
	String? createdTime;
	String? updatedTime;
}

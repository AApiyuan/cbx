import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class TransferActionDo with JsonConvert<TransferActionDo> {
  int? orderTransferId;
  dynamic? type;
  int? orderStockDeptId;
  int? orderStockId;
  int? orderStockSerial;
  int? stockOutNum;
  int? stockOutStyleNum;
  int? stockInNum;
  int? stockInStyleNum;
  int? applyNum;
  int? applyStyleNum;
  int? id;
  String? createdTime;
  String? updatedTime;
  int? createdBy;
  int? updatedBy;
  String? createdByName;
  String? updatedByName;
  String? canceled;
  int? orderDeliveryId;
  int? orderDeliveryDeptId;
  String? orderDeliverySerial;
  int? orderDeliveryGoodsNum;
  int? orderDeliveryGoodsStyleNum;
}

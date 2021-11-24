import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class StoreRemitMethodDoEntity with JsonConvert<StoreRemitMethodDoEntity> {
  int? id;
  String? createdTime;
  String? updatedTime;
  int? createdBy;
  int? updatedBy;
  int? deptId;
  int? topDeptId;
  String? remitMethodName;
  int? sort;
  String? status;
  String? xPaymentAmount;
  String? xRefundAmount;
  String amount = "";
  bool selected = false;
}

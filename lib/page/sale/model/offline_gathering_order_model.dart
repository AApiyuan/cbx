import 'package:haidai_flutter_module/common/sale/util/DateUtils.dart';

class OfflineGatheringOrderModel {

  String? remark;
  DateTime? customTime;

  toJson() {
    var map = <String, dynamic>{};
    map["remark"] = remark;
    map["customTime"] = DateUtils.date2String(customTime);
    return map;
  }

  OfflineGatheringOrderModel fromJson(Map jsonMap) {
    var model = OfflineGatheringOrderModel();
    model.remark = jsonMap["remark"];
    model.customTime = DateUtils.string2Date(jsonMap["customTime"]);
    return model;
  }

}
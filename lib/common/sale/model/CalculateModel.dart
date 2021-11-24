
import 'dart:convert';

import 'package:haidai_flutter_module/common/sale/dto/CreateSaleReq.dart';

class CalculateModel {

  late CreateSaleReq saleReq;
  int? checkAmount;
  String? tag;

  CalculateModel.fromJson(dynamic jsonStr) {
    dynamic json = jsonDecode(jsonStr);
    this.checkAmount = json["checkAmount"];
    this.saleReq = CreateSaleReq.fromMap(json["saleReq"]);
    this.tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['tag'] = tag;
    map['saleReq'] = saleReq.toJson();
    map['checkAmount'] = checkAmount;
    return map;
  }

}
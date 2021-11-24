import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiSaleGroupTimeDo with JsonConvert<BiSaleGroupTimeDo> {
  String? timeTitle;
  int? merchandiserNum;
  int? orderSaleNum;
  double? normalSaleGoodsNum;
  int? normalSaleAmount;
  double? normalSaleTaxAmount;
  String? timeTitleShorthand;
  int? returnGoodsNum;
  int? returnAmount;
  int? changeBackOrderGoodsNum;
  int? changeBackOrderAmount;
  double? saleGoodsNum;
  int? saleAmount;
  double? saleTaxAmount;
  int? shortageNum;
  int? shortageAmount;
}

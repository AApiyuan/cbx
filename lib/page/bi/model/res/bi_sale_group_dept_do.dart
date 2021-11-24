import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiSaleGroupDeptDo with JsonConvert<BiSaleGroupDeptDo> {
  int? deptId;
  String? deptName;
  int merchandiserNum = 0;
  int orderSaleNum = 0;
  int normalSaleGoodsNum = 0;
  int normalSaleAmount = 0;
  int normalSaleTaxAmount = 0;
  int returnGoodsNum = 0;
  int returnAmount = 0;
  int changeBackOrderGoodsNum = 0;
  int changeBackOrderAmount = 0;
  int saleGoodsNum = 0;
  int saleAmount = 0;
  int saleTaxAmount = 0;
  int shortageNum = 0;
  int shortageAmount = 0;
  int receivedAmount = 0;
  int refundAmount = 0;
  int totalAmount = 0;
  int balance = 0;
  int orderOweAmount = 0;
  int oweAmount = 0;
  int stockNum = 0;
  int substandardNum = 0;
  int newSaleNum = 0;
}

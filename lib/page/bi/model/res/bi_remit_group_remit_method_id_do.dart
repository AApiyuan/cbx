import 'package:haidai_flutter_module/generated/json/base/json_convert_content.dart';

class BiRemitGroupRemitMethodIdDo with JsonConvert<BiRemitGroupRemitMethodIdDo> {
  int? remitMethodId;
  String? remitMethodName;
  double receivedAmount = 0;
  double refundAmount = 0;
  double totalAmount = 0;
}

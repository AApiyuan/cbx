
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';

class ApiResponse<T> implements Exception {
  String? errorMsg;
  String? msg;
  int? code;
  T? data;

  ApiResponse.error(String msg) {
    toastMsg(msg);
  }

  @override
  String toString() {
    return "Msg : $msg \n errorMsg : $errorMsg \n Data : $data";
  }

  ApiResponse.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    errorMsg = json['errorMsg'];
    code = json['code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['errorMsg'] = this.errorMsg;
    data['code'] = this.code;
    data['data'] = this.data;
    return data;
  }
}


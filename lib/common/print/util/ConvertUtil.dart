import 'package:intl/intl.dart';

import 'PrintUtils.dart';

class ConvertUtil{

  /// 格式化数量
  /// @param value 数据
  /// @return 结果
  static String convertNum(int? value) {
    if(value == null){
      return "";
    }else{
      return value.toString();
    }
  }

  /// 格式化数量
  /// @param value 数据
  /// @return 结果
  static String convertNumSymbol(int? value) {
    if(value == null){
      return "";
    }else{
      if(value > 0) {
        return "+" + value.toString();
      }else{
        return value.toString();
      }
    }
  }

  /// 格式化数量
  /// @param value 数据
  /// @return 结果
  static String convertNumNegate(int? value) {
    if(value == null){
      return "";
    }else{
      return "-" + value.toString();
    }
  }

  /// 格式化金额
  /// @param value 数据
  /// @return 结果
  static String convertAmount(int? value) {
    if(value == null){
      return "";
    }else{
      NumberFormat nf = new NumberFormat("###################.###########");
      return nf.format(value / 100);
    }
  }

  /// 格式化时间
  /// @param value 数据
  /// @return 结果
  static String convertLocalDateTime(DateTime? value) {
    if(value == null){
      return "";
    }else{
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(value);
    }
  }

  /// 格式化时间
  /// @param value 数据
  /// @return 结果
  static String convertLocalDate(DateTime? value) {
    if(value == null){
      return "";
    }else{
      return DateFormat("yyyy-MM-dd").format(value);
    }
  }

  /// 格式化字符串拼接
  /// @param value1 数据
  /// @param value2 数据
  /// @return 结果
  static String convertString(String? value1,String? value2) {
    if(value1 == null){
      if(value2 == null){
        return "";
      }else{
        return value2;
      }
    }else{
      if(value2 == null){
        return value1;
      }else{
        return value1 + "-" + value2;
      }
    }
  }

  /// 处理二维码名称
  /// @param qrsTextList 内容
  /// @return 结果
  static String convertQrsText(List<String> qrsTextList) {
    String builder = "";
    for (int i = 0; i < qrsTextList.length; i++) {
      String qrsText = qrsTextList[i];
      int bodyWidth = PrintUtils.getBodyWidth(qrsText);
      for (int k = 0; k < (12 - bodyWidth) / 2 ; k++){
        builder += " ";
      }
      builder += qrsText;
      for (int k = 0 ; k < 12 - bodyWidth - (12 - bodyWidth) / 2 ; k++){
        builder += " ";
      }
      if(i < qrsTextList.length - 1){
        if(bodyWidth > 12){
          for (int k = 0 ; k < 18 - bodyWidth ; k++){
            builder += " ";
          }
        }else {
          for (int k = 0 ; k < 6 ; k++){
            builder += " ";
          }
        }
      }
    }
    return builder.toString();
  }
}
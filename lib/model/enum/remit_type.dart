class RemitTypeEnum {

  static const PAYMENT = "PAYMENT";//收款
  static const REFUND = "REFUND";//退款
  static const WRITE_OFF = "WRITE_OFF";//核销
  static const OTHER_REVENUE = "OTHER_REVENUE";//杂项收入
  static const OTHER_OUTLAY = "OTHER_OUTLAY";//杂项支出

  /// 获取名称
  static String getDesc(String value) {
    if(value == PAYMENT){
      return "收款";
    }else if(value == REFUND){
      return "退款";
    }else if(value == WRITE_OFF){
      return "核销";
    }else if(value == OTHER_REVENUE){
      return "杂项收入";
    }else if(value == OTHER_OUTLAY){
      return "杂项支出";
    }else{
      return "";
    }
  }
}
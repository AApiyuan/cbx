import 'RemitRecordMethod.dart';

/// 本次收退款单详情
class RemitDetail{

  /// 单据号码序号
  String orderSerialNo = "";

  /// 收退款金额
  int? remitAmount;

  /// 收退款方式详情
  List<RemitRecordMethod>? remitRecordMethodList;
}
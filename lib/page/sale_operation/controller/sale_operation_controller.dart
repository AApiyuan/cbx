import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/page/sale_operation/models/sale_action_detail_do.dart';
import 'package:haidai_flutter_module/repository/order/sale_api.dart';

class SaleOperationController extends SuperController {
  List<SaleActionDetailDo> actions = [];
  var deptId;

  @override
  void onInit() {
    super.onInit();
    var orderSaleId = ArgUtils.getArgument2num(Constant.ORDER_SALE_ID)?.toInt();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    SaleApi.selectSaleActionDetailById(orderSaleId as int, showLoading: true).then((v) {
      actions = v;
      update(['operationList']);
    });
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}

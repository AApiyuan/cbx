import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/enum/canceled.dart';
import 'package:haidai_flutter_module/page/transfer/model/res/transfer_action_do.dart';
import 'package:haidai_flutter_module/page/transfer/transfer_operation/models/transfer_action_type.dart';
import 'package:haidai_flutter_module/repository/order/transfer_api.dart';

class TransferOperationController extends SuperController {
  List<TransferActionDo> actions = [];
  var deptId;

  getAction(int orderTransferId){
    TransferApi.getAction(orderTransferId, showLoading: true).then((v) {
      v.forEach((element) {
        if (element.type == TransferActionDetailTypeEnum.CREATE ||
            element.type == TransferActionDetailTypeEnum.MODIFY ||
            element.type == TransferActionDetailTypeEnum.CANCEL ) {
          element.canceled = CanceledEnum.ENABLE;
        }
      });
      actions = v;
      update(['operationList']);
    });
  }

  @override
  void onInit() {
    super.onInit();
    var orderTransferId = ArgUtils.getArgument2num(Constant.ORDER_TRANSFER_ID)?.toInt();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    getAction(orderTransferId as int);
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

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/http/global.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';

class SaleShareController extends SuperController {
  var deptId;
  var orderSaleId;
  var accessToken;
  String? img;

  init() async{
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    orderSaleId = ArgUtils.getArgument2num(Constant.ORDER_SALE_ID)!.toInt();
    accessToken = Global.accessToken;
  }

  @override
  void onInit() {
    super.onInit();
    deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
    orderSaleId = ArgUtils.getArgument2num(Constant.ORDER_SALE_ID)!.toInt();
    accessToken = Global.accessToken;
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() async {
    print("diaoyong");

    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    print("1");
    // loadData(6);
    // TODO: implement onResumed
  }
}

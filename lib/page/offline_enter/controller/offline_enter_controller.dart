import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/db/sql_db.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/store/res/customer_dept_detail_and_role_do.dart';

class OfflineEnterController extends SuperController {

  var deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)?.toInt();
  var userId = ArgUtils.getArgument2num(Constant.USER_ID)!.toInt();
  var userPhone = ArgUtils.getArgument(Constant.USER_PHONE);
  var userName = ArgUtils.getArgument(Constant.USER_NAME);

  List<CustomerDeptDetailAndRoleDo> list = [];

  CustomerDeptDetailAndRoleDo getDeptItem(int index) {
    return list[index];
  }

  init() async {
    list = await DeptQuery.selectUserDept(userId);
    print(list);
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
    print("onDetached");
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
    print("onInactive");
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
    print("onPaused");
  }

  @override
  void onResumed() {
    init();
  }
}

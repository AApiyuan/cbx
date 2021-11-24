
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';

class ExposureRecordController extends SuperController {
  var deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();
  var phone = ArgUtils.getArgument2num(Constant.PHONE)!.toInt();
  List data = [];
  bool show = true;
  var content = '';

  var pageNo = 1; //页码
  var pageSize = 600; //页数
  var count = 0; //页数

  getRetailStoreCustomer() async {
    var param = {
      "pageSize": pageSize,
      "pageNo": pageNo,
      "param": {
        "customerDeptId": deptId,
        "customerPhone": phone,
        "orderBy": {
          "field": "createdTime",
          "by": "DESC"
        }
      },

    };
    return await CustomerApi.getCustomerRiskArticle (param, showLoading: true)
        .then((value) {
          if(pageNo == 1){
            data = value;
          }else{
            data = data + value;
          }

          update(['exposureview']);
    });
  }

  @override
  // ignore: must_call_super
  void onInit() async {
    getRetailStoreCustomer();
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

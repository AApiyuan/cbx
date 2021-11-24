import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haidai_flutter_module/common/db/sql_db.dart';
import 'package:haidai_flutter_module/common/oss/aliyun_oss.dart';
import 'package:haidai_flutter_module/repository/oss.dart';

class SplashController extends SuperController {

  @override
  void onInit() async{

    // var res = await OssApi.getOssDomain();
    // OSSClient.init(
    //   endpoint: res['endpoint'],
    //   bucket: res['bucketName'],
    //   credentials: () async {
    //     var response = await OssApi.getNewSts();
    //     return Credentials(
    //         accessKeySecret: response['accessKeySecret'],
    //         expiration: DateTime.parse(response['expiration']),
    //         securityToken: response['securityToken'],
    //         accessKeyId: response['accessKeyId']);
    //   },
    // );
    //
    // await DbUtil.init();
    // loadData(6);
    // super.onInit();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() async{
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

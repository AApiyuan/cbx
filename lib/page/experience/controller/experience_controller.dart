import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/repository/base/user_api.dart';

class ExperienceController extends SuperController {
  var name = '';
  var phone = '';
  var roleName = '';
  var code = '';
  var countdown = 0;
  late Timer timer;

  getVerificationCode() async {
    var param = {"phone": phone, "type": "USER_EXPERIENCE"};
    return await UserApi.sendCode(param, showLoad: true).then((value) {
      if (value == true) {
        toastMsg("验证码已发送，请注意查收");
        countdown = 60;
        update(["verificationCode"]);

        timer = Timer.periodic (Duration(seconds: 1),(timer){
          countdown -= 1;
          if(countdown == 0){
            timer.cancel();
          }
          update(["verificationCode"]);

        }
            );
      }else{
        toastMsg("获取验证码失败");
      }
    });
  }

  experienceButtonEnable(){
    if(name.length > 0 && phone.length == 11 && code.length == 4 && roleName.length > 0){
      return true;
    }
    return false;
  }


  getCountdownInfo(){
    if(countdown == 0){
      return '获取验证码';
    }
    return '请等待' + countdown.toString() + '秒';
  }

  loginExperienceAccount() async {

    var param = {
      "name": name,
      "phone": phone,
      "roleName": roleName,
      "code": code
    };
    return await UserApi.loginExperienceAccount(param, showLoad: true)
        .then((value) {
          print(value);
          MethodChannel(ChannelConfig.flutterToNative)
              .invokeMethod(
              ChannelConfig.methodloginExperienceAccount, {
            "token": value,
            "phone":phone,
            "name":name
          });
          Get.back();
    });
  }

  @override
  // ignore: must_call_super
  void onInit() async {}

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

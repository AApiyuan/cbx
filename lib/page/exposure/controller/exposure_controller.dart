import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/constant/constants.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/back_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/repository/base/customer.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExposureController extends SuperController {
  List datas = ['images/icon_good_add.png'];
  bool show = true;
  var content = '';
  var phone = ArgUtils.getArgument(Constant.PHONE) ?? "";
  var deptId = ArgUtils.getArgument2num(Constant.DEPT_ID)!.toInt();

  Future<void> iosChooseImg() async {
    if (GetPlatform.isIOS) {
      MethodChannel channel = MethodChannel(ChannelConfig.flutterToNative);
      String path =
          await channel.invokeMethod(ChannelConfig.methodManuallyGetLocalImages);
      upload(path);
    }
  }

  /// 选图片弹窗
  void showChooseImgDialog() {
    if(datas.length > 9){
      toastMsg("图片数量不能超过9张");
      return;
    }


    if (GetPlatform.isIOS) {
      iosChooseImg();
    }else{
      showModalBottomSheet(
          backgroundColor: Color(ColorConfig.color_00000000),
          context: Get.context!,
          builder: (BuildContext context) {
            return Container(
              height: 402.w,
              margin: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 0.w),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async => pickImageFromCamera()
                        .then((value) => Navigator.pop(context)),
                    child: Container(
                      decoration: ShapeDecoration(
                          color: Color(0xBBFFFFFF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(28.w),
                                  topRight: Radius.circular(28.w)))),
                      width: double.infinity,
                      height: 113.w,
                      child: Text("拍照上传",
                          style: TextStyle(
                              color: Color(ColorConfig.color_1678FF),
                              fontSize: 40.w,
                              fontWeight: FontWeight.bold)),
                      alignment: Alignment.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async => pickImageFromGallery()
                        .then((value) => Navigator.pop(context)),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 2.w, 0, 0),
                      decoration: ShapeDecoration(
                          color: Color(0xBBFFFFFF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(28.w),
                                  bottomRight: Radius.circular(28.w)))),
                      width: double.infinity,
                      height: 113.w,
                      child: Text("从相册选择",
                          style: TextStyle(
                              color: Color(ColorConfig.color_1678FF),
                              fontSize: 40.w,
                              fontWeight: FontWeight.bold)),
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 12.w, 0, 0),
                        decoration: ShapeDecoration(
                            color: Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(28.w),
                                ))),
                        width: double.infinity,
                        height: 113.w,
                        child: Text("取消",
                            style: TextStyle(
                                color: Color(ColorConfig.color_1678FF),
                                fontSize: 40.w,
                                fontWeight: FontWeight.bold)),
                        alignment: Alignment.center,
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    }





  }

  Future<void> pickImageFromCamera() async {
    final PickedFile? pickedFile = (await ImagePicker()
        .getImage(source: ImageSource.camera)
        .whenComplete(() {}));
    if (pickedFile == null) return;
    upload(pickedFile.path);
  }

  Future<void> pickImageFromGallery() async {
    final PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery)
        .whenComplete(() {});
    if (pickedFile == null) return;
    upload(pickedFile.path);
  }

  upload(String path) async {
    MethodChannel(ChannelConfig.flutterToNative)
        .invokeMethod(ChannelConfig.methodCustomerRiskPhotoVoucher, path)
        .then((value) {
      if (value == null) {
        return;
      }
      datas.insert(datas.length - 1, value);
      update(["gridview"]);
    });
  }

  exposureConsumer() async {
    var contentImgs = "";
    datas.forEach((item) {
      if (item != 'images/icon_good_add.png') {
        var temp = item.toString().split('/');
        if (contentImgs.length > 1) {
          contentImgs = contentImgs + "," + temp.last;
        } else {
          contentImgs = temp.last;
        }
      }
    });

    if (!RegExp(r"^(1[0-9])\d{9}$").hasMatch(phone as  String)) {
      toastMsg('请输入正确的手机号码');
      return;
    }
    if (content.length < 1) {
      toastMsg('请输入曝光内容');
      return;
    }


    var param = {
      "content": content,
      "customerPhone": phone,
      'deptId': deptId,
      'imgPath': deptId.toString() + '/article/customer_risk/',
      'contentImgs': contentImgs,
      'showDept': show ? "YES" : "NO",
    };
    return await CustomerApi.addCustomerRiskArticle(param).then((value) {
      if (value == true) {
        print(value);
        toastMsg('提交成功');
        Future.delayed(const Duration(milliseconds: 1000), () {
          //延时执行的代码
          Get.offNamed(ArgUtils.map2String(
              path: Routes.EXPOSURERECORD, arguments: {Constant.DEPT_ID:deptId,Constant.PHONE
              :phone}));
          // BackUtils.back();
        });
      }
    });
  }

  @override
  // ignore: must_call_super
  void onInit() async {
    if(phone == "null"){
      phone = "";
    }
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

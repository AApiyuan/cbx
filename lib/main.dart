import 'dart:convert';
import 'dart:ui';

//import 'package:dokit/dokit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/db/query/hang_order_query.dart';
import 'package:haidai_flutter_module/common/db/sql_db.dart';
import 'package:haidai_flutter_module/common/http/proxy.dart';
import 'package:haidai_flutter_module/common/oss/aliyun_oss.dart';
import 'package:haidai_flutter_module/common/print/enums/PageWidthEnum.dart';
import 'package:haidai_flutter_module/common/print/util/PrintUtils.dart';
import 'package:haidai_flutter_module/common/sale/CalculateSaleAmountUtil.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleReq.dart';
import 'package:haidai_flutter_module/common/sale/model/CalculateModel.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/model/native_data.dart';
import 'package:haidai_flutter_module/model/update_detp_entity.dart';
import 'package:haidai_flutter_module/repository/oss.dart';
import 'package:haidai_flutter_module/routes/app_pages.dart';
import 'package:haidai_flutter_module/theme/app_theme.dart';
import 'package:haidai_flutter_module/widget/keyboard/keyboard_root.dart';
import 'package:haidai_flutter_module/widget/keyboard/number_keyboard.dart';
import 'package:package_info/package_info.dart';

import 'common/config/channel_config.dart';
import 'common/config/my_binary.dart';
import 'common/http/global.dart';
import 'common/http/http_utils.dart';
import 'common/utils/back_utils.dart';
import 'common/utils/device_utils.dart';
import 'model/dept_config_req_entity.dart';
import 'model/download_dept_entity.dart';
import 'model/enum/config_group_type.dart';
import 'model/print_req_entity.dart';
import 'model/store/res/customer_dept_config_do.dart';

void main() {
  MyWidgetsFlutterBinding.ensureInitialized(); //解决2.5 的方法弃用问题
  NumberKeyboard.register();
  runApp(ScreenUtilInit(
    builder: () => KeyboardRootWidget(child: MyApp()),
    designSize: Size(DeviceUtil.isPad()?1536:750, 1612),
  ));

  initDevice();
  DbUtil.init();
  const EventChannel('native_to_flutter')
      .receiveBroadcastStream("success")
      .listen((event) => switchEvent(event));

  print("flutter_tag===========main");
}

initDevice() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  if (Config.isIOS) {
    Config.isDebug = packageInfo.packageName == "com.piyuan.kaidandev";
  } else if (Config.isAndroid) {
    Config.isDebug = packageInfo.packageName.lastIndexOf(".debug") != -1;
  }
  print("flutter_tag==============initDevice=========${Config.isDebug}");
}

switchEvent(dynamic event) {
  NativeData nativeData = NativeData.fromJson(event);
  print("flutter_tag==============switchEvent=========$event");
  switch (nativeData.type) {
    case 1:
      toPage(nativeData.data!, nativeData.mode);
      break;
    case 2:
      CalculateModel model = CalculateModel.fromJson(nativeData.data);
      CreateSaleReq saleReq = CalculateSaleAmountUtil.calculateSaleAmount(
          model.saleReq, model.checkAmount!);
      print("flutter_tag=============$saleReq");
      model.saleReq = saleReq;
      MethodChannel(ChannelConfig.flutterToNative).invokeMethod(
          ChannelConfig.methodCalculate, jsonEncode(model.toJson()));
      print("flutter_tag==============break");
      break;
    case 3:
      // var updateDept =
      //     UpdateDetpEntity().fromJson(jsonDecode(nativeData.data!));
      // if (OSSClient.isInit) {
      //   updateDepId(updateDept);
      // } else {
      //   initOss().then((value) => updateDepId(updateDept));
      // }
      break;
    case 4:
      createPrintData(PrintReqEntity().fromJson(jsonDecode(nativeData.data!)));
      break;
    case 5:
      getConfigData(
          DeptConfigReqEntity().fromJson(jsonDecode(nativeData.data!)));
      break;
    case 6:
      var download =
          DownloadDeptEntity().fromJson(jsonDecode(nativeData.data!));
      downloadDept(download);
      break;
  }
}

void downloadDept(DownloadDeptEntity entity) async {
  HttpUtils.setHeaders({"Authorization": entity.token});
  initOss().then((value) => DeptQuery.init(entity.userId!));
}

void getConfigData(DeptConfigReqEntity reqEntity) async {
  var configList = await DeptConfigQuery.select(
      reqEntity.customerDeptId!, reqEntity.groupTypeList!);
  configList.forEach(
      (element) => element.configDate = jsonDecode(element.configDate));
  MethodChannel(ChannelConfig.flutterToNativeConfig)
      .invokeMethod(ChannelConfig.methodConfigData, jsonEncode(configList));
}

void createPrintData(PrintReqEntity reqEntity) async {
  int? id;
  if (reqEntity.orderRemitId != null) {
    id = reqEntity.orderRemitId;
  } else if (reqEntity.orderSaleId != null) {
    id = reqEntity.orderSaleId;
  }
  var model = await HangOrderQuery.getHangOrder(id!);
  var typeList = <CustomerDeptConfigDo>[];
  if (reqEntity.customerDeptConfigTypeList?.isNotEmpty ?? false) {
    typeList = await DeptConfigQuery.select(
        model.deptId!, [CustomerDeptConfigGroupEnum.PRINT],
        typeList: reqEntity.customerDeptConfigTypeList!);
  }
  var printDataList = PrintUtils.process(
    EnumCoverUtils.stringToEnums(reqEntity.pageWidth, PageWidthEnum.values)!,
    model,
    typeList,
    reqEntity.userName!,
    reqEntity.userPhone!,
    reqEntity.printTypeName!,
    reqEntity.deptName!,
  );
  String a = jsonEncode(printDataList);
  MethodChannel(ChannelConfig.flutterToNativePrint)
      .invokeMethod(ChannelConfig.methodPrintData, jsonEncode(printDataList));
}

Future initOss() async {
  var res = await OssApi.getOssDomain();
  return OSSClient.init(
    endpoint: res['endpoint'],
    bucket: res['bucketName'],
    credentials: () async {
      var response = await OssApi.getNewSts();
      return Credentials(
          accessKeySecret: response['accessKeySecret'],
          expiration: DateTime.parse(response['expiration']),
          securityToken: response['securityToken'],
          accessKeyId: response['accessKeyId']);
    },
  );
}

updateDepId(UpdateDetpEntity data) {
  print("flutter_tag======updateDepId========$data");
  HttpUtils.setHeaders({"Authorization": data.token});
  if (data.depId != null) {
    print("flutter_tag======loadData");
    loadData(data.depId!);
  }
}

toPage(String value, String? mode) {
  print("flutter_tag============toPage=========$value");
  var helpPage = Routes.HELP + "?";
  if (Get.currentRoute.contains(helpPage) && value.contains(helpPage)) {
    return;
  }
  print("flutter_tag==============$value");
  List<String> url = value.split("?");
  // String path = url[0];
  if (url.length > 1) {
    List<String> params = url[1].split("&");
    Map<String, dynamic> map = {};
    params.forEach((element) {
      List<String> param = element.split("=");
      if (param.length == 2) {
        map[param[0]] = param[1];
      }
    });
    if (map.containsKey("token")) {
      HttpUtils.setHeaders({"Authorization": map["token"]});
      Global.accessToken = map["token"];
    }
    if (map.containsKey("userId")) {
      Config.userId = int.tryParse(map["userId"]);
    }
    if (mode == NativeData.TYPE_TO) {
      Get.toNamed(value);
    } else {
      Get.offAndToNamed(value);
    }
  }

  // List<String> route = value.split("token=");
  // int last = route[0].length;
  // String page = route[0].substring(0, last - 1);
  // if (route.length > 1) {
  //   HttpUtils.setHeaders({"Authorization": route[1]});
  // }
  // if (mode == NativeData.TYPE_TO) {
  //   Get.toNamed(page);
  // } else {
  //   Get.offAndToNamed(page);
  // }
}

class MyApp extends StatelessWidget {
  static const flutter_to_native =
      const MethodChannel(ChannelConfig.flutterToNative);

  @override
  Widget build(BuildContext context) {
    print("flutter_tag=======MyApp");
    flutter_to_native.invokeMethod(ChannelConfig.methodGetPage).then(
        (value) => toPage(value, NativeData.TYPE_OFF),
        onError: (e) => print("flutter_tag======onError======MyApp"));

    if (Config.isAndroid) {
      Future.delayed(Duration(milliseconds: 500)).then((value) =>
          MethodChannel(ChannelConfig.flutterToNativeInit)
              .invokeMethod(ChannelConfig.methodFlutterInit)
              .then((value) => null,
                  onError: (e) =>
                      print("flutter_tag======methodFlutterInit=====onError")));
    }

    return GetMaterialApp(
        onInit: () async {
          // DbUtil.init().then((v) {
          //   //这里loading数据
          //   // loadData(deptId);
          // });
          Get.testMode = Config.isDebug;
          BackUtils.init();
          Proxy.init();
        },
        debugShowCheckedModeBanner: false,
        // initialRoute: page,
        theme: appThemeData,
        locale: Locale('zh', 'CN'),
        fallbackLocale: Locale('en', 'US'),
        // 添加一个回调语言选项，以备上面指定的语言翻译不存在
        defaultTransition: Transition.fadeIn,
        getPages: AppPages.pages,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('zh', 'CN'),
        ],
        initialRoute: Routes.SPLASH,
        builder: EasyLoading.init());
  }
}

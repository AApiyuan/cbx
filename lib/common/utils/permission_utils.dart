import 'dart:async';

import 'package:flutter/services.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';

class PermissionUtils {
  static const WAREHOUSE_ADD_INVENTORY = "WAREHOUSE_ADD_INVENTORY";
  static const WAREHOUSE_ADD_INVENTORY_DATA = "WAREHOUSE_ADD_INVENTORY_DATA";
  static const WAREHOUSE_FINISHED_ADD_INVENTORY_DATA =
      "WAREHOUSE_FINISHED_ADD_INVENTORY_DATA";
  static const WAREHOUSE_FINISHED_INVENTORY = "WAREHOUSE_FINISHED_INVENTORY";
  static const WAREHOUSE_CANCELED_INVENTORY = "WAREHOUSE_CANCELED_INVENTORY";

  static const STORE_SALE_WIPE_OFF = "STORE_SALE_WIPE_OFF";

  static Future<bool> checkPermission(String name) {
    return MethodChannel(ChannelConfig.flutterToNative)
        .invokeMethod(ChannelConfig.methodCheckPermission, name)
        .then((value) {
      if (value == 0) {
        toastMsg("没有该模块的权限，如需要请联系店铺管理员或老板设置");
      }
      return value == 1;
    });
  }
}

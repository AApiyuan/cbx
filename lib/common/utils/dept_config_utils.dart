import 'package:flutter/services.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';

class DeptConfigUtils {
  /// type
  static const CONFIG_PRICE_2 = "CONFIG_PRICE_2"; //退实物上次销售价
  static const CONFIG_PRICE_1 = "CONFIG_PRICE_1"; //销售单上次销售价
  static const CONFIG_DISTRIBUTION_1 = "CONFIG_DISTRIBUTION_1"; //配货仓配置
  static const ORDER_SALE_EDIT_1 = "ORDER_SALE_EDIT_1"; //编辑销售单
  static const ORDER_REMIT_EDIT_1 = "ORDER_REMIT_EDIT_1"; //编辑收款单
  static const ORDER_DELIVERY_EDIT_1 = "ORDER_DELIVERY_EDIT_1"; //编辑发货单

  /// value
  /// CONFIG_PRICE_2
  static const CONFIG_PRICE_2_0 = "CONFIG_PRICE_2_0";

  /// CONFIG_PRICE_1
  static const CONFIG_PRICE_1_0 = "CONFIG_PRICE_1_0";

  /// ORDER_SALE_EDIT_1,ORDER_REMIT_EDIT_1,ORDER_DELIVERY_EDIT_1
  static const TIME_0 = "0";
  static const TIME_1 = "1";
  static const TIME_2 = "2";
  static const TIME_3 = "3";
  static const TIME_4 = "4";
  static const TIME_5 = "5";
  static const TIME_6 = "6";

  static Future<String> getConfig(String type) async {
    return await MethodChannel(ChannelConfig.flutterToNative).invokeMethod(ChannelConfig.methodDeptConfig, type);
  }

  static Future<bool> checkConfig(String type, String value) async {
    return await MethodChannel(ChannelConfig.flutterToNative).invokeMethod(ChannelConfig.methodDeptConfig, type) ==
        value;
  }

  static Future<bool> checkOrderTime(String type, String time) async {
    var value = await getConfig(type);
    var orderTimeList = time.split(" ")[0].split("-");
    var resultTime = DateTime(
      int.parse(orderTimeList[0]),
      int.parse(orderTimeList[1]),
      int.parse(orderTimeList[2]) + int.parse(value) + 1,
      0,
      0,
      0,
      0,
      0,
    );
    var check = DateTime.now().isBefore(resultTime);
    return check;
  }
}

import 'package:flutter/services.dart';
import 'package:haidai_flutter_module/common/config/channel_config.dart';
import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/db/sql_db.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';

class ExperienceUtils {
  static const TYPE_BASE = 0;
  static const TYPE_OFFLINE = 1;
  static const TYPE_QUOTATION = 2;
  static const TYPE_SUBSTANDARD_STOCK = 3;
  static const TYPE_TRANSFER = 4;
  static const TYPE_APP_BI = 5;

  static Future checkExperience(bool online, int type, int deptId) async {
    if (online) {
      return await _onlineCheck(type, deptId);
    } else {
      return await _offlineCheck(type, deptId);
    }
  }

  static Future _offlineCheck(int type, int deptId) async {
    var userId = Config.userId;
    if (userId == null) {
      toastMsg("userId is null");
      return false;
    }
    var dept = await DeptQuery.select(userId, deptId);
    var date;
    switch (type) {
      case TYPE_OFFLINE:
        date = dept.customerDeptDetailDo?.offlineExpiryDate;
        break;
      case TYPE_APP_BI:
        date = dept.customerDeptDetailDo?.appBiExpiryDate;
        break;
      case TYPE_BASE:
        date = dept.customerDeptDetailDo?.baseExpiryDate;
        break;
      case TYPE_QUOTATION:
        date = dept.customerDeptDetailDo?.customerQuotationExpiryDate;
        break;
      case TYPE_SUBSTANDARD_STOCK:
        date = dept.customerDeptDetailDo?.substandardStockExpiryDate;
        break;
      case TYPE_TRANSFER:
        date = dept.customerDeptDetailDo?.transferExpiryDate;
        break;
    }
    if (date != null && DeptQuery.checkOfflineDate(date, dept.customerDeptDetailDo?.createdTime)) {
      return true;
    } else {
      toastMsg("该模块已到期，请联系客服或销售咨询");
      return false;
    }
  }

  static Future _onlineCheck(int type, int deptId) async {
    // if (type == TYPE_OFFLINE) {
    //   var userId = Config.userId;
    //   if (userId == null) return Future.error(toastMsg("userId is null"));
    //   var dept = await DeptQuery.select(userId, deptId);
    //   if (DeptQuery.checkOfflineDate(
    //       dept.customerDeptDetailDo?.offlineExpiryDate, dept.customerDeptDetailDo?.createdTime)) {
    //     return true;
    //   } else {
    //     return Future.error(toastMsg("该模块已到期，请联系客服或销售咨询"));
    //   }
    // }
    var result =
        await MethodChannel(ChannelConfig.flutterToNative).invokeMethod(ChannelConfig.methodCheckExperience, type);
    if (result == 1) {
      return true;
    } else {
      return false;
    }
  }
}

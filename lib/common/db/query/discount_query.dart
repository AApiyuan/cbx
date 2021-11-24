part of '../sql_db.dart';

class DiscountQuery {
  static String tableName = "discount";

  static Future<void> init(int? deptId) async {
    CustomerDeptOfflineReq req = new CustomerDeptOfflineReq();
    req.customerDeptId = deptId;
    req.type = OfflineTypeEnum.DISCOUNT_TEMPLATE;
    List<CustomerDeptOfflineDo> offlineData = await OfflineApi.selectCustomerDeptOffline(req);
    if (offlineData.length > 0) {
      CustomerDeptOfflineDo data = offlineData[0];
      String lastPullTime = await PullLogQuery.select(deptId as int, OfflineTypeEnum.DISCOUNT_TEMPLATE);
      //数据 包比较新
      if (lastPullTime == "") {
        //从未拉取过，要 拉取
        bool result = await pullDiscountData(data.offlineFile as String, deptId);
        if (result) {
          await PullLogQuery.insert(deptId, OfflineTypeEnum.DISCOUNT_TEMPLATE, data.offlineTime as String);
        }
      } else {
        //数据库比较新也要拉取
        if (dbTestMode || DateUtil.getDateTime(data.offlineTime as String)!.isAfter(DateUtil.getDateTime(lastPullTime)!)) {
          bool result = await pullDiscountData(data.offlineFile as String, deptId);
          if (result) {
            await PullLogQuery.update(deptId, OfflineTypeEnum.DISCOUNT_TEMPLATE, data.offlineTime as String);
          }
        }
      }
      dbDownload[deptId]?.add(tableName);
    }
  }

  static Future<bool> pullDiscountData(String name, int deptId) async {
    String keyString = "0000000000000000";
    String dept = deptId.toString();
    keyString = keyString.replaceRange(16 - dept.length, 16, dept);
    var content = await OSSClient().getObjectData(name);
    String discountData = await readContents(content, keyString: keyString);
    List<StoreDiscountTemplateDo> data = jsonDecode(discountData).map<StoreDiscountTemplateDo>((e) => new StoreDiscountTemplateDo().fromJson(e)).toList();
    await delete(deptId: deptId);
    await batchInsert(data, deptId);
    return true;
  }

  static Future<bool> batchInsert(List<StoreDiscountTemplateDo> data, int deptId) async {
    await DbUtil.open();
    Batch batch = db!.batch();
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < data.length; i++) {
      map['id'] = data[i].id;
      map['deptId'] = deptId;
      map['topDeptId'] = data[i].topDeptId;
      map['style'] = data[i].style;
      map['enableNum'] = data[i].enableNum;
      map['totalPrice'] = data[i].totalPrice;
      map['discountPrice'] = data[i].discountPrice;
      map['status'] = data[i].status;
      batch.insert(tableName, map);
    }
    await batch.commit();
    await DbUtil.close();
    return true;
  }

  static Future<List<StoreDiscountTemplateDo>> select(StoreDiscountTemplateReq param) async {
    await DbUtil.open();
    var result;

    if (param.status == null) {
      result = await db!.query(
        tableName,
        where: "deptId=? and style=?",
        whereArgs: [param.customerDeptId, param.style],
      );
    } else {
      result = await db!.query(
        tableName,
        where: "deptId=? and style=? and status=?",
        whereArgs: [param.customerDeptId, param.style, param.status],
      );
    }

    await DbUtil.close();
    return result.map<StoreDiscountTemplateDo>((e) => new StoreDiscountTemplateDo().fromJson(e)).toList();
  }

  static Future<bool> delete({int? deptId}) async {
    await DbUtil.open();
    if (deptId != null) {
      await db!.delete(tableName, where: "deptId = ?", whereArgs: [deptId]);
    } else {
      await db!.delete(tableName);
    }
    await DbUtil.close();
    return true;
  }
}

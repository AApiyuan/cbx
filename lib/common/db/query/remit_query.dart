part of '../sql_db.dart';

class RemitQuery {
  static String tableName = "remit";

  static Future<void> init(int? deptId) async {
    CustomerDeptOfflineReq req = new CustomerDeptOfflineReq();
    req.customerDeptId = deptId;
    req.type = OfflineTypeEnum.REMIT_METHOD;
    List<CustomerDeptOfflineDo> goods = await OfflineApi.selectCustomerDeptOffline(req);
    if (goods.length > 0) {
      CustomerDeptOfflineDo data = goods[0];
      String lastPullTime = await PullLogQuery.select(deptId as int, OfflineTypeEnum.REMIT_METHOD);
      //数据 包比较新
      if (lastPullTime == "") {
        //从未拉取过，要 拉取
        bool result = await pullRemitData(data.offlineFile as String, deptId);
        if (result) {
          await PullLogQuery.insert(deptId, OfflineTypeEnum.REMIT_METHOD, data.offlineTime as String);
        }
      } else {
        //数据库比较新也要拉取
        if (dbTestMode || DateUtil.getDateTime(data.offlineTime as String)!.isAfter(DateUtil.getDateTime(lastPullTime)!)) {
          bool result = await pullRemitData(data.offlineFile as String, deptId);
          if (result) {
            await PullLogQuery.update(deptId, OfflineTypeEnum.REMIT_METHOD, data.offlineTime as String);
          }
        }
      }
      dbDownload[deptId]?.add(tableName);
    }
  }

  static Future<bool> pullRemitData(String name, int deptId) async {
    String keyString = "0000000000000000";
    String dept = deptId.toString();
    keyString = keyString.replaceRange(16 - dept.length, 16, dept);
    var content = await OSSClient().getObjectData(name);
    String remitData = await readContents(content, keyString: keyString);
    List<StoreRemitMethodDo> data = jsonDecode(remitData).map<StoreRemitMethodDo>((e) => new StoreRemitMethodDo().fromJson(e)).toList();
    await delete(deptId: deptId);
    await batchInsert(data, deptId);
    return true;
  }

  static Future<bool> batchInsert(List<StoreRemitMethodDo> data, int deptId) async {
    await DbUtil.open();
    Batch batch = db!.batch();
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < data.length; i++) {
      map['id'] = data[i].id;
      map['deptId'] = deptId;
      map['topDeptId'] = data[i].deptId;
      map['remitMethodName'] = data[i].remitMethodName;
      batch.insert(tableName, map);
    }
    await batch.commit();
    await DbUtil.close();
    return true;
  }

  static Future<List<StoreRemitMethodDo>> select(int deptId) async {
    await DbUtil.open();
    var result = await db!.query(
      tableName,
      where: "deptId=?",
      whereArgs: [deptId],
    );

    await DbUtil.close();
    return result.map<StoreRemitMethodDo>((e) => new StoreRemitMethodDo().fromJson(e)).toList();
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

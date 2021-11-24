part of '../sql_db.dart';

class DeptConfigQuery {
  static String tableName = "config";

  static Future<void> init(int? deptId) async {
    CustomerDeptOfflineReq req = new CustomerDeptOfflineReq();
    req.customerDeptId = deptId;
    req.type = OfflineTypeEnum.DEPT_CONFIG;
    List<CustomerDeptOfflineDo> offlineData = await OfflineApi.selectCustomerDeptOffline(req);
    if (offlineData.length > 0) {
      CustomerDeptOfflineDo data = offlineData[0];
      String lastPullTime = await PullLogQuery.select(deptId as int, OfflineTypeEnum.DEPT_CONFIG);
      //数据 包比较新
      if (lastPullTime == "") {
        //从未拉取过，要 拉取
        bool result = await pullConfigData(data.offlineFile as String, deptId);
        if (result) {
          await PullLogQuery.insert(deptId, OfflineTypeEnum.DEPT_CONFIG, data.offlineTime as String);
        }
      } else {
        //数据库比较新也要拉取
        if (dbTestMode || DateUtil.getDateTime(data.offlineTime as String)!.isAfter(DateUtil.getDateTime(lastPullTime)!)) {
          bool result = await pullConfigData(data.offlineFile as String, deptId);
          if (result) {
            await PullLogQuery.update(deptId, OfflineTypeEnum.DEPT_CONFIG, data.offlineTime as String);
          }
        }
      }
      dbDownload[deptId]?.add(tableName);
    }
  }

  static Future<bool> pullConfigData(String name, int deptId) async {
    String keyString = "0000000000000000";
    String dept = deptId.toString();
    keyString = keyString.replaceRange(16 - dept.length, 16, dept);
    var content = await OSSClient().getObjectData(name);
    String configData = await readContents(content, keyString: keyString);
    List<CustomerDeptConfigDo> data = jsonDecode(configData).map<CustomerDeptConfigDo>((e) => new CustomerDeptConfigDo().fromJson(e)).toList();
    await delete(deptId: deptId);
    await batchInsert(data);
    return true;
  }

  static Future<bool> batchInsert(List<CustomerDeptConfigDo> data) async {
    await DbUtil.open();
    Batch batch = db!.batch();
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < data.length; i++) {
      map['id'] = data[i].id;
      map['deptId'] = data[i].deptId;
      map['groupType'] = data[i].groupType;
      map['configDateType'] = data[i].configDateType;
      map['configDate'] = jsonEncode(data[i].configDate);
      map['type'] = data[i].type;

      batch.insert(tableName, map);
    }
    await batch.commit();
    await DbUtil.close();
    return true;
  }

  static Future<List<CustomerDeptConfigDo>> select(int deptId, List<String> groupTypeList, {List<String>? typeList}) async {
    await DbUtil.open();

    var whereArgs = <Object>[];
    whereArgs.add(deptId);
    whereArgs.addAll(groupTypeList);
    /// 添加?
    var groupTypeWhere = <String>[];
    groupTypeList.forEach((element) => groupTypeWhere.add("?"));
    var groupTypeWhereBuffer = StringBuffer();
    groupTypeWhereBuffer.writeAll(groupTypeWhere, ",");

    var result;
    if (typeList?.isEmpty ?? true) {
      result = await db!.query(tableName, where: "deptId=? and groupType in (${groupTypeWhereBuffer.toString()})", whereArgs: whereArgs);
    } else {
      whereArgs.addAll(typeList!);
      /// 添加?
      var typeWhere = <String>[];
      typeList.forEach((element) => typeWhere.add("?"));
      var typeWhereBuffer = StringBuffer();
      typeWhereBuffer.writeAll(typeWhere, ",");

      result =
          await db!.query(tableName, where: "deptId=? and groupType in (${groupTypeWhereBuffer.toString()}) and type in (${typeWhereBuffer.toString()})", whereArgs: whereArgs);
    }

    await DbUtil.close();
    return result.map<CustomerDeptConfigDo>((e) => new CustomerDeptConfigDo().fromJson(e)).toList();
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

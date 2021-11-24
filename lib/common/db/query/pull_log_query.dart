part of '../sql_db.dart';

class PullLogQuery {
  static String tableName = "pull_log";

  static Future<int> insert(int deptId,String type, String time) async {
    await DbUtil.open();
    Map<String, dynamic> map = new Map();
    map['deptId'] = deptId;
    map['type'] = type;
    map['offlineTime'] = time;
    int value = await db!.insert(tableName, map);
    await DbUtil.close();
    return value;
  }

  static Future<int> update(int deptId,String type, String time) async {
    await DbUtil.open();
    Map<String, dynamic> map = new Map();
    map['offlineTime'] = time;
    int value = await db!.update(tableName, map, where: "deptId=? and type=?", whereArgs: [deptId,type]);
    await DbUtil.close();
    return value;
  }

  static Future<String> select(int deptId,String type) async {
    await DbUtil.open();
    Map<String, dynamic> map = new Map();
    map['type'] = type;
    List result = await db!.query(tableName, where: "deptId=? and type=?", whereArgs: [deptId,type]);
    await DbUtil.close();
    return result.length == 0 ? "" : result[0]['offlineTime'];
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

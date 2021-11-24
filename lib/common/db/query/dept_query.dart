part of '../sql_db.dart';

class DeptQuery {
  static String tableName = "dept";

  static List<String> list = [];

  static Future<void> init(int userId) async {
    _print("init");
    var req = DeptAndRelationReq();
    req.status = Status.ENABLE;
    req.returnRelation = false;
    req.returnRoleName = true;
    req.deptTypes = [
      CustomerDeptTypeEnum.SHOP_AND_STOREHOUSE,
      CustomerDeptTypeEnum.SHOP,
      CustomerDeptTypeEnum.STOREHOUSE
    ];
    _print("selectDept");
    // await deleteUserDept(userId);
    UserApi.selectDept(req).then((value) {
      // value.forEach((element) => checkOffline(element, userId));
      Future.wait(value.map((e) => checkOffline(e, userId)).toList())
          .then((value) => print("selectDept==================end=====$value"));
    });
  }

  static Future checkOffline(
      CustomerDeptDetailAndRoleDo deptDetail, int userId) async {
    _print("check_start===========${deptDetail.id}");
    // var req = new CustomerDeptOfflineReq();
    // req.customerDeptId = deptDetail.id;
    // OfflineApi.selectCustomerDeptOffline(req).then((value) {
    //   _print("${deptDetail.id}===${value.length}");
    //   if (value.isNotEmpty) {
    //     saveDept(deptDetail, userId);
    //     updateDepId(deptDetail.id);
    //   }
    // });
    if (checkOfflineDate(deptDetail.customerDeptDetailDo?.offlineExpiryDate,
        deptDetail.customerDeptDetailDo?.createdTime)) {
      await saveDept(deptDetail, userId);
      await updateDepId(deptDetail.id);
      _print("check_save===========${deptDetail.id}");
    } else {
      // await deleteDept(userId, deptDetail.id!);
    }
    _print("check_end===========${deptDetail.id}");
  }

  static saveDept(CustomerDeptDetailAndRoleDo deptDetail, int userId) async {
    _print("saveDept");
    await deleteDept(userId, deptDetail.id!);
    await DbUtil.open();
    Map<String, dynamic> map = new Map();
    map['userId'] = userId;
    map['deptId'] = deptDetail.id;
    map['detail'] = jsonEncode(deptDetail);
    list.add(deptDetail.name ?? "");
    await db!.insert(tableName, map);
    await DbUtil.close();
  }

  static Future<List<CustomerDeptDetailAndRoleDo>> selectUserDept(
      int userId) async {
    await DbUtil.open();
    List<Map<String, Object?>> result = await db!.query(
      tableName,
      where: "userId = ?",
      whereArgs: [userId],
    );
    await DbUtil.close();
    List<CustomerDeptDetailAndRoleDo> data = [];
    if (result.isNotEmpty) {
      result.forEach((element) {
        var item = CustomerDeptDetailAndRoleDo()
            .fromJson(jsonDecode(element['detail'] as String));
        if (checkOfflineDate(item.customerDeptDetailDo?.offlineExpiryDate,
            item.customerDeptDetailDo?.createdTime)) {
          data.add(item);
        }
      });
    }
    return data;
  }

  static Future<CustomerDeptDetailAndRoleDo> select(
      int userId, int deptId) async {
    await DbUtil.open();
    var result;
    result = await db!.query(
      tableName,
      where: "deptId = ? and userId = ?",
      whereArgs: [deptId, userId],
    );
    await DbUtil.close();
    var data = CustomerDeptDetailAndRoleDo();
    if (result.isNotEmpty) {
      data.fromJson(jsonDecode(result[0]['detail']));
    }
    return data;
  }

  static Future<bool> deleteUserDept(int userId) async {
    await DbUtil.open();
    await db!.delete(
      tableName,
      where: "userId = ?",
      whereArgs: [userId],
    );
    await DbUtil.close();
    return true;
  }

  static Future<bool> deleteDept(int userId, int deptId) async {
    await DbUtil.open();
    await db!.delete(
      tableName,
      where: "userId = ? and deptId = ?",
      whereArgs: [userId, deptId],
    );
    await DbUtil.close();
    return true;
  }

  static bool checkOfflineDate(String? offlineExpiryDate, String? createDate) {
    if (createDate == null) return false;
    var now = DateTime.now();
    var createTime = createDate.split(" ")[0].split("-");
    var create = DateTime(int.parse(createTime[0]), int.parse(createTime[1]),
        int.parse(createTime[2]) + 9);
    if (offlineExpiryDate == null) {
      return create.isAfter(now);
    }
    var offlineDate = offlineExpiryDate.split("-");
    var date = DateTime(int.parse(offlineDate[0]), int.parse(offlineDate[1]),
        int.parse(offlineDate[2]) - 1);
    var check = date.isAfter(now) || create.isAfter(now);
    return check;
  }

  static _print(dynamic obj) {
    print("flutter_tag=====dept_query=====" + obj);
  }

  static updateDepId(int? deptId) async {
    print("flutter_tag======updateDepId========$deptId");
    if (deptId != null) {
      print("flutter_tag======loadData");
      await loadData(deptId);
    }
  }
}

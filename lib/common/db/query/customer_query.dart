part of '../sql_db.dart';

class CustomerQuery {
  static String tableName = "customer";

  static Future<void> init(int? deptId) async {
    CustomerDeptOfflineReq req = new CustomerDeptOfflineReq();
    req.customerDeptId = deptId;
    req.type = OfflineTypeEnum.CUSTOMER;
    List<CustomerDeptOfflineDo> offlineData = await OfflineApi.selectCustomerDeptOffline(req);
    if (offlineData.length > 0) {
      CustomerDeptOfflineDo data = offlineData[0];
      String lastPullTime = await PullLogQuery.select(deptId as int, OfflineTypeEnum.CUSTOMER);
      //数据 包比较新
      if (lastPullTime == "") {
        //从未拉取过，要 拉取
        bool result = await pullCustomerData(data.offlineFile as String, deptId);
        if (result) {
          await PullLogQuery.insert(deptId, OfflineTypeEnum.CUSTOMER, data.offlineTime as String);
        }
      } else {
        //数据库比较新也要拉取
        if (dbTestMode || DateUtil.getDateTime(data.offlineTime as String)!.isAfter(DateUtil.getDateTime(lastPullTime)!)) {
          bool result = await pullCustomerData(data.offlineFile as String, deptId);
          if (result) {
            await PullLogQuery.update(deptId, OfflineTypeEnum.CUSTOMER, data.offlineTime as String);
          }
        }
      }
      dbDownload[deptId]?.add(tableName);
    }
  }

  static Future<bool> pullCustomerData(String name, int deptId) async {
    String keyString = "0000000000000000";
    String dept = deptId.toString();
    keyString = keyString.replaceRange(16 - dept.length, 16, dept);
    var content = await OSSClient().getObjectData(name);
    String customerData = await readContents(content, keyString: keyString);
    List<StoreCustomerListItemDoEntity> data = jsonDecode(customerData).map<StoreCustomerListItemDoEntity>((e) => new StoreCustomerListItemDoEntity().fromJson(e)).toList();
    await delete(deptId: deptId);
    await batchInsert(data);
    return true;
  }

  static Future<bool> batchInsert(List<StoreCustomerListItemDoEntity> data) async {
    await DbUtil.open();
    Batch batch = db!.batch();
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < data.length; i++) {
      map['id'] = data[i].id;
      map['deptId'] = data[i].deptId;
      map['merchandiserId'] = data[i].merchandiserId;
      map['managerUserName'] = data[i].managerUserName;
      map['customerName'] = data[i].customerName;
      map['customerNamePinYin'] = data[i].customerNamePinYin;
      map['customerPhone'] = data[i].customerPhone;
      map['customerNamePhone'] = data[i].customerNamePhone;
      map['star'] = data[i].star;
      map['levelTag'] = data[i].levelTag;
      map['userId'] = data[i].userId;
      map['offline'] = data[i].offline ?? 0;

      batch.insert(tableName, map);
    }
    await batch.commit();
    await DbUtil.close();
    return true;
  }

  static Future<StoreCustomerListItemDoEntity> getRetailStoreCustomer(int deptId) async {
    await DbUtil.open();
    var result = await db!.query(tableName, where: "deptId = ? and userId = ?", whereArgs: [deptId, -1]);
    await DbUtil.close();
    return result.map<StoreCustomerListItemDoEntity>((e) => new StoreCustomerListItemDoEntity().fromJson(e)).toList()[0];
  }

  static Future<List<StoreCustomerListItemDoEntity>> select({BasePage? basePage, int? id}) async {
    await DbUtil.open();
    var result;
    if (basePage != null && basePage.param != null) {
      StoreCustomerPageReqEntity param = basePage.param;
      String orderString = 'customerNamePinYin asc';
      if (param.orderBy != null) {
        orderString = param.orderBy.field + " " + param.orderBy.by;
      }
      if (param.customerNamePhone != null) {
        result = await db!.query(tableName,
            where: "deptId=? and customerNamePhone LIKE ?",
            whereArgs: [param.deptId, '%' + param.customerNamePhone.toString() + '%'],
            orderBy: orderString,
            limit: basePage.pageSize,
            offset: basePage.pageSize! * (basePage.pageNo! - 1));
      } else if (param.customerName != null) {
        result = await db!.query(tableName,
            where: 'deptId=? and customerName=?',
            whereArgs: [param.deptId, param.customerName]);
      } else {
        result = await db!.query(tableName,
            where: 'deptId=?',
            whereArgs: [param.deptId],
            orderBy: orderString,
            limit: basePage.pageSize,
            offset: basePage.pageSize! * (basePage.pageNo! - 1));
      }
    } else if (id != null) {
      result = await db!.query(tableName, where: "id=?", whereArgs: [id]);
    } else {
      result = await db!.query(tableName);
    }
    await DbUtil.close();
    return result.map<StoreCustomerListItemDoEntity>((e) => new StoreCustomerListItemDoEntity().fromJson(e)).toList();
  }

  static Future<bool> updateCustomerId(int newCustomerId, int deptId, int customerId) async {
    await DbUtil.open();
    await db!.update(tableName, {"id": newCustomerId, "offline": 0}, where: "deptId = ? and id = ?", whereArgs: [deptId, customerId]);
    await DbUtil.close();
    return true;
  }

  static Future<bool> delete({int? deptId, int? customerId}) async {
    await DbUtil.open();
    if (deptId != null && customerId != null) {
      await db!.delete(tableName, where: "deptId = ? and id = ?", whereArgs: [deptId, customerId]);
    } else if (deptId != null) {
      await db!.delete(tableName, where: "deptId = ?", whereArgs: [deptId]);
    } else {
      await db!.delete(tableName);
    }
    await DbUtil.close();
    return true;
  }
}

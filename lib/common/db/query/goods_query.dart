part of '../sql_db.dart';

class GoodsQuery {
  static String tableName = "goods";

  static Future<void> init(int? deptId) async {
    CustomerDeptOfflineReq req = new CustomerDeptOfflineReq();
    req.customerDeptId = deptId;
    req.type = OfflineTypeEnum.GOODS;
    List<CustomerDeptOfflineDo> goods = await OfflineApi.selectCustomerDeptOffline(req);
    if (goods.length > 0) {
      CustomerDeptOfflineDo data = goods[0];
      String lastPullTime = await PullLogQuery.select(deptId as int, OfflineTypeEnum.GOODS);
      //数据 包比较新
      if (lastPullTime == "") {
        //从未拉取过，要 拉取
        bool result = await pullGoodsData(data.offlineFile as String, deptId);
        if (result) {
          await PullLogQuery.insert(deptId, OfflineTypeEnum.GOODS, data.offlineTime as String);
        }
      } else {
        //数据库比较新也要拉取
        if (dbTestMode || DateUtil.getDateTime(data.offlineTime as String)!.isAfter(DateUtil.getDateTime(lastPullTime)!)) {
          bool result = await pullGoodsData(data.offlineFile as String, deptId);
          if (result) {
            await PullLogQuery.update(deptId, OfflineTypeEnum.GOODS, data.offlineTime as String);
          }
        }
      }
      dbDownload[deptId]?.add(tableName);
    }
  }

  static Future<bool> pullGoodsData(String name, int deptId) async {
    String keyString = "0000000000000000";
    String dept = deptId.toString();
    keyString = keyString.replaceRange(16 - dept.length, 16, dept);
    var content = await OSSClient().getObjectData(name);
    String goodsData = await readContents(content, keyString: keyString);
    List<Goods> data = jsonDecode(goodsData).map<Goods>((e) => new Goods().fromJson(e)).toList();
    await delete(deptId: deptId);
    await batchInsert(data, deptId);
    return true;
  }

  static Future<bool> batchInsert(List<Goods> data, int deptId) async {
    await DbUtil.open();
    Batch batch = db!.batch();
    Map<String, dynamic> map = new Map();
    for (int i = 0; i < data.length; i++) {
      print("flutter_tag=====goods=====$deptId=====${data[i].id}");
      map['id'] = data[i].id;
      map['deptId'] = deptId;
      map['topDeptId'] = data[i].deptId;
      map['goodsName'] = data[i].goodsName;
      map['goodsSerial'] = data[i].goodsSerial;
      map['goodsNameSerial'] = data[i].goodsName == null ? (data[i].goodsName! + "-" + data[i].goodsSerial!) : data[i].goodsSerial;
      map['sailingPrice'] = data[i].sailingPrice;
      map['takingPrice'] = data[i].takingPrice;
      map['packagePrice'] = data[i].packagePrice;
      map['costPrice'] = data[i].costPrice;
      map['imgPath'] = data[i].imgPath;
      map['cover'] = data[i].cover;
      map['sku'] = jsonEncode(data[i].storeGoodsSkuList);
      batch.insert(tableName, map);
    }
    await batch.commit();
    await DbUtil.close();
    return true;
  }

  static Future<int> insert(Goods data, int deptId) async {
    await DbUtil.open();
    Map<String, dynamic> map = new Map();
    map['id'] = data.id;
    map['deptId'] = deptId;
    map['topDeptId'] = data.deptId;
    map['goodsName'] = data.goodsName;
    map['goodsSerial'] = data.goodsSerial;
    map['goodsNameSerial'] = data.goodsName == null ? (data.goodsName! + "-" + data.goodsSerial!) : data.goodsSerial;
    map['sailingPrice'] = data.sailingPrice;
    map['takingPrice'] = data.takingPrice;
    map['packagePrice'] = data.packagePrice;
    map['costPrice'] = data.costPrice;
    map['imgPath'] = data.imgPath;
    map['cover'] = data.cover;
    map['sku'] = jsonEncode(data.storeGoodsSkuList);
    int value = await db!.insert(tableName, map);
    await DbUtil.close();
    return value;
  }

  static Future<List<Goods>> select({BasePage? basePage}) async {
    await DbUtil.open();
    var result;
    if (basePage != null && basePage.param != null) {
      GoodsPageParam param = basePage.param;
      if (param.goodsNameSerial != null) {
        result = await db!.query(tableName,
            where: "deptId=? and goodsNameSerial LIKE ?",
            whereArgs: [param.deptId, '%' + param.goodsNameSerial.toString() + '%'],
            limit: basePage.pageSize,
            offset: basePage.pageSize! * (basePage.pageNo! - 1));
      } else {
        result = await db!.query(tableName,
            where: 'deptId=?', whereArgs: [param.deptId], limit: basePage.pageSize, offset: basePage.pageSize! * (basePage.pageNo! - 1));
      }
    } else {
      result = await db!.query(tableName);
    }
    await DbUtil.close();
    return result.map<Goods>((e) => new Goods().fromJson(e)).toList();
  }

  //获取sku
  static Future<List<SkuInfoEntity>> sku(int deptId, int goodsId) async {
    await DbUtil.open();
    List result = await db!.query(tableName, where: "deptId =? and id = ?", whereArgs: [deptId, goodsId], columns: ['sku']);
    if (result.length > 0) {
      return jsonDecode(result[0]['sku']).map<SkuInfoEntity>((e) => new SkuInfoEntity().fromJson(e)).toList();
    }
    await DbUtil.close();
    return [];
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

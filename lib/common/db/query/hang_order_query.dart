import 'dart:convert';

import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleBeforeReq.dart';
import 'package:haidai_flutter_module/common/sale/dto/CreateSaleReq.dart';
import 'package:haidai_flutter_module/common/sale/enums/SaleTypeEnum.dart';
import 'package:haidai_flutter_module/common/sale/util/EnumCoverUtils.dart';
import 'package:haidai_flutter_module/common/utils/time_utils.dart';
import 'package:haidai_flutter_module/model/store/res/store_remit_method_do.dart';
import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';
import 'package:haidai_flutter_module/page/sale/controller/offline_gathering_controller.dart';
import 'package:haidai_flutter_module/page/sale/controller/sale_enter_controller.dart';
import 'package:haidai_flutter_module/page/sale/model/hang_order_model.dart';
import 'package:haidai_flutter_module/page/sale/model/offline_gathering_order_model.dart';
import 'package:haidai_flutter_module/page/sale/model/sale_detail_do_entity.dart';
import 'package:sqflite/sqflite.dart';

import '../sql_db.dart';

class HangOrderQuery {
  static String tableName = "hang_order";

  static Future<int> insert(
      CreateSaleReq? saleReq,
      CreateSaleBeforeReq? saleBeforeReq,
      StoreCustomerListItemDoEntity? customer,
      Map<String, List<SaleDetailDoSaleGoodsList>> goodsData,
      Map<String, Map<int, List>> skuMap,
      int type) async {
    await DbUtil.open();
    Map<String, dynamic> map = new Map();
    map['id'] = DateTime.now().millisecondsSinceEpoch;
    goodsData.forEach((key, value) {
      if (key == EnumCoverUtils.enumsToString(SaleTypeEnum.NORMAL_SALE)) {
        map['saleGoodsList'] = jsonEncode(value);
      } else if (key ==
          EnumCoverUtils.enumsToString(SaleTypeEnum.CHANGE_BACK_ORDER)) {
        map['oweGoodsList'] = jsonEncode(value);
      } else {
        map['returnGoodsList'] = jsonEncode(value);
      }
    });
    skuMap.forEach((key, value) {
      var goodsSkuList = <GoodsSkuModel>[];
      value.forEach((key, value) {
        var model = GoodsSkuModel();
        model.key = key;
        model.skuList = value;
        goodsSkuList.add(model);
      });
      if (key == EnumCoverUtils.enumsToString(SaleTypeEnum.NORMAL_SALE)) {
        map['saleGoodsSku'] = jsonEncode(goodsSkuList);
      } else if (key ==
          EnumCoverUtils.enumsToString(SaleTypeEnum.CHANGE_BACK_ORDER)) {
        map['oweGoodsSku'] = jsonEncode(goodsSkuList);
      } else {
        map['returnGoodsSku'] = jsonEncode(goodsSkuList);
      }
    });
    map['saleReq'] = jsonEncode(saleReq);
    map['saleBeforeReq'] = jsonEncode(saleBeforeReq);
    map['type'] = type;
    map['deptId'] = type == SaleEnterController.TYPE_QUOTATION
        ? saleBeforeReq?.deptId
        : saleReq?.deptId;
    map['userId'] = Config.userId;
    map['customerId'] = customer?.id;
    map['customer'] = jsonEncode(customer);
    map['updateTime'] = TimeUtils.getNow();
    int value = await db!.insert(tableName, map);
    await DbUtil.close();
    return value;
  }

  static Future<int> insertOfflineGathering(
      Map<int, double> remitAmountMap,
      Map<int, StoreRemitMethodDo> remitMethodMap,
      StoreCustomerListItemDoEntity? customer,
      int deptId,
      OfflineGatheringOrderModel req) async {
    await DbUtil.open();
    Map<String, dynamic> map = new Map();
    map['id'] = DateTime.now().millisecondsSinceEpoch;
    map['offlineGatheringOrder'] = jsonEncode(req);
    map['type'] = OfflineGatheringController.TYPE_OFFLINE_GATHERING;
    map['deptId'] = deptId;
    map['userId'] = Config.userId;
    map['customerId'] = customer?.id;
    map['customer'] = jsonEncode(customer);
    map['updateTime'] = TimeUtils.getNow();
    var amountStringKey = <String, double>{};
    remitAmountMap.forEach((key, value) => amountStringKey["$key"] = value);
    map['remitAmountMap'] = jsonEncode(amountStringKey);
    var methodStringKey = <String, StoreRemitMethodDo>{};
    remitMethodMap.forEach((key, value) => methodStringKey["$key"] = value);
    map['remitMethodMap'] = jsonEncode(methodStringKey);
    int value = await db!.insert(tableName, map);
    await DbUtil.close();
    return value;
  }

  static Future<bool> delete({int? id}) async {
    await DbUtil.open();
    if (id != null) {
      await db!.delete(tableName, where: "id = ?", whereArgs: [id]);
    } else {
      await db!.delete(tableName);
    }
    await DbUtil.close();
    return true;
  }

  static Future<List<HangOrderModel>> getHangOrderList(int deptId,
      {int? customerId, int? type}) async {
    await DbUtil.open();
    var result;
    if (customerId != null && type != null) {
      result = await db!.query(
        tableName,
        where: "deptId = ? and customerId = ? and type = ? and userId = ?",
        whereArgs: [deptId, customerId, type, Config.userId],
        orderBy: "id DESC",
      );
    } else if (customerId != null) {
      result = await db!.query(
        tableName,
        where: 'deptId = ? and customerId = ? and userId = ?',
        whereArgs: [deptId, customerId, Config.userId],
        orderBy: "id DESC",
      );
    } else if (type != null) {
      result = await db!.query(
        tableName,
        where: 'deptId = ? and type = ? and userId = ?',
        whereArgs: [deptId, type, Config.userId],
        orderBy: "id DESC",
      );
    } else {
      result = await db!.query(
        tableName,
        where: "deptId = ? and userId = ?",
        whereArgs: [deptId, Config.userId],
        orderBy: "id DESC",
      );
    }
    await DbUtil.close();
    return result
        .map<HangOrderModel>((e) => new HangOrderModel().fromJson(e))
        .toList();
  }

  static Future<HangOrderModel> getHangOrder(int id) async {
    await DbUtil.open();
    var result;
    result = await db!.query(tableName, where: "id = ?", whereArgs: [id]);
    await DbUtil.close();
    return result
        .map<HangOrderModel>((e) => new HangOrderModel().fromJson(e))
        .toList()[0];
  }

  static Future<bool> updateCustomer(int deptId, int customerId) async {
    var orders = await getHangOrderList(deptId, customerId: customerId);
    var customer = await CustomerQuery.select(id: customerId).then((value) => value[0]);
    await DbUtil.open();
    Batch batch = db!.batch();
    orders.forEach((element) {
      batch.update(tableName, toMap(element, customer), where: "id = ?", whereArgs: [element.id]);
    });
    batch.commit();
    await DbUtil.close();
    return true;
  }

  static toMap(HangOrderModel element, StoreCustomerListItemDoEntity customer) {
    if (element.type == OfflineGatheringController.TYPE_OFFLINE_GATHERING) {
      return offlineGatheringMap(element, customer);
    } else {
      return saleOrderMap(element, customer);
    }
  }

  static offlineGatheringMap(HangOrderModel element, StoreCustomerListItemDoEntity customer) {
    Map<String, dynamic> map = new Map();
    map['id'] = element.id;
    map['offlineGatheringOrder'] = jsonEncode(element.offlineGatheringOrderModel);
    map['type'] = OfflineGatheringController.TYPE_OFFLINE_GATHERING;
    map['deptId'] = element.deptId;
    map['customerId'] = customer.id;
    map['customer'] = jsonEncode(customer);
    map['updateTime'] = element.updateTime;
    map['userId'] = element.userId;
    var amountStringKey = <String, double>{};
    element.remitAmountMap?.forEach((key, value) => amountStringKey["$key"] = value);
    map['remitAmountMap'] = jsonEncode(amountStringKey);
    var methodStringKey = <String, StoreRemitMethodDo>{};
    element.remitMethodMap?.forEach((key, value) => methodStringKey["$key"] = value);
    map['remitMethodMap'] = jsonEncode(methodStringKey);
    return map;
  }

  static saleOrderMap(HangOrderModel element, StoreCustomerListItemDoEntity customer) {
    Map<String, dynamic> map = new Map();
    map['id'] = element.id;
    map['saleGoodsList'] = jsonEncode(element.saleGoodsList);
    map['oweGoodsList'] = jsonEncode(element.oweGoodsList);
    map['returnGoodsList'] = jsonEncode(element.returnGoodsList);
    var skuMap = <String, Map<int, List>>{};
    skuMap[EnumCoverUtils.enumsToString(SaleTypeEnum.NORMAL_SALE)!] = element.saleGoodsSku ?? {};
    skuMap[EnumCoverUtils.enumsToString(SaleTypeEnum.CHANGE_BACK_ORDER)!] = element.oweGoodsSku ?? {};
    skuMap[EnumCoverUtils.enumsToString(SaleTypeEnum.RETURN_GOODS)!] = element.returnGoodsSku ?? {};
    skuMap.forEach((key, value) {
      var goodsSkuList = <GoodsSkuModel>[];
      value.forEach((key, value) {
        var model = GoodsSkuModel();
        model.key = key;
        model.skuList = value;
        goodsSkuList.add(model);
      });
      if (key == EnumCoverUtils.enumsToString(SaleTypeEnum.NORMAL_SALE)) {
        map['saleGoodsSku'] = jsonEncode(goodsSkuList);
      } else if (key ==
          EnumCoverUtils.enumsToString(SaleTypeEnum.CHANGE_BACK_ORDER)) {
        map['oweGoodsSku'] = jsonEncode(goodsSkuList);
      } else {
        map['returnGoodsSku'] = jsonEncode(goodsSkuList);
      }
    });
    // map['saleGoodsSku'] = jsonEncode(element.saleGoodsSku);
    // map['oweGoodsSku'] = jsonEncode(element.oweGoodsSku);
    // map['returnGoodsSku'] = jsonEncode(element.returnGoodsSku);
    map['saleReq'] = jsonEncode(element.saleReq);
    map['saleBeforeReq'] = jsonEncode(element.saleBeforeReq);
    map['type'] = element.type;
    map['deptId'] = element.deptId;
    map['userId'] = element.userId;
    map['customerId'] = customer.id;
    map['customer'] = jsonEncode(customer);
    map['updateTime'] = element.updateTime;
    return map;
  }
}

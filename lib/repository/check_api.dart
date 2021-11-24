import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/checkCenter/inventory_do_entity.dart';
import 'package:haidai_flutter_module/model/checkCenter/inventory_history_entity.dart';
import 'package:haidai_flutter_module/model/checkCenter/inventory_member_do.dart';
import 'package:haidai_flutter_module/model/checkCenter/inventory_record_item_do_entity.dart';

class CheckApi {
  static final String inventoryHistory = "order/inventory/history";
  static final String inventoryDetail = "order/inventory/detail";
  static final String inventoryCenter = "order/inventory/center";
  static final String inventoryRecordList = "order/inventory/record/list";
  static final String inventoryRecordCreate = "order/inventory/create";
  static final String inventoryRecordImg = "order/inventory/record/img";
  static final String inventoryCancel = "order/inventory/cancel";
  static final String inventoryFinish = "order/inventory/finish";
  static final String inventoryStatistic = "/order/inventory/record/statistic";

  static Future<List<InventoryHistoryEntity>> checkHistory(
      dynamic param) async {
    var res = await HttpUtils.post(inventoryHistory,
        data: param, baseUrl: Config.ORDER_API_URL);
    return res
        .map<InventoryHistoryEntity>(
            (e) => new InventoryHistoryEntity().fromJson(e))
        .toList();
  }

  static Future<InventoryDoEntity> checkCenter(num? deptId) async {
    var res = await HttpUtils.get(inventoryCenter,
        params: {"deptId": deptId}, baseUrl: Config.ORDER_API_URL);
    //if (res == null) return null;
    return new InventoryDoEntity().fromJson(res);
  }

  static Future<InventoryDoEntity> checkDetail(num? id) async {
    var res = await HttpUtils.get(inventoryDetail,
        params: {"id": id}, baseUrl: Config.ORDER_API_URL);
    return new InventoryDoEntity().fromJson(res);
  }

  ///创建盘点任务 v0.7.0
  static Future<int> checkRecordCreate(dynamic param) async {
    var res = await HttpUtils.post(inventoryRecordCreate,
        data: param, baseUrl: Config.ORDER_API_URL);
    return res;
  }

  ///修改盘次图片 v0.7.0
  static Future<bool> checkRecordImg(dynamic param) async {
    var res = await HttpUtils.post(inventoryRecordImg,
        data: param, baseUrl: Config.ORDER_API_URL);
    return res;
  }

  ///调整并结束盘点计划 v0.7.0
  static Future<bool> checkFinish(dynamic param) async {
    var res = await HttpUtils.post(inventoryFinish,
        data: param, baseUrl: Config.ORDER_API_URL, showLoading: true);
    return res;
  }

  ///获取单个人的盘点记录列表 v0.7.0
  static Future<List<InventoryRecordItemDoEntity>> checkRecordList(
      num inventoryId, num userId, String? orderGoodsType) async {
    var res = await HttpUtils.get(inventoryRecordList,
        params: {
          "inventoryId": inventoryId,
          "userId": userId,
          "orderGoodsType": orderGoodsType
        },
        baseUrl: Config.ORDER_API_URL);
    return res
        .map<InventoryRecordItemDoEntity>(
            (e) => new InventoryRecordItemDoEntity().fromJson(e))
        .toList();
  }

  ///撤销盘点计划 v0.7.0
  static Future<bool> checkCancel(int id) async {
    var res = await HttpUtils.get(inventoryCancel,
        params: {"id": id}, baseUrl: Config.ORDER_API_URL);
    return res;
  }

  /// 获取单个人的盘点记录列表的统计 v0.7.0
  static Future<InventoryMemberDo> getInventoryMember(
      num inventoryId, num userId, String? orderGoodsType) async {
    var res = await HttpUtils.get(inventoryStatistic,
        params: {
          "inventoryId": inventoryId,
          "userId": userId,
          "orderGoodsType": orderGoodsType
        },
        baseUrl: Config.ORDER_API_URL);
    return new InventoryMemberDo().fromJson(res);
  }
}

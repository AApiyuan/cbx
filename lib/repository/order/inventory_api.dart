import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/enter/inventory_record_create_req_entity.dart';
import 'package:haidai_flutter_module/model/enter/order_goods_vo_entity.dart';
import 'package:haidai_flutter_module/model/rep/inventory_goods_sku_req_entity.dart';
import 'package:haidai_flutter_module/model/rep/inventory_record_do_entity.dart';
import 'package:haidai_flutter_module/model/rep/inventory_record_update_req_entity.dart';

class InventoryApi {
  /// 创建盘点记录 v0.7.0
  static final String inventoryRecordCreate = "/order/inventory/record/create";

  /// 修改盘点记录 v0.7.0
  static final String inventoryRecordUpdate = "/order/inventory/record/update";

  /// 查看货品sku和账面库存，这里在选择货品盘点 或查看库存快照 这个是全sku 的时候调用 v0.7.0
  static final String inventorySnapGoodsSku = "/order/inventory/snap/goods/sku";

  /// 查看盘点记录详情（货品） v0.7.0
  static final String inventoryRecordDetail = "/order/inventory/record/detail";

  /// 删除盘点单记录 v0.7.0
  static final String inventoryRecordDelete = "/order/inventory/record/delete";

  ///完成盘点计划，等待调整 v0.7.0
  static final String inventoryComplete = "/order/inventory/complete";

  static Future<dynamic> createInventoryRecord(InventoryRecordCreateReqEntity param) async {
    var res = await HttpUtils.post(inventoryRecordCreate,
        data: param, baseUrl: Config.ORDER_API_URL);
    return res;
  }

  static Future<dynamic> updateInventoryRecord(InventoryRecordUpdateReqEntity param) async {
    var res = await HttpUtils.post(inventoryRecordUpdate,
        data: param, baseUrl: Config.ORDER_API_URL);
    return res;
  }

  static Future<List<OrderGoodsVoEntity>> getInventoryGoodsSku(
      InventoryGoodsSkuReqEntity param, {bool showLoad = false}) async {
    var res = await HttpUtils.post(inventorySnapGoodsSku,
        data: param, baseUrl: Config.ORDER_API_URL, showLoading: showLoad);
    return res
        .map<OrderGoodsVoEntity>((e) => new OrderGoodsVoEntity().fromJson(e))
        .toList();
  }

  static Future<InventoryRecordDoEntity> getInventoryOrderDetail(
      num recordId,{bool getAllSku = false}) async {
    var res = await HttpUtils.get(inventoryRecordDetail,
        params: {"inventoryRecordId": recordId, "getAllSku":getAllSku}, baseUrl: Config.ORDER_API_URL, showLoading: true);
    return new InventoryRecordDoEntity().fromJson(res);
  }

  static Future<bool> deleteInventoryOrder(
      num recordId) async {
    var res = await HttpUtils.get(inventoryRecordDelete,
        params: {"id": recordId}, baseUrl: Config.ORDER_API_URL);
    return res;
  }

  static Future<bool> inventoryOrderComplete(
      int orderInventoryId) async {
    var res = await HttpUtils.get(inventoryComplete,
        params: {"orderInventoryId": orderInventoryId}, baseUrl: Config.ORDER_API_URL);
    return res;
  }
}

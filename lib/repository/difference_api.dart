import 'package:haidai_flutter_module/common/config/config.dart';
import 'package:haidai_flutter_module/common/http/http_utils.dart';
import 'package:haidai_flutter_module/model/inventory_report_entity.dart';
import 'package:haidai_flutter_module/model/inventory_report_goods.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';

class DifferenceApi {
  /// 查看盘点差异报告 v0.7.0
  static final String inventoryReport = "/order/inventory/report";

  /// 查看差异报告中的盘点货品 v0.7.0
  static final String inventoryReportGoods = "/order/inventory/report/goods";

  /// 查看盘次货品的sku v0.7.0
  static final String inventoryRecordGoodsSku =
      "/order/inventory/report/goods/sku";

  static Future<InventoryReportEntity> getInventoryReport(num id) async {
    var res = await HttpUtils.get(inventoryReport,
        baseUrl: Config.ORDER_API_URL, params: {"id": id});
    return new InventoryReportEntity().fromJson(res);
  }

  static Future<List<InventoryReportGoods>> getInventoryReportGoods(
      dynamic param, {bool showLoading = false}) async {
    var res = await HttpUtils.post(inventoryReportGoods,
        baseUrl: Config.ORDER_API_URL, data: param, showLoading: showLoading);
    return res
        .map<InventoryReportGoods>(
            (e) => new InventoryReportGoods().fromJson(e))
        .toList();
  }

  static Future<List<SkuInfoEntity>> getInventoryRecordGoodsSku(
      dynamic param) async {
    var res = await HttpUtils.post(inventoryRecordGoodsSku,
        baseUrl: Config.ORDER_API_URL, data: param, showLoading: true);
    return res
        .map<SkuInfoEntity>((e) => new SkuInfoEntity().fromJson(e))
        .toList();
  }
}

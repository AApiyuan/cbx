import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/enum/order_stock_goods_type.dart';
import 'package:haidai_flutter_module/model/inventory_report_entity.dart';
import 'package:haidai_flutter_module/repository/difference_api.dart';

class DifferenceController extends GetxController {
  var _data = InventoryReportEntity();
  final _showSearchText = false.obs;
  final _showSearchClear = false.obs;

  final int _id = ArgUtils.getArgument2num('id') as int;

  /// 显示/隐藏清除
  void showOrHideClear(bool visible) {
    _showSearchClear.value = visible;
  }

  bool clearButtonVisible() {
    return _showSearchClear.value;
  }

  /// 显示/隐藏 搜索取消
  void showOrHideCancel({hasFocus = false}) {
    _showSearchText.value = hasFocus;
  }

  bool cancelTextVisible() {
    return _showSearchText.value;
  }

  DifferenceController(this.type) : super();

  final String type;

  /// 是否正品
  bool isNormal() => type == OrderStockGoodsTypeEnum.NORMAL;

  /// 快照时间
  String getTime() => _data.createdTime ?? "";

  /// 账面总库存款数
  int getTotalGoodsStyleNum() {
    return isNormal()
        ? _data.totalGoodsStyleNum ?? 0
        : _data.totalSubstandardStyleNum ?? 0;
  }

  /// 账面总库存商品数
  int getTotalGoodsNum() {
    return isNormal() ? _data.totalGoodsNum ?? 0 : _data.totalSubstandardNum ?? 0;
  }

  /// 总盈亏数
  int getTotalInventoryNum() {
    return isNormal()
        ? _data.totalInventoryNum ?? 0
        : _data.totalSubstandardInventoryNum ?? 0;
  }

  /// 已盘标题
  String alreadyTaskStockTitle() {
    return isNormal() ? "正品已盘" : "次品已盘";
  }

  /// 未盘标题
  String notYeTaskStockTitle() {
    return isNormal() ? "正品未盘" : "次品未盘";
  }

  /// 实盘款数
  int getInventoryStyleNum() {
    return isNormal()
        ? _data.inventoryStyleNum ?? 0
        : _data.substandardInventoryStyleNum ?? 0;
  }

  /// 未盘款数
  int getNoInventoryStyleNum() {
    return isNormal()
        ? _data.noInventoryStyleNum ?? 0
        : _data.substandardNoInventoryStyleNum ?? 0;
  }

  /// 实盘数量
  int getInventoryNum() {
    return isNormal()
        ? _data.inventoryNum?.abs() ?? 0
        : _data.substandardInventoryNum?.abs() ?? 0;
  }

  /// 盘盈款数
  int getProfitStyleNum() {
    return isNormal()
        ? _data.profitNormalStyleNum ?? 0
        : _data.profitSubstandardStyleNum ?? 0;
  }

  /// 盘盈数量
  int getProfitNum() {
    return isNormal() ? _data.profitNormalNum ?? 0 : _data.profitSubstandardNum ?? 0;
  }

  /// 盘亏款数
  int getLossStyleNum() {
    return isNormal()
        ? _data.lossNormalStyleNum ?? 0
        : _data.lossSubstandardStyleNum ?? 0;
  }

  /// 盘亏数量
  int getLossNum() {
    return isNormal()
        ? _data.lossNormalNum?.abs() ?? 0
        : _data.lossSubstandardNum?.abs() ?? 0;
  }

  /// 未盘盘盈款数
  int getNoProfitStyleNum() {
    return isNormal()
        ? _data.noProfitNormalStyleNum?.abs() ?? 0
        : _data.noProfitSubstandardStyleNum?.abs() ?? 0;
  }

  /// 未盘盘盈数量
  int getNoProfitNum() {
    return isNormal()
        ? _data.noProfitNormalNum?.abs() ?? 0
        : _data.noProfitSubstandardNum?.abs() ?? 0;
  }

  /// 未盘盘亏款数
  int getNoLossStyleNum() {
    return isNormal()
        ? _data.noLossNormalStyleNum?.abs() ?? 0
        : _data.noLossSubstandardStyleNum?.abs() ?? 0;
  }

  /// 未盘盘亏数量
  int getNoLossNum() {
    return isNormal()
        ? _data.noLossNormalNum?.abs() ?? 0
        : _data.noLossSubstandardNum?.abs() ?? 0;
  }

  /// 获取差异报告
  Future getInventoryReport() async {
    return await DifferenceApi.getInventoryReport(_id).then((value) {
      _data = value;
      update();
    });
  }
}

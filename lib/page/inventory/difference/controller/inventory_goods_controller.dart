import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/model/enum/is_inventory.dart';
import 'package:haidai_flutter_module/model/inventory_report_goods.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/inventory_goods_sku.dart';
import 'package:haidai_flutter_module/model/sku_info_entity.dart';
import 'package:haidai_flutter_module/page/inventory/difference/controller/filter_controller.dart';
import 'package:haidai_flutter_module/repository/difference_api.dart';

/// 查看差异 - 商品 controller
class InventoryGoodsController extends GetxController {
  InventoryGoodsController(
    this.type,
  ) : super();

  Map<String, bool> expandState = Map();

  final String type;

  /// 盘点是否展开
  bool isExpand(int goodsId) {
    String key = "$type-$goodsId";
    final expand = expandState[key];
    return expand != null && expand;
  }

  /// 修改展开状态
  void changeExpandStatus(int goodsId) {
    String key = "$type-$goodsId";
    final expand = expandState[key];
    expandState[key] = expand == null ? true : !expand;
    update([key, UPDATE_BLANK_HEIGHT]);
  }

  static const String UPDATE_ID = "update_inventory_goods_list";
  static const String UPDATE_BLANK_HEIGHT = "update_blank_height";
  static const String UPDATE_IS_INVENTORY = "is_inventory";

  /// 盘点任务id
  final int id = ArgUtils.getArgument2num('id') as int;

  /// 店铺 id
  final int deptId = ArgUtils.getArgument2num('deptId') as int;

  /// 已盘未盘,IsInventoryEnum[NO(未盘),YES(已盘),value,desc]
  String isInventoryEnum = IsInventoryEnum.YES;

  int _pageNo = 1; //页码

  int _pageSize = 20; //页数

  List<InventoryReportGoods> goods = <InventoryReportGoods>[]; // 商品

  Map<String, List<SkuInfoEntity>> goodsSku = Map(); // 商品sku

  bool noMore = false; //是否需要加载更多

  Future getInventoryReportGoods({bool showLoading = false}) async {
    if (!noMore) {
      BasePage page = new BasePage();
      page.pageSize = _pageSize;
      page.pageNo = _pageNo;
      page.param = Get.find<FilterController>(tag: type)
          .getFilterCondition(id, type, isInventoryEnum);
      List<InventoryReportGoods> list =
          await DifferenceApi.getInventoryReportGoods(page,
              showLoading: showLoading);
      if (list.length != 0) {
        goods.addAll(list);
      }
      if (list.length == _pageSize) {
        _pageNo++;
      }
      noMore = list.length == 0 || list.length < _pageSize;
      update([UPDATE_ID, UPDATE_BLANK_HEIGHT]);
    }
  }

  void changeTaskStockType(String type) {
    if (isInventoryEnum == type) {
      return;
    }
    isInventoryEnum = type;
    update([UPDATE_IS_INVENTORY]);
    reset(showLoading: true);
  }

  Future reset({bool showLoading = false}) async {
    goods.clear();
    _pageNo = 1;
    noMore = false;
    goodsSku.clear();
    expandState.clear();
    getInventoryReportGoods(showLoading: showLoading);
  }

  void getInventoryRecordGoodsSku(int goodsId) {
    final skuList = goodsSku["$type-$goodsId"];
    if (isExpand(goodsId) || skuList != null) {
      changeExpandStatus(goodsId);
    } else {
      InventoryGoodsSku param = InventoryGoodsSku();
      param.orderInventoryId = id;
      param.goodsId = goodsId;
      param.getAllSku = false;
      param.orderGoodsType = type;
      param.getAllSku = true;
      DifferenceApi.getInventoryRecordGoodsSku(param).then((value) {
        goodsSku["$type-$goodsId"] = value;
        changeExpandStatus(goodsId);
      });
    }
  }
}

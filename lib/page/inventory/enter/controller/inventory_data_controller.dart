import 'package:get/get.dart';
import 'package:haidai_flutter_module/model/enter/inventory_sku_do_entity.dart';
import 'package:haidai_flutter_module/model/enum/order_stock_goods_type.dart';
import 'package:haidai_flutter_module/model/rep/inventory_record_do_entity.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/goods_sku_dialog.dart';
import 'package:haidai_flutter_module/repository/order/inventory_api.dart';

class InventoryDataController extends SuperController {
  static const idSearchClear = "idSearchClear";
  static const idSearchClose = "idSearchClose";
  static const idGoodsList = "idGoodsList";

  static idGoodsFlex(int orderGoodsId) => "idGoodsFlex$orderGoodsId";

  final int orderId;

  List dataList = [];
  List _orderGoodsList = [];

  Map<int, bool> goodsFlexMap = {};
  Map<int, int> goodsSkuCountMap = {};
  Map<int, List<SkuData>> goodsSkuMap = {};

  var isSearch = false;
  var isSubstandard = false;

  InventoryDataController(this.orderId);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadGoods();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  searchGoods(String text) {
    dataList.clear();
    if (text == "") {
      dataList.addAll(_orderGoodsList);
    } else {
      _orderGoodsList.forEach((element) {
        if (element is InventoryRecordGoods) {
          goodsFlexMap[element.id!] = false;
          if ((element.storeGoodsBaseDo.goodsName?.contains(text) ?? false) ||
              (element.storeGoodsBaseDo.goodsSerial?.contains(text) ?? false)) {
            dataList.add(element);
          }
        }
      });
    }
    update([idGoodsList]);
  }

  openSearch() {
    isSearch = true;
    update([idSearchClose]);
  }

  closeSearch() {
    isSearch = false;
    update([idSearchClose]);
    searchGoods("");
  }

  changeFlex(int orderGoodsId) {
    goodsFlexMap[orderGoodsId] = !(goodsFlexMap[orderGoodsId] ?? false);
    var index = dataList.indexWhere((element) =>
        element is InventoryRecordGoods && element.id == orderGoodsId);
    if (goodsFlexMap[orderGoodsId]!) {
      dataList.insert(index + 1, "skuBar$orderGoodsId");
      dataList.insertAll(index + 2, goodsSkuMap[orderGoodsId] ?? []);
    } else {
      dataList.removeRange(
          index + 1, index + (goodsSkuMap[orderGoodsId] ?? []).length + 2);
    }
    update([idGoodsList]);
  }

  goodsSelectCount(InventoryRecordGoods goods) {
    int count = 0;
    goods.skus.forEach((element) => count += element.goodsNum ?? 0);
    return count;
  }

  void loadGoods() {
    InventoryApi.getInventoryOrderDetail(orderId, getAllSku: true)
        .then((value) {
      isSubstandard =
          value.orderGoodsType == OrderStockGoodsTypeEnum.SUBSTANDARD;
      _orderGoodsList.addAll(value.goods);
      value.goods.forEach((element) {
        goodsSkuCountMap[element.id!] = goodsSelectCount(element);
        goodsFlexMap[element.id!] = false;
        goodsSkuMap[element.id!] =
            createSkuList(element.id!, element.orderGoodsVoList);
      });
      dataList.addAll(_orderGoodsList);
      update([idGoodsList]);
    });
  }

  List<SkuData> createSkuList(int goodsId, List<OrderGoodsVo> skus) {
    List<SkuData> list = [];
    skus.forEach((element) {
      List<SkuData> skus = [];
      element.sizes.forEach((element) {
        if ((element.data?.goodsNum ?? 0) > 0) {
          var sku = SkuData.inventory(
            goodsId,
            element.goodsSize?.name,
            element.data?.skuId,
            element.data?.stockNum ?? 0,
            element.data?.goodsNum,
          );
          skus.add(sku);
        }
      });
      if (skus.length > 0) skus[0].colorName = element.goodsColor.name;
      list.addAll(skus);
    });
    return list;
  }
}

import 'dart:collection';

import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enter/inventory_record_create_req_entity.dart';
import 'package:haidai_flutter_module/model/enum/order_stock_goods_type.dart';
import 'package:haidai_flutter_module/model/rep/inventory_record_update_req_entity.dart';
import 'package:haidai_flutter_module/page/inventory/checkCenter/ui/checkDetailsMain.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/goods_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/goods_sku_dialog.dart';
import 'package:haidai_flutter_module/repository/order/inventory_api.dart';

class ShopCarController extends GetxController {
  Map<int, Map<int, int>> carGoodsSkuMap = LinkedHashMap(); //货品对应下的sku录入盘点数
  Map<int, bool> goodsFlexMap = {}; //货品是否展开
  List<dynamic> shopCarListData = []; //购物车列表数据
  Map<int, Map<int, int>> skuRecordIdMap = {}; //记录单货品sku对应的记录id
  Map<int, int> goodsRecordIdMap = {}; //记录单货品对应的记录id
  String? searchText = '';
  bool isSearch = false;
  bool onlyCheck = false;

  ShopCarController({this.onlyCheck = false});

  ///更新购物车货品
  static bIdCarGoods(num goodsId) => "b_id_car_goods$goodsId";

  ///更新外部货品列表
  static bIdCarGoodsSelect(num goodsId) => "b_id_car_goods_select$goodsId";

  ///更新货品展开收起
  static bIdCarGoodsFlex(num goodsId) => "b_id_car_goods_flex$goodsId";

  ///更新购物车数据
  static get bIdCar => "b_id_car";

  ///更新购物车展开收起
  static get bIdCarFlex => "b_id_car_flex";

  ///更新购物车搜索取消控件
  static get bIdCarSearchClose => "b_id_car_search_close";

  ///更新购物车搜索清空控件
  static get bIdCarSearchClear => "b_id_car_search_clear";

  ///初始化购物车数据
  _initShopCarList() {
    // Get.put(GoodsController());
    shopCarListData.clear();
    String? gTag = onlyCheck ? CheckDetailsMain.cGoodsTag : null;
    GoodsController goodsController = Get.find(tag: gTag);
    carGoodsSkuMap.forEach((goodsId, value) {
      shopCarListData.add(goodsController.getGoods(goodsId));
      if (isFlex(goodsId)) {
        shopCarListData.add("skuBar"); //sku头部
        String? color;
        value.forEach((skuId, value) {
          SkuData skuData = goodsController.getGoodsSku(goodsId, skuId);
          SkuData newSkuData = SkuData.create(
              skuData, color == null || skuData.colorName != color);
          shopCarListData.add(newSkuData);
          color = skuData.colorName;
        });
      }
    });
    update([bIdCarFlex]);
  }

  searchGoods(String? text) {
    this.searchText = text;
    if (text == null || text.isEmpty) {
      update([bIdCarSearchClear]);
      _initShopCarList();
      return;
    }
    shopCarListData.clear();
    GoodsController goodsController = Get.find<GoodsController>(tag: onlyCheck ? CheckDetailsMain.cGoodsTag : null);
    goodsController.searchShopCarGoods(text).forEach((goods) {
      int goodsId = goods.id!;
      if (carGoodsSkuMap.containsKey(goodsId)) {
        shopCarListData.add(goods);
        if (isFlex(goodsId)) {
          shopCarListData.add("skuBar"); //sku头部
          String? color;
          carGoodsSkuMap[goodsId]!.forEach((skuId, value) {
            SkuData skuData = goodsController.getGoodsSku(goodsId, skuId);
            SkuData newSkuData = SkuData.create(
                skuData, color == null || skuData.colorName != color);
            shopCarListData.add(newSkuData);
            color = skuData.colorName;
          });
        }
      }
    });
    update([bIdCarFlex, bIdCarSearchClear]);
  }

  ///购物车的货品数
  int get listCount => shopCarListData.length;

  ///获取购物车列表item
  getItemData(int index) {
    return shopCarListData[index];
  }

  ///获取购物货品的sku选择数
  int getGoodsSkuCount(num goodsId, num skuId) =>
      carGoodsSkuMap[goodsId]![skuId]!;

  ///添加货品到购物车
  ///货品id，sku数据，是否是叠加
  addGoods(int goodsId, Map<int, int> skuDataMap, bool add) {
    if (add && carGoodsSkuMap.containsKey(goodsId)) {
      Map<num, int> skuMap = carGoodsSkuMap[goodsId]!;
      skuDataMap.forEach((key, value) {
        if (skuMap.containsKey(key)) {
          skuDataMap[key] = skuDataMap[key]! + skuMap[key]!;
        }
      });
    }
    skuDataMap.removeWhere((key, value) => value == 0);
    carGoodsSkuMap[goodsId] = skuDataMap;
    List<String> updateIds = [bIdCarGoods(goodsId), bIdCar];
    if (!onlyCheck) {
      updateIds.add(bIdCarGoodsSelect(goodsId));
    }
    update(updateIds);
    searchGoods(searchText);
  }

  ///移除该货品
  removeGoods(num goodsId) {
    carGoodsSkuMap.remove(goodsId);
    goodsFlexMap.remove(goodsId);
    update([bIdCarGoodsSelect(goodsId), bIdCar]);
    searchGoods(searchText);
  }

  ///清空购物车
  clearShopCar() {
    print("clear");
    List<String> ids = [];
    ids.add(bIdCar);
    carGoodsSkuMap.forEach((key, value) => ids.add(bIdCarGoodsSelect(key)));
    carGoodsSkuMap.clear();
    goodsFlexMap.clear();
    update(ids);
    searchGoods(searchText);
  }

  ///购物车是否有该货品
  bool hasGoods(num goodsId) {
    return carGoodsSkuMap.containsKey(goodsId);
  }

  ///货品下的sku选择的数量
  int goodsSkuSelectCount(num goodsId, num skuId) {
    if (carGoodsSkuMap.containsKey(goodsId) &&
        carGoodsSkuMap[goodsId]!.containsKey(skuId)) {
      return carGoodsSkuMap[goodsId]![skuId]!;
    }
    return 0;
  }

  ///货品选择的sku总数
  int goodsSelectCount(num goodsId) {
    int count = 0;
    if (!carGoodsSkuMap.containsKey(goodsId)) print("flutter_tag========count$goodsId");
    carGoodsSkuMap[goodsId]!.forEach((key, value) => count += value);
    return count;
  }

  ///购物车总数
  int shopCarCount() {
    int count = 0;
    carGoodsSkuMap
        .forEach((key, value) => value.forEach((key, value) => count += value));
    return count;
  }

  ///是否展开
  bool isFlex(int goodsId) {
    if (!goodsFlexMap.containsKey(goodsId)) {
      goodsFlexMap[goodsId] = false;
    }
    return goodsFlexMap[goodsId]!;
  }

  ///修改展开状态
  changeFlex(int goodsId) {
    goodsFlexMap[goodsId] = !goodsFlexMap[goodsId]!;
    String? gTag = onlyCheck ? CheckDetailsMain.cGoodsTag : null;
    final goodsController = Get.find<GoodsController>(tag: gTag);
    if (goodsController.hasGoodsSku(goodsId)) {
      searchGoods(searchText);
    } else {
      goodsController
          .getSkuList(goodsId)
          .then((value) => searchGoods(searchText));
    }
  }

  ///创建订单
  ///订单id，人员id，店铺id，是否是次品
  Future createOrder(int orderId, int deptId, bool substandard) {
    InventoryRecordCreateReqEntity createReq = InventoryRecordCreateReqEntity();
    createReq.deptId = deptId;
    createReq.orderInventoryId = orderId;
    createReq.orderGoodsType = substandard
        ? OrderStockGoodsTypeEnum.SUBSTANDARD
        : OrderStockGoodsTypeEnum.NORMAL;
    List<InventoryGoodsReq> goodsList = [];
    GoodsController goodsController = Get.find<GoodsController>();
    carGoodsSkuMap.forEach((key, value) {
      List<InventorySkuReq> skuList = [];
      List<SkuData> list = goodsController.goodsSkuMap[key]!;
      list.forEach((element) {
        InventorySkuReq skuReq = InventorySkuReq();
        skuReq.skuId = element.skuId as int;
        skuReq.goodsNum = value[element.skuId] ?? 0;
        skuList.add(skuReq);
        print("flutter_tag==============${skuReq.skuId}===${skuReq.goodsNum}");
      });
      // value.forEach((key, value) {
      //   InventorySkuReq skuReq = InventorySkuReq();
      //   skuReq.skuId = key;
      //   skuReq.goodsNum = value;
      //   skuList.add(skuReq);
      //   print("flutter_tag==============$key===$value");
      // });
      InventoryGoodsReq goodsReq = InventoryGoodsReq();
      goodsReq.goodsId = key;
      goodsReq.skuList = skuList;
      goodsList.add(goodsReq);
    });
    createReq.goodsList = goodsList;
    return InventoryApi.createInventoryRecord(createReq)
        .then((value) => toastMsg("创建成功"));
  }

  ///更新订单
  ///订单id，人员id，店铺id，是否是次品
  Future updateOrder(num recordId) {
    InventoryRecordUpdateReqEntity updateReq = InventoryRecordUpdateReqEntity();
    updateReq.id = recordId as int;
    List<InventoryRecordUpdateReqGoodsList> goodsList = [];
    carGoodsSkuMap.forEach((goodsId, value) {
      List<InventoryRecordUpdateReqGoodsListSkuList> skuList = [];
      value.forEach((skuId, value) {
        InventoryRecordUpdateReqGoodsListSkuList skuReq =
            InventoryRecordUpdateReqGoodsListSkuList();
        skuReq.skuId = skuId;
        skuReq.goodsNum = value;
        if (skuRecordIdMap.containsKey(goodsId) && skuRecordIdMap[goodsId]!.containsKey(skuId)) {
          skuReq.id = skuRecordIdMap[goodsId]![skuId]!;
        }
        skuList.add(skuReq);
      });
      InventoryRecordUpdateReqGoodsList goodsReq =
          InventoryRecordUpdateReqGoodsList();
      goodsReq.goodsId = goodsId;
      goodsReq.skuList = skuList;
      goodsReq.id = goodsRecordIdMap[goodsId];
      goodsList.add(goodsReq);
    });
    updateReq.goodsList = goodsList;
    return InventoryApi.updateInventoryRecord(updateReq)
        .then((value) => toastMsg("更新成功"));
  }

  Future createOrUpdateOrder() {
    final goodsController = Get.find<GoodsController>();
    if (goodsController.recordId == null) {
      return createOrder(goodsController.orderId as int, goodsController.deptId as int,
          goodsController.isSubstandard!);
    } else {
      return updateOrder(goodsController.recordId!);
    }
  }

  openSearch() {
    if (!isSearch) {
      isSearch = true;
      update([bIdCarSearchClose]);
    }
  }

  void closeSearch() {
    if (isSearch) {
      isSearch = false;
      clearSearch();
      update([bIdCarSearchClose]);
    }
  }

  clearSearch() {
    searchGoods('');
  }
}

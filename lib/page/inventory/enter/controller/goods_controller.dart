import 'package:get/get.dart';
import 'package:haidai_flutter_module/common/utils/arguments_utils.dart';
import 'package:haidai_flutter_module/common/utils/toast_utils.dart';
import 'package:haidai_flutter_module/model/enter/order_goods_vo_entity.dart';
import 'package:haidai_flutter_module/model/enum/order_stock_goods_type.dart';
import 'package:haidai_flutter_module/model/enum/select_type.dart';
import 'package:haidai_flutter_module/model/goods.dart';
import 'package:haidai_flutter_module/model/rep/base_page.dart';
import 'package:haidai_flutter_module/model/rep/goods_page_param.dart';
import 'package:haidai_flutter_module/model/rep/inventory_goods_sku_req_entity.dart';
import 'package:haidai_flutter_module/model/rep/order_by.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/search_screen_sort_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/controller/shop_car_controller.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/goods_sku_dialog.dart';
import 'package:haidai_flutter_module/page/inventory/enter/dialog/sort_dialog.dart';
import 'package:haidai_flutter_module/repository/goods_api.dart';
import 'package:haidai_flutter_module/repository/order/inventory_api.dart';

class GoodsController extends GetxController {
  Map<num, Goods> goodsMap = {}; //存放加载过的货品
  Map<num, List<SkuData>> goodsSkuMap = {}; //存放加载过的货品sku
  List<Goods> goodsList = []; //当前货品列表数据

  BasePage _page = new BasePage(); //分页参数
  OrderBy _orderBy = SortDialog.orderBy[0]; //排序参数
  Map<String, List<int>>? _screenData; //筛选参数
  String? searchText; //搜索参数
  bool noMore = false; //是否需要加载，false需要

  num? deptId = ArgUtils.getArgument2num("deptId"); //店铺id
  num? orderId = ArgUtils.getArgument2num("orderId"); //订单id
  bool? isSubstandard = ArgUtils.getArgument2bool("isSubstandard")!; //是否是次品
  num? recordId = ArgUtils.getArgument2num("recordId"); //订单盘点记录id

  bool onlyCheck = false;

  GoodsController({this.onlyCheck = false});

  static final bIdGoodsList = "id_goods_list"; //更新货品列表

  @override
  void onReady() {
    super.onReady();
    initData();
  }

  initData() {
    if (recordId != null) {
      getOrderGoods(); //有盘点记录id就加载记录的货品数据
    }
    if (!onlyCheck) {
      getGoodsList(true);
    }
  }

  //初始化分页参数
  _resetParams() {
    _page.pageNo = 1;
    _page.pageSize = 15;
    GoodsPageParam param = new GoodsPageParam();
    param.orderBy = _orderBy;
    param.deptId = deptId as int;
    param.inventoryId = orderId as int;
    param.selectType = SelectType.INVENTORY;
    param.orderGoodsType = isSubstandard!
        ? OrderStockGoodsTypeEnum.SUBSTANDARD
        : OrderStockGoodsTypeEnum.NORMAL;
    _screenData?.forEach((key, value) {
      if (key == SearchScreenSortController.bIdGoodsBrand) {
        param.goodsBrands = value.isNotEmpty ? value : null;
      } else if (key == SearchScreenSortController.bIdGoodsSeason) {
        param.goodsSeasons = value.isNotEmpty ? value : null;
      } else if (key == SearchScreenSortController.bIdGoodsLabel) {
        param.goodsLabels = value.isNotEmpty ? value : null;
      } else if (key == SearchScreenSortController.bIdGoodsYear) {
        param.goodsYears = value.isNotEmpty ? value : null;
      } else if (key == SearchScreenSortController.bIdGoodsClassify) {
        param.goodsClassify = value.isNotEmpty ? (value[0]) : null;
      } else if (key == SearchScreenSortController.bIdGoodsClassifyMiddle) {
        param.goodsClassifyMiddle =
            value.isNotEmpty ? (value[0]) : null;
      } else if (key == SearchScreenSortController.bIdGoodsClassifySmall) {
        param.goodsClassifySmall = value.isNotEmpty ? (value[0]) : null;
      }
    });
    _page.param = param;
    goodsList.clear();
  }

  //初始化分页参数
  _resetSearchParams() {
    _page.pageNo = 1;
    _page.pageSize = 15;
    GoodsPageParam param = new GoodsPageParam();
    param.deptId = deptId as int;
    param.inventoryId = orderId as int;
    param.selectType = SelectType.INVENTORY;
    param.goodsNameSerial = searchText;
    param.orderGoodsType = isSubstandard!
        ? OrderStockGoodsTypeEnum.SUBSTANDARD
        : OrderStockGoodsTypeEnum.NORMAL;
    _page.param = param;
    goodsList.clear();
  }

  changeOrderBy(OrderBy orderBy) {
    this._orderBy = orderBy;
    getGoodsList(true);
  }

  changeScreenData(Map<String, List<int>> screenData) {
    this._screenData = screenData;
    getGoodsList(true);
  }

  ///盘点记录的货品
  Future getOrderGoods({String? tag}) async {
    return await InventoryApi.getInventoryOrderDetail(recordId!,getAllSku: true).then((value) {
      ShopCarController carController = Get.find<ShopCarController>(tag: tag);
      value.goods.forEach((goods) {
        Map<int, int> skuMap = {};
        int goodsId = goods.goodsId!;
        goodsMap[goodsId] = Goods().fromJson(goods.storeGoodsBaseDo.toJson());
        goodsMap[goodsId]!.stockNum = goods.stockNum;
        carController.goodsRecordIdMap[goodsId] = goods.id!;
        goods.skus.forEach((sku) {
          skuMap[sku.skuId!] = sku.goodsNum ?? 0;
          if (!carController.skuRecordIdMap.containsKey(goodsId)) {
            carController.skuRecordIdMap[goodsId] = {};
          }
          carController.skuRecordIdMap[goodsId]![sku.skuId!] = sku.id!;
        });
        //订单数据添加到购物车
        carController.addGoods(goodsId, skuMap, false);
      });
      update([bIdGoodsList]);
    });
  }

  //获取货品列表
  //reset：是否是重置，不是重置即下一页
  Future getGoodsList(bool reset) async {
    if (reset) {
      if (searchText == null) {
        _resetParams();
      } else {
        _resetSearchParams();
      }
    } else if (noMore) {
      return;
    } else {
      _page.pageNo = _page.pageNo! + 1;
    }
    return await GoodsApi.page(_page).then((entity) {
      noMore = entity.length < _page.pageSize!;
      entity.forEach((element) => goodsMap[element.id!] = element);
      goodsList.addAll(entity);
      update([bIdGoodsList]);
    });
  }

  //获取货品sku列表
  Future<List<SkuData>> getSkuList(int goodsId, {bool showLoad = false}) async {
    if (goodsSkuMap.containsKey(goodsId)) {
      return goodsSkuMap[goodsId]!;
    }
    InventoryGoodsSkuReqEntity skuReq = InventoryGoodsSkuReqEntity();
    skuReq.getAllSku = true;
    skuReq.goodsId = goodsId;
    skuReq.orderGoodsType = isSubstandard!
        ? OrderStockGoodsTypeEnum.SUBSTANDARD
        : OrderStockGoodsTypeEnum.NORMAL;
    skuReq.orderInventoryId = orderId as int;
    List<OrderGoodsVoEntity> list =
        await InventoryApi.getInventoryGoodsSku(skuReq, showLoad: showLoad);
    List<SkuData> skuList = buildSkuData(goodsId, list);
    goodsSkuMap[goodsId] = skuList;
    return skuList;
  }

  ///转化为skuData
  List<SkuData> buildSkuData(
      int goodsId, List<OrderGoodsVoEntity> skuInfoList) {
    List<SkuData> skuList = [];
    skuInfoList.forEach((element) {
      int len = element.sizes?.length ?? 0;
      for (int i = 0; i < len; i++) {
        OrderGoodsVoSize infoSize = element.sizes![i];
        skuList.add(SkuData(goodsId, element.goodsColor?.name ?? "",
            infoSize.goodsSize.name, i == 0, infoSize.data));
      }
    });
    return skuList;
  }

  ///获取指定货品
  Goods? getGoods(num goodsId) => goodsMap[goodsId];

  ///获取指定sku数据
  SkuData getGoodsSku(num goodsId, num skuId) =>
      goodsSkuMap[goodsId]!.firstWhere((element) => element.skuId == skuId);

  ///判断是否有sku数据
  bool hasGoodsSku(num goodsId) => goodsSkuMap.containsKey(goodsId);

  List<Goods> searchShopCarGoods(String text) {
    List<Goods> goods = [];
    goodsMap.forEach((key, value) {
      if ((value.goodsSerial?.contains(text) ?? false) ||
          (value.goodsName?.contains(text) ?? false)) {
        goods.add(value);
      }
    });
    return goods;
  }

  searchGoods(String? text) {
    this.searchText = text;
    getGoodsList(true);
  }

  Future deleteData() {
    return InventoryApi.deleteInventoryOrder(recordId!)
        .then((value) => toastMsg("删除成功"));
  }
}
